import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/filter_data.dart';
import 'package:hippo/ui/careGiver/caregiver_binding.dart';
import 'package:hippo/ui/filter.dart';
import 'package:hippo/utils/constants.dart';
import 'package:hippo/utils/styling.dart';
import 'package:hippo/x_utils/utilities.dart';
import 'package:hippo/x_utils/widgets/transparent_image.dart';

import '../caregiverDetail.dart';

class CaregiversScreen extends BaseView<CaregiverController> {
  ScrollController? _controller;
  bool visible = true;

  _scrollListener() {
    if (_controller!.offset <= _controller!.position.minScrollExtent + 60.h &&
        !_controller!.position.outOfRange) {
      //reach the top
      visible = true;
      controller.update();
    } else {
      visible = false;
      controller.update();
    }
  }

  @override
  Widget vBuilder(BuildContext context) {
    _controller = ScrollController();
    _controller!.addListener(_scrollListener);
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    if (controller.screenStateIsLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (controller.screenStateIsError) return Text(XR().string.error_message);
    if (controller.screenStateIsOK) {
      return Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 108.h,
              width: double.infinity,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/images/inner_bg.svg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 30.h,
                      margin: EdgeInsets.only(bottom: 18.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
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
                          Expanded(
                            child: Center(
                              child: Text(
                                controller.title,
                                style: AppTheme.dashboard_title_new,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              FilterData? filterData = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => FilterScreen(
                                            educations: controller.educations,
                                            workExperiences:
                                                controller.workExperiences,
                                            age: controller.age,
                                            filterData: controller.filterData,
                                          )));

                              if (filterData != null) {
                                if (filterData.isReset == false) {
                                  controller.applyFilter(filterData);
                                } else {
                                  controller.resetList();
                                }
                              }
                            },
                            child: Container(
                              width: 54.w,
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/images/filter_icon.svg',
                                  width: 24.w,
                                  color: Colors.white,
                                  height: 21.h,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 58.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              width: double.infinity,
              color: const Color(0xffF0F0F0),
              child: ListView.builder(
                  physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.cities?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    var data = controller.cities != null
                        ? controller.cities![index]
                        : null;
                    return Center(
                      child: InkWell(
                        onTap: () {
                          controller.searchCityWise(data?.id);
                        },
                        child: Container(
                          height: 35.h,
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                data?.name ?? "",
                                style: TextStyle(
                                  fontFamily: Constants.FONT_ARIEN,
                                  fontSize: 13.sp,
                                  color:  controller.selectedCityId == data?.id?Colors.white: Color(0xFF707070),
                                  letterSpacing: -0.26,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: controller.selectedCityId == data?.id
                                ?  Color(0xFF92e0ff)
                                : Colors.white,
                            border: Border.all(
                              width: 1.r,
                              color: const Color(0xFFE6E6E6),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                // physics: new ClampingScrollPhysics(),
                child: Column(
                  children: [
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 25.h, bottom: 18.h),
                      itemCount: controller.dataList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = controller.dataList[index];
                        return InkWell(
                          onTap: () {
                            var map = new Map<String, String>();
                            map["id"] = data.id.toString();
                            map["type"] = data.business == true
                                ? "business"
                                : "service_provider";
                            Get.toNamed(RouterName.caregiverDetail,
                                parameters: map);

                            //Get.offAllNamed(RouterName.dashboard, predicate: (route) => false);
                            // Get.until(
                            //         (route) => (route.settings.name == RouterName.dashboard));
                            //  Get.offAllNamed(
                            //    RouterName.dashboard,
                            //          (route) => (route.settings.name == "/"));
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (_) => CaregiverDetailScreen()));
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 18.w,
                              right: 18.w,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // FadeInImage.memoryNetwork( placeholder: kTransparentImage,
                                //   image:  data.profilePic ?? "",    width: 110.w,
                                //   height: 110.w,fit: BoxFit.cover),

                                ClipOval(
                                  child: CachedNetworkImage(
                                    width: 110.w,
                                    height: 110.w,
                                    fadeInDuration: const Duration(seconds: 0),
                                    fadeOutDuration: const Duration(seconds: 0),
                                    imageUrl: data.profilePic ?? "",
                                    placeholder: (context, url) {
                                      return Container(
                                          color: Colors.grey.shade300,
                                          child: Icon(Icons.person));
                                    },
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // Container(
                                //   width: 110.w,
                                //   height: 110.w,
                                //   decoration: BoxDecoration(
                                //     image: DecorationImage(
                                //       image: CachedNetworkImageProvider(
                                //         data.profilePic ?? "",
                                //
                                //       ),
                                //       fit: BoxFit.cover,
                                //     ),
                                //     borderRadius: BorderRadius.all(
                                //         Radius.elliptical(9999.0, 9999.0)),
                                //     border: Border.all(
                                //         width: 1.r,
                                //         color: const Color(0x39707070)),
                                //   ),
                                // ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data.firstName ?? ""} ${data.lastName ?? ""}"
                                          .trim(),
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 17.sp,
                                        color: const Color(0xff707070),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          RatingBar(
                                            itemSize: 12.r,
                                            ignoreGestures: true,
                                            initialRating: data.averageRating
                                                    ?.toDouble() ??
                                                0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: false,
                                            itemCount: 5,
                                            ratingWidget: RatingWidget(
                                              full: SvgPicture.asset(
                                                'assets/images/heart_filled.svg',
                                                color: Color(0xffFF7BAC),
                                                fit: BoxFit.contain,
                                              ),
                                              half: SvgPicture.asset(
                                                'assets/images/heart.svg',
                                                color: Color(0xffFF7BAC),
                                                fit: BoxFit.contain,
                                              ),
                                              empty: SvgPicture.asset(
                                                'assets/images/fav_service.svg',
                                                color: Color(0xffFF7BAC),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 1.5.w),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          Text(
                                            (data.reviewsCount ?? 0).toString(),
                                            style: TextStyle(
                                              fontFamily: Constants.FONT_ARIEN,
                                              fontSize: 13.sp,
                                              color: const Color(0xFF757280),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${Utilities().getAge(data.dateOfBirth ?? "")}" +
                                              "Y".tr,
                                          style: TextStyle(
                                            fontFamily: Constants.FONT_ARIEN,
                                            fontSize: 16.sp,
                                            color: const Color(0xff707070),
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xff707070),
                                          ),
                                          height: 5.h,
                                          width: 5.h,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${data.city != null && data.city!.isNotEmpty ? data.city! + ", " : ""}${data.state ?? ""}"
                                                .trimRight(),

                                            style: TextStyle(
                                              fontFamily: Constants.FONT_ARIEN,

                                              fontSize: 14.sp,
                                              color: const Color(0xff707070),
                                              fontWeight: FontWeight.w700,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${data.pricePerHour != null ? "${data.pricePerHour} / " : ""}" +
                                              "${data.pricePerDay != null ? "${data.pricePerDay} / " : ""}" +
                                              "${data.pricePerMonth != null ? "${data.pricePerMonth}" : ""}" +
                                              " դր",
                                          style: TextStyle(
                                            fontFamily: Constants.FONT_ARIEN,
                                            fontSize: 10.sp,
                                            color: const Color(0xff707070),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    )
                                  ],
                                ))
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        thickness: 1.h,
                        height: 32.h,
                        color: const Color(0xffE2E2E2),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
