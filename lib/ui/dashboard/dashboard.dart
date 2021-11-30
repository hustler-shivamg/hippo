import 'dart:io' show Platform;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippo/base/base_controller.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/base/networking/api.dart';
import 'package:hippo/ui/dashboard/dashboard_binding.dart';
import 'package:hippo/utils/constants.dart';
import 'package:hippo/utils/styling.dart';
import 'package:flutter/services.dart';

class DashboardScreen extends BaseView<DashboardController> {
  bool isExpand = false;
  bool canExpand = false;
  final _controller = ScrollController();

  void initState() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }


  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(context),
    );
  }


  _body(BuildContext context) {
    if (controller.screenStateIsLoading)
      return Center(child: CircularProgressIndicator());
    if (controller.screenStateIsError) return Text(XR().string.error_message);
    if (controller.screenStateIsOK) {
      canExpand = controller.category.length > 6;

      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(

          decoration: new BoxDecoration(
              // color: Colors.white,
              gradient: new LinearGradient(
                  colors: [
                    Color(0xff92e0ff),
                    Colors.white,
                  ],
                  stops: [0.5, 0.5],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  tileMode: TileMode.repeated
              )
          ),
          child: SingleChildScrollView(
            // physics: new ClampingScrollPhysics(),
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 306.h,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 276.h,
                          child: SvgPicture.asset(
                            'assets/images/home_bg_new.svg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 44.h, left: 16.w),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Stack(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SimpleDialog(
                                          title: Text('change_lang'.tr),
                                          children: <Widget>[
                                            SimpleDialogOption(
                                              child: Row(
                                                children: [
                                                  Image(
                                                    image: AssetImage(
                                                        'assets/images/english.png'),
                                                    height: 24.w,
                                                    width: 24.w,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'english_lang'.tr,
                                                    style: TextStyle(
                                                        color: box.read(MyConfig
                                                            .LANGUAGE) ==
                                                            'en'
                                                            ? Color(0xff0c6bc2)
                                                            : Colors.black),
                                                  ),
                                                ],
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                controller.changeLanguageByCode("en");
                                              },
                                            ),
                                            SimpleDialogOption(
                                              child: Row(
                                                children: [
                                                  Image(
                                                    image: AssetImage(
                                                        'assets/images/armenian.png'),
                                                    height: 24.w,
                                                    width: 24.w,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'arm_lang'.tr,
                                                    style: TextStyle(
                                                        color: box.read(MyConfig
                                                            .LANGUAGE) ==
                                                            'arm'
                                                            ? Color(0xff0c6bc2)
                                                            : Colors.black),
                                                  ),
                                                ],
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                controller
                                                    .changeLanguageByCode("arm");
                                              },
                                            )
                                          ],
                                        );
                                      },
                                    );
                                    // controller.changeLanguage();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 6.h),
                                    height: 28.h,
                                    child: Text(
                                      box.read(MyConfig.LANGUAGE) == 'arm'
                                          ? "En"
                                          : 'Arm',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14.sp,
                                        height: 1,
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      border: Border.all(
                                          width: 1.0, color: const Color(0xffffffff)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //         print("Clicked");
                        //         if (controller.isLoggedIn()) {
                        //     Get.toNamed(RouterName.dashboard);
                        //   } else {
                        //   Get.showSnackbar(GetBar(
                        //     backgroundColor: Colors.red,
                        //     icon: Icon(Icons.error, color: Colors.white),
                        //     mainButton: TextButton(
                        //       child: Text(
                        //         "login".tr,
                        //         style: TextStyle(color: Colors.white),
                        //       ),
                        //       onPressed: () {
                        //         Get.toNamed(RouterName.login);
                        //       },
                        //     ),
                        //     messageText: Text("loginRequired".tr,
                        //         style: TextStyle(color: Colors.white)),
                        //     duration: Duration(seconds: 3),
                        //   ));
                        // }

                        Container(
                          margin: EdgeInsets.only(top: 44.h, right: 24.w),
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              if (controller.isLoggedIn()) {
                                Get.toNamed(RouterName.main_home);
                              } else {
                                Get.toNamed(RouterName.login);
                              }
                            },
                            child: SvgPicture.asset(
                              'assets/images/profile_option.svg',
                              fit: BoxFit.contain,
                              height: 27.w,
                              width: 27.w,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 27.w,
                            right: 20.w,
                            top: 95.h,
                          ),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'welcome'.tr,
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
                        Container(
                          margin:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 240.h),
                          width: double.infinity,
                          height: 64.h,
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                RouterName.search,
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 11.w,
                                ),
                                SvgPicture.asset(
                                  'assets/images/search_icon.svg',
                                  fit: BoxFit.contain,
                                  width: 21.w,
                                  height: 21.w,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 16.w, right: 8.w),
                                    child: Text(
                                      "Search".tr,
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        color: Color(0xffD8D8D8),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.11),
                                offset: Offset(0, 3.0),
                                blurRadius: 12.r,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 10.h),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 1.4),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0.0),
                        itemCount: canExpand
                            ? isExpand
                            ? controller.category.length
                            : 6
                            : controller.category.length,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {
                              decideNextPage(controller.category[i].id!,
                                  controller.category[i].categoryName!);

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (_) => PediatriciansScreen()));
                            },
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CachedNetworkImage(
                                    placeholder: (context, url) => Container(
                                      child: CircularProgressIndicator(),
                                      height: 48.w,
                                      width: 48.w,
                                    ),
                                    imageUrl:
                                    controller.category[i].categoryImage ?? "",
                                    height: 43.w,
                                    width: 43.w,
                                  ),
                                  // SvgPicture.asset(
                                  //   'assets/images/ic_caregiver.svg',
                                  //   height: 43.h,
                                  //   width: 43.w,
                                  // ),
                                  SizedBox(
                                    height: 10.h,
                                  ),

                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                                    child: AutoSizeText(
                                      controller.category[i].categoryName ?? "",textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTheme.dashboard_title,
                                      maxLines: 1,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 20.h,
                  ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: canExpand
                          ? InkWell(
                        onTap: () {
                          isExpand = !isExpand;
                          controller.refresh();
                        },
                        child: Container(
                          color: Colors.white,
                          child: SvgPicture.asset(
                            isExpand
                                ? 'assets/images/collapse_new.svg'
                                : 'assets/images/expand.svg',
                            fit: BoxFit.contain,
                            height: 17.h,
                            width: 46.w,
                          ),
                        ),
                      )
                          : Container(),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 20.h,
                  ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  Container(
                    height: 13,
                    width: double.infinity,
                    color: Color(0xffF4F4F4),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          itemCount: controller.newList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = controller.newList[index];
                            return Container(
                              // padding: EdgeInsets.only(left: 20.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.w),
                                    child: Text(
                                      data.categoryName ?? "",
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 18.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 23.h,
                                  ),
                                  SizedBox(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: ListView.builder(
                                          controller: _controller,
                                          padding: EdgeInsets.only(
                                            left: 10.w,
                                          ),
                                          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                          // physics: new ClampingScrollPhysics(),
                                          // shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                          data.serviceProviders?.length ?? 0,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            var serviceProviderData =
                                            data.serviceProviders?[index];
                                            return InkWell(
                                              onTap: () {
                                                if (serviceProviderData?.business ==
                                                    true) {
                                                  var map = new Map<String, String>();
                                                  map["id"] = serviceProviderData?.id
                                                      .toString() ??
                                                      "";
                                                  map["type"] = "business";
                                                  Get.toNamed(
                                                      RouterName
                                                          .kinderGardenDetailScreen,
                                                      parameters: map);
                                                } else {
                                                  var map = new Map<String, String>();
                                                  map["id"] =
                                                      (serviceProviderData?.id ?? 0)
                                                          .toString();
                                                  map["type"] = "service_provider";
                                                  Get.toNamed(
                                                      RouterName.caregiverDetail,
                                                      parameters: map);
                                                }

                                                // decideNextPage(
                                                //     serviceProviderData?.categoryId ??
                                                //         0,
                                                //     serviceProviderData?.categoryName ??
                                                //         "");
                                                // var map = new Map<String, String>();
                                                // map["id"] = serviceProviderData?.id.toString()??"";
                                                // map["type"] = "business";
                                                // Get.toNamed(RouterName.kinderGardenDetailScreen,
                                                //     parameters: map);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(right: 0.w),
                                                width:
                                                serviceProviderData?.business ==
                                                    true
                                                    ? 271.w
                                                    : 154.w,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    serviceProviderData?.business ==
                                                        true
                                                        ? Padding(
                                                      padding: EdgeInsets.only(left: 10.h),
                                                      child: Container(
                                                        height: 181.h,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(5.r),
                                                          image: DecorationImage(
                                                            image:
                                                            CachedNetworkImageProvider(
                                                              serviceProviderData
                                                                  ?.businessLogo ??
                                                                  "",
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                        : Platform.isIOS
                                                        ? Center(
                                                      child: ClipOval(
                                                        child:
                                                        CachedNetworkImage(
                                                          imageUrl:
                                                          serviceProviderData
                                                              ?.profilePic ??
                                                              "",
                                                          height: 124.h,
                                                          width: 124.h,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    )
                                                        : Center(
                                                      child: ClipOval(
                                                        child:
                                                        CachedNetworkImage(
                                                          imageUrl:
                                                          serviceProviderData
                                                              ?.profilePic ??
                                                              "",
                                                          height: 154.h,
                                                          width: 154.h,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    serviceProviderData!.business == true ?
                                                    Center(
                                                      child: Text(
                                                        serviceProviderData.name ?? "",
                                                        style: TextStyle(
                                                          fontFamily:
                                                          Constants.FONT_ARIEN,
                                                          fontSize: 18.sp,
                                                          color:
                                                          const Color(0xff000000),
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        textAlign: TextAlign.left,
                                                      ),
                                                    ) :
                                                    Center(
                                                      child: Text(
                                                        serviceProviderData.firstName ?? "",
                                                        style: TextStyle(
                                                          fontFamily:
                                                          Constants.FONT_ARIEN,
                                                          fontSize: 18.sp,
                                                          color:
                                                          const Color(0xff000000),
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        textAlign: TextAlign.left,
                                                      ),
                                                    ),
                                                    // SizedBox(
                                                    //   height: 2.h,
                                                    // ),
                                                    Expanded(
                                                      child: Center(
                                                        child: Text(
                                                          [
                                                            serviceProviderData.city
                                                          ]
                                                              .where((element) =>
                                                          element != null &&
                                                              element.isNotEmpty)
                                                              .toList()
                                                              .join(", "),
                                                          style: TextStyle(
                                                            fontFamily:
                                                            Constants.FONT_ARIEN,
                                                            fontSize: 14.sp,
                                                            color:
                                                            const Color(0xff757280),
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                          maxLines: 1,
                                                          overflow:
                                                          TextOverflow.ellipsis,
                                                          textAlign: TextAlign.left,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          RatingBar(
                                                            itemSize: 12.r,
                                                            ignoreGestures: true,
                                                            initialRating:
                                                            serviceProviderData
                                                                .averageRating
                                                                ?.toDouble() ??
                                                                0,
                                                            direction:
                                                            Axis.horizontal,
                                                            allowHalfRating: false,
                                                            itemCount: 5,
                                                            ratingWidget:
                                                            RatingWidget(
                                                              full: SvgPicture.asset(
                                                                'assets/images/heart_filled.svg',
                                                                color:
                                                                Color(0xffFF7BAC),
                                                                fit: BoxFit.contain,
                                                              ),
                                                              half: SvgPicture.asset(
                                                                'assets/images/heart.svg',
                                                                color:
                                                                Color(0xffFF7BAC),
                                                                fit: BoxFit.contain,
                                                              ),
                                                              empty: SvgPicture.asset(
                                                                'assets/images/fav_service.svg',
                                                                color:
                                                                Color(0xffFF7BAC),
                                                                fit: BoxFit.contain,
                                                              ),
                                                            ),
                                                            itemPadding:
                                                            EdgeInsets.symmetric(
                                                                horizontal:
                                                                1.5.w),
                                                            onRatingUpdate: (rating) {
                                                              print(rating);
                                                            },
                                                          ),
                                                          SizedBox(
                                                            width: 4.w,
                                                          ),
                                                          Text(
                                                            serviceProviderData
                                                                .reviewsCount
                                                                ?.toString() ??
                                                                "0",
                                                            style: TextStyle(
                                                              fontFamily: Constants
                                                                  .FONT_ARIEN,
                                                              fontSize: 12.sp,
                                                              color: const Color(
                                                                  0xFF757280),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      height: data.type == "business"
                                          ? 260.h
                                          : Platform.isIOS
                                          ? 210.h
                                          : 230.h),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 20.h),
                                height: 13.h,
                                color: const Color(0xffF4F4F4),
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // controller.isLoggedIn()
                  //     ? SizedBox()
                  //     : Container(
                  //         margin: EdgeInsets.only(bottom: 10.h),
                  //         child: Row(
                  //           mainAxisSize: MainAxisSize.max,
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             InkWell(
                  //               onTap: () {
                  //                 Get.toNamed(RouterName.signup);
                  //               },
                  //               child: Text(
                  //                 "signup".tr,
                  //                 style: AppTheme.dashboard_title_underline,
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               width: 60.w,
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 Get.toNamed(RouterName.login);
                  //               },
                  //               child: Text(
                  //                 "login".tr,
                  //                 style: AppTheme.dashboard_title_underline,
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                ],
              ),
            ),
          ),
        )
      );
    }
  }

  decideNextPage(int categoryId, String title) {
    var routeName = "";
    if (categoryId == CategoryType.CAREGIVERS) {
      routeName = RouterName.caregiverList;
    } else if (categoryId == CategoryType.DRIVERS) {
      routeName = RouterName.caregiverList;
    } else if (categoryId == CategoryType.KINDERGARDENS) {
      routeName = RouterName.entertermentList;
    } else if (categoryId == CategoryType.PEDIATRICIANS) {
      routeName = RouterName.caregiverList;
    } else if (categoryId == CategoryType.ENTERTAINMENT) {
      routeName = RouterName.entertermentList;
    } else if (categoryId == CategoryType.OTHER) {
      routeName = RouterName.entertermentList;
    } else {
      routeName = RouterName.otherServiceList;
    }
    Get.toNamed(routeName, arguments: [categoryId.toString(), title]);
    // Get.toNamed(routeName, arguments: ["6", title]);
  }
}
