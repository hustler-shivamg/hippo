import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/service_provider.dart';
import 'package:hippo/ui/gallery.dart';
import 'package:hippo/utils/constants.dart';
import 'package:hippo/view_models/providerDetail/provider_detail_binding.dart';
import 'package:hippo/x_utils/utilities.dart';
import 'package:hippo/x_utils/widgets/slider.dart';
import 'package:geolocator/geolocator.dart';

class KinderGardenDetailScreen extends BaseView<ProviderDetailController> {
  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: _body(context));
  }

  String? text, isSelected;
  bool canExpand = false;
  bool isExpand = false;
  bool isUSDVisible = false;

  _body(BuildContext context) {
    if (controller.screenStateIsLoading)
      return Center(child: CircularProgressIndicator());
    if (controller.screenStateIsError) return Text(XR().string.error_message);
    if (controller.screenStateIsOK) {
      var data = controller.providerData;
      canExpand = controller.providerData?.description != null &&
          controller.providerData!.description!.length >= 180;
      text = canExpand
          ? (isExpand
              ? controller.providerData!.description ?? ""
              : controller.providerData!.description!.substring(0, 180))
          : (controller.providerData!.description ?? "");

      return CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            pinned: true,
            expandedHeight: 250.h,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
                background: Stack(
              children: [
                data?.images != null && data!.images!.isNotEmpty
                    ? BannerSlider(data.images!)
                    : Container(
                        height: 312.h,
                        child: Image(
                          image: const AssetImage('assets/images/no_image.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                Container(
                  height: 312.h,
                  child: Stack(
                    children: [
                      Align(
                        child: RotatedBox(
                          quarterTurns: 2,
                          child: Container(
                            height: 103.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5.r),
                                bottomLeft: Radius.circular(5.r),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment(0.0, -1.0),
                                end: Alignment(0.0, 1.0),
                                colors: [
                                  const Color(0x00000000),
                                  const Color(0xd0000000)
                                ],
                                stops: [0.0, 1.0],
                              ),
                            ),
                          ),
                        ),
                        alignment: Alignment.topCenter,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50.h),
                        child: SizedBox(
                          height: 35.h,
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: InkWell(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10.w),
                                    width: 37.w,
                                    height: 37.w,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/images/close_icon.svg',
                                        width: 37.w,
                                        height: 37.h,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      child: SvgPicture.asset(
                                        'assets/images/share_new.svg',
                                        width: 16.57.w,
                                        height: 21.h,
                                        color: Colors.white,
                                        fit: BoxFit.contain,
                                      ),
                                      onTap: () {
                                        Utilities().shareContactDetails(
                                          name: controller
                                                  .providerData?.firstName ??
                                              controller.providerData?.name,
                                          lname:
                                              controller.providerData?.lastName,
                                          address:
                                              controller.providerData?.address,
                                          phone: controller
                                              .providerData?.phoneNumber,
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      width: 24.w,
                                    ),
                                    InkWell(
                                      child: SvgPicture.asset(
                                        controller.isFav
                                            ? 'assets/images/heart_filled.svg'
                                            : 'assets/images/fav_service.svg',
                                        width: 18.54.w,
                                        height: 17.16.h,
                                        color: Colors.white,
                                        fit: BoxFit.contain,
                                      ),
                                      onTap: () {
                                        var map = new Map<String, dynamic>();

                                        map["service_id"] =
                                            controller.providerData?.id;
                                        map["favourite"] =
                                            controller.isFav == true
                                                ? "0"
                                                : "1";
                                        map["type"] =
                                            controller.providerData?.business ==
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
                                          // controller
                                          //     .showSimpleErrorSnackBar(
                                          //         message:
                                          //             "loginRequired".tr);
                                        }
                                      },
                                    ),
                                    // SizedBox(
                                    //   width: 14.w,
                                    // ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     // var images =
                                    //     //     data?.images?.map((e) => e.image);
                                    //
                                    //     Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (_) =>
                                    //                 GalleryScreen(
                                    //                   images: data.images,
                                    //                 )));
                                    //   },
                                    //   child: SvgPicture.asset(
                                    //     'assets/images/ic_gallery.svg',
                                    //     width: 26.w,
                                    //     height: 26.h,
                                    //     fit: BoxFit.contain,
                                    //   ),
                                    // ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        data?.name ?? "",
                        style: TextStyle(
                          fontFamily: Constants.FONT_ARIEN,
                          fontSize: 22.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        data?.categoryName ?? "",
                        style: TextStyle(
                          fontFamily: Constants.FONT_ARIEN,
                          fontSize: 14.sp,
                          color: const Color(0xff0C6BC2),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 12.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    [data?.address, data?.city, data?.state]
                                            .where((element) =>
                                                element != null &&
                                                element.isNotEmpty)
                                            .toList()
                                            .join(", ") +
                                        " " +
                                        (data?.postalCode ?? ""),
                                    style: TextStyle(
                                      fontFamily: Constants.FONT_ARIEN,
                                      fontSize: 14.sp,
                                      color: const Color(0xff707070),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Text(
                                    controller.diffKM != 0
                                        ? controller.diffKM.toStringAsFixed(2) +
                                            " km"
                                        : " ",
                                    style: TextStyle(
                                      fontFamily: Constants.FONT_ARIEN,
                                      fontSize: 14.sp,
                                      color: const Color(0xFFFF7BAC),
                                    ),
                                  ),

                                  // Text(
                                  //     "LAT: ${controller.currentPosition?.latitude ?? "0"}, LNG: ${controller.currentPosition?.longitude ?? "00"}"
                                  // ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),

                            InkWell(
                              onTap: () {
                                Utilities().launchMap(
                                    lat: "${data?.latitude ?? 0}",
                                    long: "${data?.longitude ?? 0}");
                              },
                              child: Container(
                                width: 88.w,
                                height: 80.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      getImageUrl("${data?.latitude ?? 0}",
                                          "${data?.longitude ?? 0}"),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                            // Image(
                            //   width: 88.w,
                            //   height: 80.h,
                            //   image: const AssetImage('assets/images/demo/map.png'),
                            //   fit: BoxFit.cover,
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 34.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Text(
                                    'Tel'.tr,
                                    style: TextStyle(
                                      fontFamily: Constants.FONT_ARIEN,
                                      fontSize: 17.sp,
                                      color: const Color(0xFF707070),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    data?.phoneNumber ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: Constants.FONT_ARIEN,
                                      fontSize: 17.sp,
                                      color: const Color(0xFF707070),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                            onTap: () {
                              Utilities().callPhoneNumber(
                                  phone: controller.providerData?.phoneNumber ??
                                      "0");
                            },
                            child: Container(
                              width: 120.w,
                              height: 41.h,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 18.w),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/ic_call_new.svg',
                                      width: 21.h,
                                      height: 21.h,
                                      fit: BoxFit.contain,
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Call'.tr,
                                          style: TextStyle(
                                            fontFamily: Constants.FONT_ARIEN,
                                            fontSize:
                                                Platform.isIOS ? 12.sp : 14.sp,
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
                      SizedBox(
                        height: 26.h,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                PopupMenuButton(
                                  itemBuilder: (context) {
                                    return controller.providerData!.hours!
                                        .map((m) {
                                      return PopupMenuItem<int>(
                                        value: m.id ?? -1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              m.dayName.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: m.number == 1
                                                      ? FontWeight.bold
                                                      : FontWeight.normal),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  m.openHour.toString(),
                                                  style: TextStyle(
                                                      fontWeight: m.number == 1
                                                          ? FontWeight.bold
                                                          : FontWeight.normal),
                                                ),
                                                Text(" - "),
                                                Text(
                                                  m.closeHour.toString(),
                                                  style: TextStyle(
                                                      fontWeight: m.number == 1
                                                          ? FontWeight.bold
                                                          : FontWeight.normal),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }).toList();
                                  },

                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller
                                            .providerData!.hours!.first.openHour
                                            .toString(),
                                        style: TextStyle(
                                          fontFamily: Constants.FONT_ARIEN,
                                          fontSize: 17.sp,
                                          color: const Color(0xFF707070),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(" - "),
                                      Text(
                                        controller.providerData!.hours!.first
                                            .closeHour
                                            .toString(),
                                        style: TextStyle(
                                          fontFamily: Constants.FONT_ARIEN,
                                          fontSize: 17.sp,
                                          color: const Color(0xFF707070),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      RotatedBox(
                                        quarterTurns: 3,
                                        child: SvgPicture.asset(
                                          'assets/images/chevron.svg',
                                          width: 6.99.w,
                                          height: 11.95.h,
                                          color: Color(0xffB9B9B9),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // value: controller.selected,
                                  // onSelected: (newValue) {
                                  //   controller.setSelected(newValue!.toString());
                                  //   controller.refresh();
                                  // },
                                  color: Color(0xffF5F5F5),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10.w),
                            child: Text(
                              // data?.hours?.isOpen == true
                              //     ? 'opened'.tr
                              //     : 'Closed'.tr,
                              controller.providerData!.hours!.first.isOpen!
                                  ? 'opened'.tr
                                  : 'Closed'.tr,
                              style: TextStyle(
                                fontFamily: Constants.FONT_ARIEN,
                                fontSize: 17.sp,
                                // color: const Color(0xff96c65f),
                                color: controller
                                        .providerData!.hours!.first.isOpen!
                                    ? Color(0xff96c65f)
                                    : Colors.red,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        height: 1.h,
                        decoration: BoxDecoration(
                          color: const Color(0xffe2e2e2),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        text ?? "",
                        style: TextStyle(
                          fontFamily: Constants.FONT_ARIEN,
                          fontSize: 14.sp,
                          color: const Color(0xff707070),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Center(
                        child: canExpand
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
                                  link: controller.providerData?.facebookUrl ??
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
                                  link: controller.providerData?.instagramUrl ??
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
                              print(controller.providerData?.emailAddress ??
                                  "nooo");
                              Utilities().intentOpenUrl(
                                  link: "mailto:" +
                                      (controller.providerData?.emailAddress ??
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
                                  phone: controller.providerData?.phoneNumber ??
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
                      // controller.providerData?.pricePerHour == null &&
                      //         controller.providerData?.pricePerDay == null &&
                      //         controller.providerData?.pricePerMonth == null
                      //     ? SizedBox()
                      //     : Text(
                      //         'PaymentTerms'.tr,
                      //         style: TextStyle(
                      //           fontFamily: Constants.FONT_ARIEN,
                      //           fontSize: 22.sp,
                      //           color: const Color(0xff0c6bc2),
                      //           fontWeight: FontWeight.w700,
                      //         ),
                      //         textAlign: TextAlign.left,
                      //       ),
                      // SizedBox(
                      //   height: controller.providerData?.pricePerHour == null &&
                      //           controller.providerData?.pricePerDay == null &&
                      //           controller.providerData?.pricePerMonth == null
                      //       ? 0
                      //       : 10.h,
                      // ),
                      // controller.providerData?.pricePerHour == null &&
                      //         controller.providerData?.pricePerDay == null &&
                      //         controller.providerData?.pricePerMonth == null
                      //     ? SizedBox()
                      //     : Column(
                      //         children: [
                      //           Container(
                      //             height: 1.h,
                      //             decoration: BoxDecoration(
                      //               color: const Color(0xffe2e2e2),
                      //             ),
                      //           ),
                      //           InkWell(
                      //             onTap: () {
                      //               isUSDVisible = !isUSDVisible;
                      //               controller.refresh();
                      //             },
                      //             child: Container(
                      //               height: 63.4.h,
                      //               child: Row(
                      //                 children: [
                      //                   controller.providerData?.pricePerHour !=
                      //                           null
                      //                       ? Expanded(
                      //                           child: Container(
                      //                             padding: EdgeInsets.symmetric(
                      //                                 horizontal: 5.w),
                      //                             child: Column(
                      //                               mainAxisAlignment:
                      //                                   MainAxisAlignment.center,
                      //                               children: [
                      //                                 Text(
                      //                                   'hourly'.tr,
                      //                                   style: TextStyle(
                      //                                     fontFamily:
                      //                                         Constants.FONT_ARIEN,
                      //                                     fontSize: 12.sp,
                      //                                     color: const Color(
                      //                                         0xff707070),
                      //                                     fontWeight:
                      //                                         FontWeight.w700,
                      //                                   ),
                      //                                   textAlign: TextAlign.left,
                      //                                 ),
                      //                                 FittedBox(
                      //                                   fit: BoxFit.scaleDown,
                      //                                   child: Text(
                      //                                     controller.providerData
                      //                                                 ?.pricePerHour !=
                      //                                             null
                      //                                         ? isUSDVisible
                      //                                             ? '\$${controller.providerData?.pricePerHour}'
                      //                                             : '${controller.providerData?.pricePerHourAmd} դր'
                      //                                         : "-",
                      //                                     style: TextStyle(
                      //                                       fontFamily: Constants
                      //                                           .FONT_ARIEN,
                      //                                       fontSize: 20.sp,
                      //                                       color: const Color(
                      //                                           0xff707070),
                      //                                       fontWeight:
                      //                                           FontWeight.w700,
                      //                                     ),
                      //                                     textAlign: TextAlign.left,
                      //                                   ),
                      //                                 ),
                      //                               ],
                      //                               crossAxisAlignment:
                      //                                   CrossAxisAlignment.center,
                      //                             ),
                      //                           ),
                      //                         )
                      //                       : SizedBox(),
                      //                   controller.providerData?.pricePerHour !=
                      //                           null
                      //                       ? Container(
                      //                           height: 63.4.h,
                      //                           width: 1.h,
                      //                           decoration: BoxDecoration(
                      //                             color: const Color(0xffe2e2e2),
                      //                           ),
                      //                         )
                      //                       : SizedBox(),
                      //                   controller.providerData?.pricePerDay != null
                      //                       ? Expanded(
                      //                           child: Container(
                      //                             padding: EdgeInsets.symmetric(
                      //                                 horizontal: 5.w),
                      //                             child: Column(
                      //                               mainAxisAlignment:
                      //                                   MainAxisAlignment.center,
                      //                               children: [
                      //                                 Text(
                      //                                   'daily'.tr,
                      //                                   style: TextStyle(
                      //                                     fontFamily:
                      //                                         Constants.FONT_ARIEN,
                      //                                     fontSize: 12.sp,
                      //                                     color: const Color(
                      //                                         0xff707070),
                      //                                     fontWeight:
                      //                                         FontWeight.w700,
                      //                                   ),
                      //                                   textAlign: TextAlign.left,
                      //                                 ),
                      //                                 FittedBox(
                      //                                   fit: BoxFit.scaleDown,
                      //                                   child: Text(
                      //                                     controller.providerData
                      //                                                 ?.pricePerDay !=
                      //                                             null
                      //                                         ? isUSDVisible
                      //                                             ? '\$${controller.providerData?.pricePerDay}'
                      //                                             : '${controller.providerData?.pricePerDayAmd} դր'
                      //                                         : "-",
                      //                                     style: TextStyle(
                      //                                       fontFamily: Constants
                      //                                           .FONT_ARIEN,
                      //                                       fontSize: 20.sp,
                      //                                       color: const Color(
                      //                                           0xff707070),
                      //                                       fontWeight:
                      //                                           FontWeight.w700,
                      //                                     ),
                      //                                     textAlign: TextAlign.left,
                      //                                   ),
                      //                                 ),
                      //                               ],
                      //                               crossAxisAlignment:
                      //                                   CrossAxisAlignment.center,
                      //                             ),
                      //                           ),
                      //                         )
                      //                       : SizedBox(),
                      //                   controller.providerData?.pricePerDay != null
                      //                       ? Container(
                      //                           height: 63.4.h,
                      //                           width: 1.h,
                      //                           decoration: BoxDecoration(
                      //                             color: const Color(0xffe2e2e2),
                      //                           ),
                      //                         )
                      //                       : SizedBox(),
                      //                   controller.providerData?.pricePerMonth !=
                      //                           null
                      //                       ? Expanded(
                      //                           child: Container(
                      //                             padding: EdgeInsets.symmetric(
                      //                                 horizontal: 5.w),
                      //                             child: Column(
                      //                               mainAxisAlignment:
                      //                                   MainAxisAlignment.center,
                      //                               children: [
                      //                                 Text(
                      //                                   'Monthly'.tr,
                      //                                   style: TextStyle(
                      //                                     fontFamily:
                      //                                         Constants.FONT_ARIEN,
                      //                                     fontSize: 12.sp,
                      //                                     color: const Color(
                      //                                         0xff707070),
                      //                                     fontWeight:
                      //                                         FontWeight.w700,
                      //                                   ),
                      //                                   textAlign: TextAlign.left,
                      //                                 ),
                      //                                 FittedBox(
                      //                                   fit: BoxFit.scaleDown,
                      //                                   child: Text(
                      //                                     controller.providerData
                      //                                                 ?.pricePerMonth !=
                      //                                             null
                      //                                         ? isUSDVisible
                      //                                             ? '\$${controller.providerData?.pricePerMonth}'
                      //                                             : '${controller.providerData?.pricePerMonthAmd} դր'
                      //                                         : "-",
                      //                                     style: TextStyle(
                      //                                       fontFamily: Constants
                      //                                           .FONT_ARIEN,
                      //                                       fontSize: 20.sp,
                      //                                       color: const Color(
                      //                                           0xff707070),
                      //                                       fontWeight:
                      //                                           FontWeight.w700,
                      //                                     ),
                      //                                     textAlign: TextAlign.left,
                      //                                   ),
                      //                                 ),
                      //                               ],
                      //                               crossAxisAlignment:
                      //                                   CrossAxisAlignment.center,
                      //                             ),
                      //                           ),
                      //                         )
                      //                       : SizedBox(),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //           Container(
                      //             height: 1.h,
                      //             decoration: BoxDecoration(
                      //               color: const Color(0xffe2e2e2),
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             height: 43.h,
                      //           ),
                      //         ],
                      //       ),
                    ],
                  ),
                ),
                Container(
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: const Color(0xff92e0ff),
                  ),
                ),
                Container(
                  color: const Color(0xffF0F0F0),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20.w, top: 13.h, bottom: 13.h, right: 4.w),
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
                                      fontFamily: Constants.FONT_ARIEN,
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
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 1.5.w),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  data?.reviews?.length.toString() ?? "0",
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 10.0,
                                    color: const Color(0xFF707070),
                                  ),
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.center,
                            )),
                            InkWell(
                              onTap: () async {
                                if (controller.isLoggedIn()) {
                                  var map = new Map<String, String>();
                                  map["service_id"] =
                                      (data?.id ?? 0).toString();
                                  map["type"] = "business";

                                  var result = await Get.toNamed(
                                      RouterName.addReviewScreen,
                                      parameters: map);
                                  if (result == true) {
                                    controller.getDetails();
                                  }
                                } else {
                                  Get.showSnackbar(GetBar(
                                    backgroundColor: Colors.red,
                                    icon:
                                        Icon(Icons.error, color: Colors.white),
                                    mainButton: TextButton(
                                      child: Text(
                                        "login".tr,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Get.toNamed(RouterName.login);
                                      },
                                    ),
                                    messageText: Text("loginRequired".tr,
                                        style: TextStyle(color: Colors.white)),
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
                  padding: EdgeInsets.only(
                      top: 18.h, bottom: 60.h, left: 18.w, right: 18.w),
                  itemCount: data?.reviews?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    var reviewData = data?.reviews![index];
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
                            initialRating: (reviewData?.rating ?? 0).toDouble(),
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
                            itemPadding:
                                EdgeInsets.symmetric(horizontal: 1.5.w),
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
        ],
      );
    }
  }

  String getImageUrl(String lat, String long) {
    return "https://api.mapbox.com/styles/v1/mapbox/outdoors-v11/static/pin-l-star+285A98($long,$lat)/$long,$lat,19,0/300x300@2x?access_token=pk.eyJ1Ijoiaml0ZW5kcmEyMiIsImEiOiJja3B4bTdxczQwa3RzMm9ueWdqeHQzbzdsIn0.rEfz0xwUHSKwzWqkNQP4Og&logo=false";
  }
}
