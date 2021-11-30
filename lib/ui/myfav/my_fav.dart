import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/ui/myfav/my_fav_binding.dart';
import 'package:hippo/utils/constants.dart';
import 'package:hippo/utils/styling.dart';

class MyFavScreen extends BaseView<MyFavController> {
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
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 30.h,
                      margin: EdgeInsets.only(bottom: 18.h),
                      child: Stack(
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
                          Center(
                            child: Text(
                              'Favorites'.tr,
                              style: AppTheme.dashboard_title_new,
                            ),
                          ),
                          Container(
                            width: 54.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                // shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 18.h),
                itemCount: controller.newList.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = controller.newList[index];
                  return Container(
                    padding: EdgeInsets.only(top: 0.h),
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
                              padding: EdgeInsets.only(
                                left: 10.w,
                              ),
                              physics: BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              // shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: data.serviceProviders?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                var serviceProviderData =
                                    data.serviceProviders?[index];
                                return InkWell(
                                  onTap: () {
                                    if (serviceProviderData?.business == true) {
                                      var map = new Map<String, String>();
                                      map["id"] =
                                          serviceProviderData?.id.toString() ??
                                              "";
                                      map["type"] = "business";
                                      Get.toNamed(
                                          RouterName.kinderGardenDetailScreen,
                                          parameters: map);
                                    } else {
                                      var map = new Map<String, String>();
                                      map["id"] = (serviceProviderData?.id ?? 0)
                                          .toString();
                                      map["type"] = "service_provider";
                                      Get.toNamed(RouterName.caregiverDetail,
                                          parameters: map);
                                    }
                                    // var map = new Map<String, String>();
                                    // map["id"] = serviceProviderData?.id.toString()??"";
                                    // map["type"] = "business";
                                    // Get.toNamed(RouterName.kinderGardenDetailScreen,
                                    //     parameters: map);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(right: 0.w),
                                    width: serviceProviderData?.business == true
                                        ? 271.w
                                        : 154.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        serviceProviderData?.business == true
                                            ? Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.h),
                                                child: Container(
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
                                              )
                                            : Platform.isIOS
                                                ? Center(
                                                    child: ClipOval(
                                                      child: CachedNetworkImage(
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
                                                      child: CachedNetworkImage(
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
                                        serviceProviderData!.business == true
                                            ? Center(
                                                child: Text(
                                                  serviceProviderData.name ??
                                                      "",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        Constants.FONT_ARIEN,
                                                    fontSize: 18.sp,
                                                    color:
                                                        const Color(0xff000000),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                ),
                                              )
                                            : Center(
                                                child: Text(
                                                  serviceProviderData
                                                          .firstName ??
                                                      "",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        Constants.FONT_ARIEN,
                                                    fontSize: 18.sp,
                                                    color:
                                                        const Color(0xff000000),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                        // SizedBox(
                                        //   height: 2.h,
                                        // ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              [serviceProviderData.city]
                                                  .where((element) =>
                                                      element != null &&
                                                      element.isNotEmpty)
                                                  .toList()
                                                  .join(", "),
                                              style: TextStyle(
                                                fontFamily:
                                                    Constants.FONT_ARIEN,
                                                fontSize: 14.sp,
                                                color: const Color(0xff757280),
                                                fontWeight: FontWeight.w700,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              RatingBar(
                                                itemSize: 12.r,
                                                ignoreGestures: true,
                                                initialRating:
                                                    serviceProviderData
                                                            .averageRating
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
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 1.5.w),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                              SizedBox(
                                                width: 4.w,
                                              ),
                                              Text(
                                                serviceProviderData.reviewsCount
                                                        ?.toString() ??
                                                    "0",
                                                style: TextStyle(
                                                  fontFamily:
                                                      Constants.FONT_ARIEN,
                                                  fontSize: 12.sp,
                                                  color:
                                                      const Color(0xFF757280),
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
                          height: (data.serviceProviders != null &&
                                  data.serviceProviders?.isNotEmpty == true)
                              ? data.serviceProviders?.first.business == false
                                  ? (Platform.isIOS ? 210.h : 230.h)
                                  : 270.h
                              : 270.h,
                          //   height: data.type == "business"
                          //       ? 260.h
                          //       : Platform.isIOS
                          //       ? 210.h
                          //       : 230.h
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
            ),
          ],
        ),
      );
    }
  }
}
