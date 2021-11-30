import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/ui/entertainment/entertainment_binding.dart';
import 'package:hippo/utils/constants.dart';
import 'package:hippo/utils/styling.dart';

class EntertainmentScreen extends BaseView<EntertainmentController> {
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
    if (controller.screenStateIsLoading)
      return Center(child: CircularProgressIndicator());
    if (controller.screenStateIsError) return Text(XR().string.error_message);
    if (controller.screenStateIsOK) {
      return Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                              // FilterData? filterData = await Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (_) => FilterScreen(
                              //           educations: controller.educations,
                              //           workExperiences:
                              //           controller.workExperiences,
                              //           age: controller.age,
                              //           filterData: controller.filterData,
                              //         )));
                              //
                              // if (filterData != null) {
                              //   if (filterData.isReset == false) {
                              //     controller.applyFilter(filterData);
                              //   } else {
                              //     controller.resetList();
                              //   }
                              // }
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
                  // physics: new ClampingScrollPhysics(),
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
                                  color: controller.selectedCityId == data?.id ? Colors.white: Color(0xFF707070),
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
                // physics: ClampingScrollPhysics(),
                physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                controller: _controller,
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: 18.h),
                      itemCount: controller.dataList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = controller.dataList[index];
                        return Padding(
                          padding: EdgeInsets.only(left: 0.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.w,),
                                    child: Align(
                                      child: Text(
                                        data.subCategoryName ?? "",
                                        style: TextStyle(
                                          fontFamily: Constants.FONT_ARIEN,
                                          fontSize: 18.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                  InkWell(
                                    child: Align(
                                      child: Padding(
                                        child: RotatedBox(
                                          child: SvgPicture.asset(
                                            'assets/images/chevron.svg',
                                            width: 12.w,
                                            color: Colors.black,
                                            height: 20.5.h,
                                            fit: BoxFit.contain,
                                          ),
                                          quarterTurns: 2,
                                        ),
                                        padding: EdgeInsets.only(right: 15.w),
                                      ),
                                      alignment: Alignment.centerRight,
                                    ),
                                    onTap: () {
                                      print(jsonEncode(data.cities));

                                      Get.toNamed(
                                          RouterName.serviceProviderList,
                                          arguments: [
                                            data.serviceProviders,
                                            data.subCategoryName,
                                            data.cities
                                          ]);
                                    },
                                  ),
                                ],
                                alignment: Alignment.center,
                              ),
                              SizedBox(
                                height: 28.h,
                              ),
                              SizedBox(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: ListView.builder(
                                    padding: EdgeInsets.only(
                                      left: 20.w,
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
                                          data.serviceProviders != null
                                              ? data.serviceProviders![index]
                                              : null;
                                      return InkWell(
                                        onTap: () {
                                          var map = new Map<String, String>();
                                          map["id"] = serviceProviderData?.id
                                                  .toString() ??
                                              "";
                                          map["type"] = "business";
                                          Get.toNamed(
                                              RouterName
                                                  .kinderGardenDetailScreen,
                                              parameters: map);
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (_) =>
                                          //             EntertainmentDetailScreen()));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(right: 8.w),
                                          width: 271.w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 181.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
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
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                serviceProviderData?.name ?? "",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily:
                                                      Constants.FONT_ARIEN,
                                                  fontSize: 18.sp,
                                                  color:
                                                      const Color(0xff000000),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    RatingBar(
                                                      itemSize: 16.r,
                                                      ignoreGestures: true,
                                                      initialRating:
                                                          serviceProviderData
                                                                  ?.averageRating
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
                                                              ?.reviews
                                                              .toString() ??
                                                          "0",
                                                      style: TextStyle(
                                                        fontFamily: Constants
                                                            .FONT_ARIEN,
                                                        fontSize: 18.sp,
                                                        color: const Color(
                                                            0xFF757280),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  [
                                                    serviceProviderData?.city,
                                                    serviceProviderData?.state
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
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                height: 270.h,
                              ),
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
            ),
          ],
        ),
      );
    }
  }
}
