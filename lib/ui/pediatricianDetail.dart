import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/utils/constants.dart';
import 'package:get/get.dart';
import 'package:hippo/view_models/providerDetail/provider_detail_binding.dart';
import 'package:hippo/x_utils/utilities.dart';

class PediatricianDetailScreen extends BaseView<ProviderDetailController> {
  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(context),
    );
  }
  bool isUSDVisible = false;
  _body(BuildContext context) {
    if (controller.screenStateIsLoading)
      return Center(child: CircularProgressIndicator());
    if (controller.screenStateIsError) return Text(XR().string.error_message);
    if (controller.screenStateIsOK) {
      return Container(
        color: Color(0xff0c6bc2),
        child: Column(
          children: [
            Container(
              height: 30.h,
            ),
            Container(
              height: 60.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                          height: 20.h,
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
                  Expanded(
                    flex: 100,
                    child: Text(
                      controller.providerData?.firstName ??
                          controller.providerData?.name ??
                          "",
                      style: TextStyle(
                        fontFamily: Constants.FONT_ARIEN,
                        fontSize: 26.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  controller.providerData?.verifyStatus == 1
                      ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/images/verified_icon.svg',
                        width: 23.w,
                        height: 23.h,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        'Certified'.tr,
                        style: TextStyle(
                          fontFamily: Constants.FONT_ARIEN,
                          fontSize: 14.sp,
                          color: const Color(0xFF92E0FF),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      )
                    ],
                  )
                      : SizedBox(),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(

                        color: Color(0xff0c6bc2),
                        width: double.infinity,
                        height: 208.h,
                        child: Center(
                          child: Container(
                            width: 152.h,
                            height: 152.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.elliptical(9999.0, 9999.0)),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  controller.providerData?.profilePic ?? "",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 63.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  print("called");
                                  Utilities().callPhoneNumber(
                                      phone: controller
                                          .providerData?.phoneNumber ??
                                          "0");
                                },
                                child: Container(
                                  color: const Color(0xFF38BC2E),
                                  child: Center(
                                    child: SizedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Container(
                                            child: SvgPicture.asset(
                                              'assets/images/call_new.svg',
                                              width: 30.w,
                                              height: 30.h,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Call'.tr,
                                                style: TextStyle(
                                                  fontFamily:
                                                  Constants.FONT_ARIEN,
                                                  fontSize: 20.sp,
                                                  color:
                                                  const Color(0xFFFFFFFF),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.25.h,
                                              ),
                                              Text(
                                                controller.providerData
                                                    ?.phoneNumber ??
                                                    "",
                                                style: TextStyle(
                                                  fontFamily:
                                                  Constants.FONT_ARIEN,
                                                  fontSize: 14.sp,
                                                  color:
                                                  const Color(0xFFA4E19F),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 2.w,
                            ),
                            Container(
                              color: const Color(0xFFF0F0F0),
                              child: SizedBox(
                                width: 108.w,
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            var map =
                                            new Map<String, dynamic>();

                                            map["service_id"] =
                                                controller.providerData?.id;
                                            map["favourite"] =
                                            controller.isFav == true
                                                ? "0"
                                                : "1";
                                            map["type"] = controller
                                                .providerData
                                                ?.business ==
                                                true
                                                ? "business"
                                                : "service_provider";
                                            if (controller.isLoggedIn()) {
                                              controller.addToFavList(map);
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
                                            }
                                          },
                                          child: Container(
                                            child: Center(
                                              child: SvgPicture.asset(
                                                controller.isFav
                                                    ? 'assets/images/heart_filled.svg'
                                                    : 'assets/images/fav_service.svg',
                                                width: 23.h,
                                                height: 23.h,
                                                color: controller.isFav
                                                    ? Color(0xFFFF0303)
                                                    : Color(0xFF707070),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        width: 2.w,
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Utilities().shareContactDetails(
                                              name: controller.providerData
                                                  ?.firstName ??
                                                  controller.providerData?.name,
                                              lname: controller
                                                  .providerData?.lastName,
                                              address: controller
                                                  .providerData?.address,
                                              phone: controller
                                                  .providerData?.phoneNumber,
                                            );
                                          },
                                          child: Container(
                                            child: Center(
                                              child: SvgPicture.asset(
                                                'assets/images/upload.svg',
                                                width: 23.h,
                                                height: 23.h,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 13.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                                .getAge(controller.providerData
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
                            ),
                            Container(
                              height: 1.h,
                              decoration: BoxDecoration(
                                color: const Color(0xffe2e2e2),
                              ),
                            ),
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
                                        controller
                                                .providerData?.educationNames ??
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
                            ),
                            Container(
                              height: 1.h,
                              decoration: BoxDecoration(
                                color: const Color(0xffe2e2e2),
                              ),
                            ),
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
                            ),
                            Container(
                              height: 1.h,
                              decoration: BoxDecoration(
                                color: const Color(0xffe2e2e2),
                              ),
                            ),
                            SizedBox(
                              height: 54.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'specializations'.tr,
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
                                        controller
                                                .providerData?.specialization ??
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
                            ),
                            Container(
                              height: 1.h,
                              decoration: BoxDecoration(
                                color: const Color(0xffe2e2e2),
                              ),
                            ),
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
                                            "",
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
                            ),

                            Container(
                              height: 1.h,
                              decoration: BoxDecoration(
                                color: const Color(0xffe2e2e2),
                              ),
                            ),
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
                                        controller.providerData?.haveKids == 1
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
                            ),
                            Container(
                              height: 1.h,
                              decoration: BoxDecoration(
                                color: const Color(0xffe2e2e2),
                              ),
                            ),
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
                            ),
                            Container(
                              height: 1.h,
                              decoration: BoxDecoration(
                                color: const Color(0xffe2e2e2),
                              ),
                            ),
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
                                        controller.providerData?.haveCar == 1
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
                            ),
                            Container(
                              height: 1.h,
                              decoration: BoxDecoration(
                                color: const Color(0xffe2e2e2),
                              ),
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            Text(
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
                              height: 10.h,
                            ),
                            Container(
                              height: 1.h,
                              decoration: BoxDecoration(
                                color: const Color(0xffe2e2e2),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                isUSDVisible=!isUSDVisible;
                                controller.refresh();
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Column(

                                        children: [
                                          Text(
                                            'hourly'.tr,
                                            style: TextStyle(
                                              fontFamily: Constants.FONT_ARIEN,
                                              fontSize: 12.sp,
                                              color: const Color(0xff707070),
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            controller.providerData
                                                ?.pricePerHour !=
                                                null
                                                ? isUSDVisible?'\$${controller.providerData?.pricePerHour}':'${controller.providerData?.pricePerHourAmd} դր'
                                                : "-",
                                            style: TextStyle(
                                              fontFamily: Constants.FONT_ARIEN,
                                              fontSize: 20.sp,
                                              color: const Color(0xff707070),
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 63.4.h,
                                    width: 1.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffe2e2e2),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            'daily'.tr,
                                            style: TextStyle(
                                              fontFamily: Constants.FONT_ARIEN,
                                              fontSize: 12.sp,
                                              color: const Color(0xff707070),
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            controller.providerData
                                                ?.pricePerDay !=
                                                null
                                                ? isUSDVisible?'\$${controller.providerData?.pricePerDay}':'${controller.providerData?.pricePerDayAmd} դր'
                                                : "-",
                                            style: TextStyle(
                                              fontFamily: Constants.FONT_ARIEN,
                                              fontSize: 20.sp,
                                              color: const Color(0xff707070),
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 63.4.h,
                                    width: 1.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffe2e2e2),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            'Monthly'.tr,
                                            style: TextStyle(
                                              fontFamily: Constants.FONT_ARIEN,
                                              fontSize: 12.sp,
                                              color: const Color(0xff707070),
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            controller.providerData
                                                ?.pricePerMonth !=
                                                null
                                                ?  isUSDVisible?'\$${controller.providerData?.pricePerMonth}':'${controller.providerData?.pricePerMonthAmd} դր'
                                                : "-",
                                            style: TextStyle(
                                              fontFamily: Constants.FONT_ARIEN,
                                              fontSize: 20.sp,
                                              color: const Color(0xff707070),
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                      ),
                                    ),
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
                            SizedBox(
                              height: 43.h,
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
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff707070),
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            Text(
                              'Follow'.tr,
                              style: TextStyle(
                                fontFamily: Constants.FONT_ARIEN,
                                fontSize: 22.sp,
                                color: const Color(0xff0c6bc2),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Utilities().intentOpenUrl(
                                        link: controller
                                            .providerData?.facebookUrl ??
                                            "");
                                  },
                                  child: Container(
                                    color: Color(0xffF0F0F0),
                                    height: 62.h,
                                    width: 62.h,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/images/ic_fb.svg',
                                        width: 34.h,
                                        height: 34.h,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    Utilities().intentOpenUrl(
                                        link: controller
                                            .providerData?.instagramUrl ??
                                            "");
                                  },
                                  child: Container(
                                    color: Color(0xffF0F0F0),
                                    height: 62.h,
                                    width: 62.h,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/images/ic_insta.svg',
                                        width: 34.w,
                                        height: 34.h,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40.h,
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
