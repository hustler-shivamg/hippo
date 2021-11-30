import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hippo/base/base_controller.dart';
import 'package:hippo/models/user.dart';
import 'package:hippo/utils/constants.dart';
import 'package:hippo/utils/styling.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

String greetingMessage() {
  var timeNow = DateTime.now().hour;

  if (timeNow <= 12) {
    return 'GoodMorning'.tr;
  } else if ((timeNow > 12) && (timeNow <= 16)) {
    return 'GoodAfternoon'.tr;
  } else if ((timeNow > 16) && (timeNow < 20)) {
    return 'GoodEvening'.tr;
  } else {
    return 'GoodNight'.tr;
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 210.h,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 210.h,
                    child: SvgPicture.asset(
                      'assets/images/home_inner_bg.svg',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 44.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.only(left: 10.w),
                            width: 30.w,
                            height: 30.h,
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/images/chevron.svg',
                                width: 12.w,
                                height: 20.5.h,
                                color: Colors.white,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 24.w),
                          // alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {},
                            child: SvgPicture.asset(
                              'assets/images/profile_option.svg',
                              fit: BoxFit.contain,
                              height: 27.w,
                              width: 27.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(
                      left: 27.w,
                      right: 20.w,
                      top: 105.h,
                    ),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Hello'.tr+'\n$name',
                          style: AppTheme.dashboard_title_2,
                        ),
                        SvgPicture.asset(
                          'assets/images/logo_new.svg',
                          fit: BoxFit.contain,
                          height: 68.5.h,
                          width: 62.w,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      height: 72.h,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/fav_service.svg',
                            width: 29.w,
                            height: 26.h,
                            color: const Color(0xFF92E0FF),
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            width: 18.w,
                          ),
                          Text(
                            'Favorites'.tr,
                            style: TextStyle(
                              fontFamily: Constants.FONT_ARIEN,
                              fontSize: 18.sp,
                              color: const Color(0xff707070),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Get.toNamed(RouterName.myFav);
                    },
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffe2e2e2),
                    ),
                  ),
                  InkWell(
                    onTap: ()async{
                      var data = await Get.toNamed(RouterName.personalDetail);
                      if(data!=null){
                        setState(() {
                          initState();
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      height: 72.h,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/profile_icon.svg',
                            width: 29.w,
                            height: 26.h,
                            color: const Color(0xFF92E0FF),
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            width: 18.w,
                          ),
                          Text(
                            'Profile'.tr,
                            style: TextStyle(
                              fontFamily: Constants.FONT_ARIEN,
                              fontSize: 18.sp,
                              color: const Color(0xff707070),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffe2e2e2),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouterName.myReviews);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      height: 72.h,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/star_icon.svg',
                            width: 29.w,
                            height: 26.h,
                            color: const Color(0xFF92E0FF),
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            width: 18.w,
                          ),
                          Text(
                            'MyReviews'.tr,
                            style: TextStyle(
                              fontFamily: Constants.FONT_ARIEN,
                              fontSize: 18.sp,
                              color: const Color(0xff707070),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffe2e2e2),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    height: 72.h,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/bug_icon.svg',
                          width: 29.w,
                          height: 26.h,
                          color: const Color(0xFF92E0FF),
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          width: 18.w,
                        ),
                        Text(
                          'ReportBug'.tr,
                          style: TextStyle(
                            fontFamily: Constants.FONT_ARIEN,
                            fontSize: 18.sp,
                            color: const Color(0xff707070),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffe2e2e2),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  var name = "";

  @override
  void initState() {
    final box = GetStorage();
    var user = User.fromJson(box.read(MyConfig.USER_DATA));

    name = user.enFirstName ?? "";
  }
}
