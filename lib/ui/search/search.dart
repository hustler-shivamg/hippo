import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/ui/search/search_binding.dart';
import 'package:hippo/ui/serviceProviderSignup/serviceProviderSignup.dart';
import 'package:hippo/ui/signup/signup_binding.dart';
import 'package:hippo/utils/constants.dart';
import 'package:hippo/utils/styling.dart';
import 'package:hippo/x_utils/utilities.dart';
import 'package:hippo/x_utils/validator.dart';
import 'package:hippo/x_utils/widgets/my_text_form_field.dart';

class SearchScreen extends BaseView<SearchController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode? fname = FocusNode(),
      lname = FocusNode(),
      email = FocusNode(),
      password = FocusNode(),
      phone = FocusNode();

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    if (controller.screenStateIsLoading)
      return Center(child: CircularProgressIndicator());

    if (controller.screenStateIsError) return Text(XR().string.error_message);

    if (controller.screenStateIsOK)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SvgPicture.asset(
          //   'assets/images/signup_bg.svg',
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   fit: BoxFit.cover,
          // ),
          Container(
            height: 140.h,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 108.h,
                  child: SvgPicture.asset(
                    'assets/images/inner_bg.svg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 30.h,
                      margin: EdgeInsets.only(top: 35.h),
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
                              'Search'.tr,
                              style: AppTheme.dashboard_title_new,
                            ),
                          ),
                          Container(
                            width: 54.w,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h),
                      width: double.infinity,
                      height: 64.h,
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
                              padding: EdgeInsets.only(
                                  bottom: 4.h, left: 8.w, right: 8.w),
                              child: TextField(
                                maxLines: 1,
                                autofocus: true,
                                minLines: 1,
                                style:
                                    TextStyle(fontFamily: Constants.FONT_ARIEN),
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                onChanged: (value) {},
                                controller: controller.searchTxtController,
                                textInputAction: TextInputAction.search,
                                onSubmitted: (value) {
                                  print("search");
                                  controller.searchData();
                                },
                              ),
                            ),
                          ),
                        ],
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
              ],
            ),
          ),

          controller.isSearched
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(left: 27.w, right: 27.w, top: 18.h),
                      child: Text(
                        "Showing Result for".tr,
                        style: TextStyle(
                          fontFamily: Constants.FONT_ARIEN,
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 5.h,
                        bottom: 5.h,
                        left: 27.w,
                        right: 27.w,
                      ),
                      child: Text(
                        '"' + controller.searchTxtController.text + '"',
                        style: TextStyle(
                          fontFamily: Constants.FONT_ARIEN,
                          fontSize: 18.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),

          !controller.isSearched
              ? Container()
              : Expanded(
                  child: Container(
                    child: controller.dataList.length == 0
                        ? Center(
                            child: Text(
                              "No Result Found !".tr,
                              style: TextStyle(
                                fontFamily: Constants.FONT_ARIEN,
                                fontSize: 22.sp,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : ListView.separated(
                            // physics: ClampingScrollPhysics(),
                      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                                  if (data.business == true) {
                                    Get.toNamed(
                                        RouterName.kinderGardenDetailScreen,
                                        parameters: map);
                                  } else {
                                    Get.toNamed(RouterName.caregiverDetail,
                                        parameters: map);
                                  }

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // FadeInImage.memoryNetwork( placeholder: kTransparentImage,
                                      //   image:  data.profilePic ?? "",    width: 110.w,
                                      //   height: 110.w,fit: BoxFit.cover),

                                      data.business == true
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              child: CachedNetworkImage(
                                                width: 110.w,
                                                height: 110.w,
                                                fadeInDuration:
                                                    const Duration(seconds: 0),
                                                fadeOutDuration:
                                                    const Duration(seconds: 0),
                                                imageUrl:
                                                    data.businessLogo ?? "",
                                                placeholder: (context, url) {
                                                  return Container(
                                                      color:
                                                          Colors.grey.shade300,
                                                      child:
                                                          Icon(Icons.person));
                                                },
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : ClipOval(
                                              child: CachedNetworkImage(
                                                width: 110.w,
                                                height: 110.w,
                                                fadeInDuration:
                                                    const Duration(seconds: 0),
                                                fadeOutDuration:
                                                    const Duration(seconds: 0),
                                                imageUrl: data.profilePic ?? "",
                                                placeholder: (context, url) {
                                                  return Container(
                                                      color:
                                                          Colors.grey.shade300,
                                                      child:
                                                          Icon(Icons.person));
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.business == true
                                                ? data.name ?? ""
                                                : "${data.firstName ?? ""} ${data.lastName ?? ""}"
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
                                                  initialRating: data
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
                                                  (data.reviewsCount ?? 0)
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontFamily:
                                                        Constants.FONT_ARIEN,
                                                    fontSize: 13.sp,
                                                    color:
                                                        const Color(0xFF757280),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          data.business == true
                                              ? Text(
                                                  "${data.subCategoryName ?? data.categoryName ?? ""}"
                                                      .trimRight(),
                                                  style: TextStyle(
                                                    fontFamily:
                                                        Constants.FONT_ARIEN,
                                                    fontSize: 14.sp,
                                                    color:
                                                        const Color(0xff707070),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                )
                                              : Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "${Utilities().getAge(data.dateOfBirth ?? "")}" +
                                                              "Y".tr,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                Constants
                                                                    .FONT_ARIEN,
                                                            fontSize: 16.sp,
                                                            color: const Color(
                                                                0xff707070),
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                        SizedBox(
                                                          width: 8.w,
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Color(
                                                                0xff707070),
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
                                                              fontFamily:
                                                                  Constants
                                                                      .FONT_ARIEN,
                                                              fontSize: 14.sp,
                                                              color: const Color(
                                                                  0xff707070),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
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
                                                            fontFamily:
                                                                Constants
                                                                    .FONT_ARIEN,
                                                            fontSize: 10.sp,
                                                            color: const Color(
                                                                0xff707070),
                                                          ),
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                        ],
                                      ))
                                    ],
                                  ),
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
                  ),
                ),
        ],
      );
  }
}
