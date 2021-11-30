import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/utils/constants.dart';
import 'package:get/get.dart';
import 'package:hippo/view_models/providerDetail/provider_detail_binding.dart';
import 'package:hippo/x_utils/utilities.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:customizable_space_bar/customizable_space_bar.dart';

class CaregiverDetailScreen extends BaseView<ProviderDetailController> {
  ScrollController? _controller;
  bool visible = true;

  _scrollListener() {
    print("atEdge ${_controller!.position.atEdge}  ${_controller!.position.pixels} ");

    print("isExpanded ${_controller!.hasClients &&
        _controller!.offset > (200 - kToolbarHeight)}  ");

    if(_controller!.hasClients &&
        _controller!.offset > (200 - kToolbarHeight)){
      visible = false;
      controller.update();
    }else{
      visible = true;
      controller.update();
    }



    // if (_controller!.offset <= _controller!.position.minScrollExtent + 160.h &&
    //     !_controller!.position.outOfRange ) {
    //   //reach the top
    //   visible = true;
    //   controller.update();
    // } else {
    //   visible = false;
    //   controller.update();
    // }
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

  String? text;
  bool canExpand = false;
  bool isExpand = false;
  bool isUSDVisible = false;

  _body(BuildContext context) {
    if (controller.screenStateIsLoading)
      return Center(child: CircularProgressIndicator());
    if (controller.screenStateIsError) return Text(XR().string.error_message);
    if (controller.screenStateIsOK) {
      canExpand = controller.providerData?.description != null &&
          controller.providerData!.description!.length >= 180;
      text = canExpand
          ? (isExpand
              ? controller.providerData!.description!
              : controller.providerData!.description!.substring(0, 180))
          : (controller.providerData!.description!);

      return Stack(
        children: [
          CustomScrollView(
            controller: _controller,
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                pinned: true,
                expandedHeight: 200.h,
                stretch: false,
                flexibleSpace : FlexibleSpaceBar(
                  background:   Container(
                    height: 230.h,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 168.h,
                          child: SvgPicture.asset(
                            'assets/images/caregiver_bg.svg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 59.h),
                          height: 24.h,
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: <Widget>[
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
                              Spacer(flex: 2),
                              controller.providerData?.verifyStatus == 1
                                  ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/verified_icon.svg',
                                    width: 23.2.w,
                                    height: 23.2.w,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Text(
                                    'Certified'.tr,
                                    style: TextStyle(
                                      fontFamily:
                                      Constants.FONT_ARIEN,
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  )
                                ],
                              )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(top: 106.h, left: 14.w),
                          child: Row(
                            children: [
                              Container(
                                width: 123.h,
                                height: 123.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(
                                          9999.0, 9999.0)),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      controller.providerData
                                          ?.profilePic ??
                                          "",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: Align(
                                          child: InkWell(
                                            onTap: () {
                                              Utilities().callPhoneNumber(
                                                  phone: controller
                                                      .providerData
                                                      ?.phoneNumber ??
                                                      "0");
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  right: 14.w),
                                              width: 120.w,
                                              height: 41.h,
                                              child: Container(
                                                padding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 18.w),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/ic_call_new.svg',
                                                      width: Platform.isIOS
                                                          ? 18.h
                                                          : 21.h,
                                                      height: Platform.isIOS
                                                          ? 18.h
                                                          : 21.h,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    Expanded(
                                                      child: Center(
                                                        child: Text(
                                                          'Call'.tr,
                                                          style: TextStyle(
                                                            fontFamily:
                                                            Constants
                                                                .FONT_ARIEN,
                                                            fontSize: Platform.isIOS
                                                                ? 12.sp
                                                                : 14.sp,
                                                            color: Colors
                                                                .black,
                                                            fontWeight:
                                                            FontWeight
                                                                .w700,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    22.r),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.16),
                                                    offset: Offset(0, 3.0),
                                                    blurRadius: 6.r,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          alignment: Alignment.centerRight,
                                        )),
                                    Expanded(
                                        child: Container(
                                          // color: Colors.red,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 8.w,
                                              ),
                                              RatingBar(
                                                itemSize: 16.r,
                                                ignoreGestures: true,
                                                initialRating: controller
                                                    .providerData
                                                    ?.averageRating
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
                                                controller.providerData
                                                    ?.reviews?.length
                                                    .toString() ??
                                                    "0",
                                                style: TextStyle(
                                                  fontFamily:
                                                  Constants.FONT_ARIEN,
                                                  fontSize: 18.sp,
                                                  color:
                                                  const Color(0xFF757280),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  alignment:
                                                  Alignment.centerRight,
                                                  margin: EdgeInsets.only(
                                                      right: 10.w),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize.min,
                                                    children: [
                                                      InkWell(
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsets.all(
                                                              12.r),
                                                          child: SvgPicture
                                                              .asset(
                                                            'assets/images/share_new.svg',
                                                            width: 17.w,
                                                            height: 21.h,
                                                            fit: BoxFit
                                                                .contain,
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          Utilities()
                                                              .shareContactDetails(
                                                            name: controller
                                                                .providerData
                                                                ?.firstName ??
                                                                controller
                                                                    .providerData
                                                                    ?.name,
                                                            lname: controller
                                                                .providerData
                                                                ?.lastName,
                                                            address: controller
                                                                .providerData
                                                                ?.address,
                                                            phone: controller
                                                                .providerData
                                                                ?.phoneNumber,
                                                          );
                                                        },
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          var map = new Map<
                                                              String,
                                                              dynamic>();

                                                          map["service_id"] =
                                                              controller
                                                                  .providerData
                                                                  ?.id;
                                                          map["favourite"] =
                                                          controller.isFav ==
                                                              true
                                                              ? "0"
                                                              : "1";
                                                          map["type"] = controller
                                                              .providerData
                                                              ?.business ==
                                                              true
                                                              ? "business"
                                                              : "service_provider";
                                                          if (controller
                                                              .isLoggedIn()) {
                                                            controller
                                                                .addToFavList(
                                                                map);
                                                          } else {
                                                            Get.showSnackbar(
                                                                GetBar(
                                                                  backgroundColor:
                                                                  Colors.red,
                                                                  icon: Icon(
                                                                      Icons.error,
                                                                      color: Colors
                                                                          .white),
                                                                  mainButton:
                                                                  TextButton(
                                                                    child: Text(
                                                                      "login".tr,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Get.toNamed(RouterName.login);
                                                                    },
                                                                  ),
                                                                  messageText: Text(
                                                                      "loginRequired"
                                                                          .tr,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white)),
                                                                  duration:
                                                                  Duration(
                                                                      seconds:
                                                                      3),
                                                                ));
                                                          }
                                                        },
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsets.all(
                                                              12.r),
                                                          child: SvgPicture
                                                              .asset(
                                                            controller.isFav
                                                                ? 'assets/images/heart_filled_red.svg'
                                                                : 'assets/images/ic_fav_new.svg',
                                                            width: 18.5.w,
                                                            height: 17.h,
                                                            fit: BoxFit
                                                                .contain,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 19.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.providerData?.firstName ?? ""} ${controller.providerData?.lastName ?? ""}"
                                .trim(),
                            style: TextStyle(
                              fontFamily: Constants.FONT_ARIEN,
                              fontSize: 22.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            height: 9.h,
                          ),
                          Text(
                            "${controller.providerData?.city != null ? (controller.providerData?.city ?? "") + ", " : ""}${controller.providerData?.state ?? ""}"
                                .trimRight(),
                            style: TextStyle(
                              fontFamily: Constants.FONT_ARIEN,
                              fontSize: 14.sp,
                              color: const Color(0xFF0C6BC2),
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 7.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 13.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            text ?? "",
                            style: TextStyle(
                              fontFamily: Constants.FONT_ARIEN,
                              fontSize: 14.sp,
                              color: const Color(0xff707070),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          canExpand
                              ? InkWell(
                            onTap: () {
                              isExpand = !isExpand;
                              controller.refresh();
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 15.h),
                              child: Center(
                                child: SvgPicture.asset(
                                  isExpand
                                      ? 'assets/images/collapse_new.svg'
                                      : 'assets/images/expand.svg',
                                  fit: BoxFit.contain,
                                  height: 17.h,
                                  width: 46.w,
                                ),
                              ),
                            ),
                          )
                              : Container(),
                          SizedBox(
                            height: 18.h,
                          ),
                          Container(
                            height: 1.h,
                            decoration: BoxDecoration(
                              color: const Color(0xffe2e2e2),
                            ),
                          ),
                          controller.providerData!.dateOfBirth != null?
                          SizedBox(
                            height: 54.h,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Age'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 17.sp,
                                    color: const Color(0xFF707070),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      Utilities()
                                          .getAge(controller
                                          .providerData
                                          ?.dateOfBirth ??
                                          "")
                                          .toString() +
                                          " " +
                                          "Years".tr,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 17.sp,
                                        color: const Color(0xFF707070),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                              : SizedBox.shrink(),
                          Container(
                            height: 1.h,
                            decoration: BoxDecoration(
                              color: const Color(0xffe2e2e2),
                            ),
                          ),

                          controller.providerData!.gender != null ?
                          SizedBox(
                            height: 54.h,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Gender'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 17.sp,
                                    color: const Color(0xFF707070),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),

                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      controller.providerData?.gender == 1
                                          ? "Male".tr
                                          : "Female".tr,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 17.sp,
                                        color: const Color(0xFF707070),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          )
                              : SizedBox.shrink(),
                          Container(
                            height: 1.h,
                            decoration: BoxDecoration(
                              color: const Color(0xffe2e2e2),
                            ),
                          ),

                          controller.providerData!.educationNames != null ?
                          SizedBox(
                            height: 54.h,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Education'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 17.sp,
                                    color: const Color(0xFF707070),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      controller.providerData
                                          ?.educationNames ??
                                          "-",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 17.sp,
                                        color: const Color(0xFF707070),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                              : SizedBox.shrink(),
                          Container(
                            height: 1.h,
                            decoration: BoxDecoration(
                              color: const Color(0xffe2e2e2),
                            ),
                          ),
                          controller.providerData!.occupationNames != null?
                          SizedBox(
                            height: 54.h,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Profession'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 17.sp,
                                    color: const Color(0xFF707070),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      controller.providerData
                                          ?.occupationNames ??
                                          "-",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 17.sp,
                                        color: const Color(0xFF707070),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                              : SizedBox.shrink(),
                          Container(
                            height: 1.h,
                            decoration: BoxDecoration(
                              color: const Color(0xffe2e2e2),
                            ),
                          ),
                          controller.providerData!.workExperienceNames != null?
                          SizedBox(
                            height: 54.h,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'WorkExperience2'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 17.sp,
                                    color: const Color(0xFF707070),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      controller.providerData
                                          ?.workExperienceNames ??
                                          "-",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 17.sp,
                                        color: const Color(0xFF707070),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                              : SizedBox.shrink(),
                          Container(
                            height: 1.h,
                            decoration: BoxDecoration(
                              color: const Color(0xffe2e2e2),
                            ),
                          ),
                          controller.providerData!.smoker != null?
                          SizedBox(
                            height: 54.h,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Smoker'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 17.sp,
                                    color: const Color(0xFF707070),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      controller.providerData?.smoker == 1
                                          ? "Yes".tr
                                          : "No".tr,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 17.sp,
                                        color: const Color(0xFF707070),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                              : SizedBox.shrink(),
                          Container(
                            height: 1.h,
                            decoration: BoxDecoration(
                              color: const Color(0xffe2e2e2),
                            ),
                          ),
                          controller.providerData!.haveKids != null?
                          SizedBox(
                            height: 54.h,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'HasChild'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 17.sp,
                                    color: const Color(0xFF707070),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      controller.providerData?.haveKids ==
                                          1
                                          ? "Yes".tr
                                          : "No".tr,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 17.sp,
                                        color: const Color(0xFF707070),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                              : SizedBox.shrink(),
                          Container(
                            height: 1.h,
                            decoration: BoxDecoration(
                              color: const Color(0xffe2e2e2),
                            ),
                          ),
                          controller.providerData!.haveDrivingLicense != null?
                          SizedBox(
                            height: 54.h,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'DrivingLicense'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 17.sp,
                                    color: const Color(0xFF707070),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      controller.providerData
                                          ?.haveDrivingLicense ==
                                          1
                                          ? "Yes".tr
                                          : "No".tr,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 17.sp,
                                        color: const Color(0xFF707070),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                              : SizedBox.shrink(),
                          Container(
                            height: 1.h,
                            decoration: BoxDecoration(
                              color: const Color(0xffe2e2e2),
                            ),
                          ),
                          controller.providerData!.haveCar != null?
                          SizedBox(
                            height: 54.h,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'PrivateCar'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 17.sp,
                                    color: const Color(0xFF707070),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      controller.providerData?.haveCar ==
                                          1
                                          ? "Yes".tr
                                          : "No".tr,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 17.sp,
                                        color: const Color(0xFF707070),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                              : SizedBox.shrink(),
                          Container(
                            height: 1.h,
                            decoration: BoxDecoration(
                              color: const Color(0xffe2e2e2),
                            ),
                          ),
                          SizedBox(
                            height: 35.h,
                          ),
                          controller.providerData?.pricePerHour == null &&
                              controller.providerData?.pricePerDay ==
                                  null &&
                              controller
                                  .providerData?.pricePerMonth ==
                                  null
                              ? SizedBox()
                              : Text(
                            'PaymentTerms'.tr,
                            style: TextStyle(
                              fontFamily: Constants.FONT_ARIEN,
                              fontSize: 22.sp,
                              color: const Color(0xff0c6bc2),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height:
                            controller.providerData?.pricePerHour ==
                                null &&
                                controller.providerData
                                    ?.pricePerDay ==
                                    null &&
                                controller.providerData
                                    ?.pricePerMonth ==
                                    null
                                ? 0
                                : 10.h,
                          ),
                          controller.providerData?.pricePerHour == null &&
                              controller.providerData?.pricePerDay ==
                                  null &&
                              controller
                                  .providerData?.pricePerMonth ==
                                  null
                              ? SizedBox()
                              : Column(
                            children: [
                              Container(
                                height: 1.h,
                                decoration: BoxDecoration(
                                  color: const Color(0xffe2e2e2),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  isUSDVisible = !isUSDVisible;
                                  controller.refresh();
                                },
                                child: Container(
                                  height: 63.4.h,
                                  child: Row(
                                    children: [
                                      controller.providerData
                                          ?.pricePerHour !=
                                          null
                                          ? Expanded(
                                        child: Container(
                                          padding: EdgeInsets
                                              .symmetric(
                                              horizontal:
                                              5.w),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            children: [
                                              Text(
                                                'hourly'.tr,
                                                style:
                                                TextStyle(
                                                  fontFamily:
                                                  Constants
                                                      .FONT_ARIEN,
                                                  fontSize:
                                                  12.sp,
                                                  color: const Color(
                                                      0xff707070),
                                                  fontWeight:
                                                  FontWeight
                                                      .w700,
                                                ),
                                                textAlign:
                                                TextAlign
                                                    .left,
                                              ),
                                              FittedBox(
                                                fit: BoxFit
                                                    .scaleDown,
                                                child: Text(
                                                  controller.providerData?.pricePerHour !=
                                                      null
                                                      ? isUSDVisible
                                                      ? '\$${controller.providerData?.pricePerHour}'
                                                      : '${controller.providerData?.pricePerHourAmd} դր'
                                                      : "-",
                                                  style:
                                                  TextStyle(
                                                    fontFamily:
                                                    Constants
                                                        .FONT_ARIEN,
                                                    fontSize:
                                                    15.sp,
                                                    color: const Color(
                                                        0xff707070),
                                                    fontWeight:
                                                    FontWeight
                                                        .w700,
                                                  ),
                                                  textAlign:
                                                  TextAlign
                                                      .left,
                                                ),
                                              ),
                                            ],
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                          ),
                                        ),
                                      )
                                          : SizedBox(),
                                      controller.providerData
                                          ?.pricePerHour !=
                                          null
                                          ? Container(
                                        height: 63.4.h,
                                        width: 1.h,
                                        decoration:
                                        BoxDecoration(
                                          color: const Color(
                                              0xffe2e2e2),
                                        ),
                                      )
                                          : SizedBox(),
                                      controller.providerData
                                          ?.pricePerDay !=
                                          null
                                          ? Expanded(
                                        child: Container(
                                          padding: EdgeInsets
                                              .symmetric(
                                              horizontal:
                                              5.w),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            children: [
                                              Text(
                                                'daily'.tr,
                                                style:
                                                TextStyle(
                                                  fontFamily:
                                                  Constants
                                                      .FONT_ARIEN,
                                                  fontSize:
                                                  12.sp,
                                                  color: const Color(
                                                      0xff707070),
                                                  fontWeight:
                                                  FontWeight
                                                      .w700,
                                                ),
                                                textAlign:
                                                TextAlign
                                                    .left,
                                              ),
                                              FittedBox(
                                                fit: BoxFit
                                                    .scaleDown,
                                                child: Text(
                                                  controller.providerData?.pricePerDay !=
                                                      null
                                                      ? isUSDVisible
                                                      ? '\$${controller.providerData?.pricePerDay}'
                                                      : '${controller.providerData?.pricePerDayAmd} դր'
                                                      : "-",
                                                  style:
                                                  TextStyle(
                                                    fontFamily:
                                                    Constants
                                                        .FONT_ARIEN,
                                                    fontSize:
                                                    15.sp,
                                                    color: const Color(
                                                        0xff707070),
                                                    fontWeight:
                                                    FontWeight
                                                        .w700,
                                                  ),
                                                  textAlign:
                                                  TextAlign
                                                      .left,
                                                ),
                                              ),
                                            ],
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                          ),
                                        ),
                                      )
                                          : SizedBox(),
                                      controller.providerData
                                          ?.pricePerDay !=
                                          null
                                          ? Container(
                                        height: 63.4.h,
                                        width: 1.h,
                                        decoration:
                                        BoxDecoration(
                                          color: const Color(
                                              0xffe2e2e2),
                                        ),
                                      )
                                          : SizedBox(),
                                      controller.providerData
                                          ?.pricePerMonth !=
                                          null
                                          ? Expanded(
                                        child: Container(
                                          padding: EdgeInsets
                                              .symmetric(
                                              horizontal:
                                              5.w),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            children: [
                                              Text(
                                                'Monthly'.tr,
                                                style:
                                                TextStyle(
                                                  fontFamily:
                                                  Constants
                                                      .FONT_ARIEN,
                                                  fontSize:
                                                  12.sp,
                                                  color: const Color(
                                                      0xff707070),
                                                  fontWeight:
                                                  FontWeight
                                                      .w700,
                                                ),
                                                textAlign:
                                                TextAlign
                                                    .left,
                                              ),
                                              FittedBox(
                                                fit: BoxFit
                                                    .scaleDown,
                                                child: Text(
                                                  controller.providerData?.pricePerMonth !=
                                                      null
                                                      ? isUSDVisible
                                                      ? '\$${controller.providerData?.pricePerMonth}'
                                                      : '${controller.providerData?.pricePerMonthAmd} դր'
                                                      : "-",
                                                  style:
                                                  TextStyle(
                                                    fontFamily:
                                                    Constants
                                                        .FONT_ARIEN,
                                                    fontSize:
                                                    15.sp,
                                                    color: const Color(
                                                        0xff707070),
                                                    fontWeight:
                                                    FontWeight
                                                        .w700,
                                                  ),
                                                  textAlign:
                                                  TextAlign
                                                      .left,
                                                ),
                                              ),
                                            ],
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                          ),
                                        ),
                                      )
                                          : SizedBox(),
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
                              SizedBox(
                                height: 43.h,
                              ),
                            ],
                          ),
                          Text(
                            'languagesKnown'.tr,
                            style: TextStyle(
                              fontFamily: Constants.FONT_ARIEN,
                              fontSize: 22.sp,
                              color: const Color(0xff0c6bc2),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            controller.providerData?.languageNames ?? "-",
                            style: TextStyle(
                              fontFamily: Constants.FONT_ARIEN,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff707070),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Utilities().intentOpenUrl(
                                      link: controller.providerData
                                          ?.facebookUrl ??
                                          "");
                                },
                                child: Container(
                                  height: 40.h,
                                  width: 40.h,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/images/fb_new.svg',
                                      width: 34.h,
                                      height: 34.h,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Utilities().intentOpenUrl(
                                      link: controller.providerData
                                          ?.instagramUrl ??
                                          "");
                                },
                                child: Container(
                                  height: 40.h,
                                  width: 40.h,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/images/insta_new.svg',
                                      width: 34.w,
                                      height: 34.h,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  print(controller
                                      .providerData?.emailAddress ??
                                      "nooo");
                                  Utilities().intentOpenUrl(
                                      link: "mailto:" +
                                          (controller.providerData
                                              ?.emailAddress ??
                                              ""));
                                },
                                child: Container(
                                  height: 40.h,
                                  width: 40.h,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/images/email_link_new.svg',
                                      width: 34.w,
                                      height: 34.h,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Utilities().callPhoneNumber(
                                      phone: controller.providerData
                                          ?.phoneNumber ??
                                          "0");
                                },
                                child: Container(
                                  height: 40.h,
                                  width: 40.h,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/images/call_link_new.svg',
                                      width: 34.w,
                                      height: 34.h,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: const Color(0xffF0F0F0),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 20.w,
                            top: 13.h,
                            bottom: 13.h,
                            right: 4.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Reviews'.tr,
                                          style: TextStyle(
                                              fontFamily:
                                              Constants.FONT_ARIEN,
                                              fontSize: 22.sp,
                                              color: const Color(0xff0c6bc2),
                                              fontWeight: FontWeight.w700,
                                              height: 1),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        RatingBar(
                                          itemSize: 22.r,
                                          ignoreGestures: true,
                                          initialRating: controller
                                              .providerData?.averageRating
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
                                          width: 8.w,
                                        ),
                                        Text(
                                          controller.providerData?.reviews
                                              ?.length
                                              .toString() ??
                                              "0",
                                          style: TextStyle(
                                            fontFamily: Constants.FONT_ARIEN,
                                            fontSize: 10.0,
                                            color: const Color(0xFF707070),
                                          ),
                                        ),
                                      ],
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                    )),
                                InkWell(
                                  onTap: () async {
                                    if (controller.isLoggedIn()) {
                                      var map = new Map<String, String>();
                                      map["service_id"] =
                                          (controller.providerData?.id ??
                                              0)
                                              .toString();
                                      map["type"] = "service_provider";
                                      var result = await Get.toNamed(
                                          RouterName.addReviewScreen,
                                          parameters: map);
                                      if (result == true) {
                                        visible = true;
                                        controller.getDetails();
                                      }
                                    } else {
                                      Get.showSnackbar(GetBar(
                                        backgroundColor: Colors.red,
                                        icon: Icon(Icons.error,
                                            color: Colors.white),
                                        mainButton: TextButton(
                                          child: Text(
                                            "login".tr,
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Get.toNamed(RouterName.login);
                                          },
                                        ),
                                        messageText: Text(
                                            "loginRequired".tr,
                                            style: TextStyle(
                                                color: Colors.white)),
                                        duration: Duration(seconds: 3),
                                      ));
                                      // controller.showSimpleErrorSnackBar(
                                      //     message: "loginRequired".tr);
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    'assets/images/add_rating.svg',
                                    width: 52.h,
                                    height: 52.w,
                                    fit: BoxFit.contain,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListView.separated(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 18.h,bottom: 60.h,left: 18.w,right: 18.w),
                      itemCount:
                      controller.providerData?.reviews?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        var reviewData =
                        controller.providerData?.reviews![index];
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reviewData?.userName.toString() ?? "",
                                style: TextStyle(
                                  fontFamily: Constants.FONT_ARIEN,
                                  fontSize: 17.sp,
                                  color: const Color(0xFF707070),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              RatingBar(
                                itemSize: 15.r,
                                ignoreGestures: true,
                                initialRating:
                                (reviewData?.rating ?? 0).toDouble(),
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                ratingWidget: RatingWidget(
                                  full: SvgPicture.asset(
                                    'assets/images/heart_filled.svg',
                                    color: Color(0xffB9B9B9),
                                    fit: BoxFit.contain,
                                  ),
                                  half: SvgPicture.asset(
                                    'assets/images/heart.svg',
                                    color: Color(0xffB9B9B9),
                                    fit: BoxFit.contain,
                                  ),
                                  empty: SvgPicture.asset(
                                    'assets/images/fav_service.svg',
                                    color: Color(0xffB9B9B9),
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
                                height: 13.h,
                              ),
                              Text(
                                reviewData?.reviewText ?? "",
                                style: TextStyle(
                                  fontFamily: Constants.FONT_ARIEN,
                                  fontSize: 14.sp,
                                  color: const Color(0xFF707070),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder:
                          (BuildContext context, int index) => Divider(
                        thickness: 1.h,
                        height: 32.h,
                        color: const Color(0xffE2E2E2),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),

          AnimatedContainer(

            duration:  Duration(milliseconds: 200),
            child: Container(
              height: 108.h,
              width: double.infinity,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/images/collapse_bg.svg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 51.h),
                    height: 46.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.only(left: 20.w),
                            width: 12.w,
                            height: 30.h,
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/images/chevron.svg',
                                width: 12.w,
                                color: const Color(0xFF0C6BC2),
                                height: 20.5.h,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          width: 11.w,
                        ),
                        Container(
                          width: 46.w,
                          height: 46.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                controller.providerData?.profilePic ?? "",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 11.w,
                        ),
                        Text(
                          "${controller.providerData?.firstName ?? ""} ${controller.providerData?.lastName?.substring(0,1) ?? ""} ${"."}"
                              .trim(),
                          style: TextStyle(
                            fontFamily: Constants.FONT_ARIEN,
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Spacer(flex: 2),
                        InkWell(
                          onTap: () {
                            Utilities().callPhoneNumber(
                                phone: controller.providerData?.phoneNumber ??
                                    "0");
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 14.w),
                            width: 120.w,
                            height: 41.h,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 18.w),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/ic_call_new.svg',
                                    width: Platform.isIOS
                                        ? 18.h
                                        : 21.h,
                                    height: Platform.isIOS
                                        ? 18.h
                                        : 21.h,
                                    fit: BoxFit.contain,
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'Call'.tr,
                                        style: TextStyle(
                                          fontFamily: Constants.FONT_ARIEN,
                                          fontSize: Platform.isIOS
                                              ? 12.sp
                                              : 14.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22.r),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.16),
                                  offset: Offset(0, 3.0),
                                  blurRadius: 6.r,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            height: !visible ? 108.h : 0,
          ),
        ],
      );
    }
  }
}
