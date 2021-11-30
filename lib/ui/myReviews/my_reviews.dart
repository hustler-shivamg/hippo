import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/base/widget_state.dart';
import 'package:hippo/ui/myReviews/my_reviews_binding.dart';
import 'package:hippo/utils/constants.dart';
import 'package:hippo/utils/styling.dart';

class MyReviewsScreen extends BaseView<MyReviewsController> {
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
                              'MyReviews'.tr,
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
                physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                // shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 18.h),
                itemCount: controller.dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  var reviewData = controller.dataList[index];
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reviewData.businessName.toString(),
                                    style: TextStyle(
                                      fontFamily: Constants.FONT_ARIEN,
                                      fontSize: 18.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  RatingBar(
                                    itemSize: 15.r,
                                    ignoreGestures: true,
                                    initialRating:
                                        (reviewData.rating ?? 0).toDouble(),
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
                                    height: 10.h,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  InkWell(
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    ),
                                    onTap: () async {
                                      var map2 = new Map<String, String>();
                                      map2["review_id"] = reviewData.id.toString();
                                      map2["review"] =
                                          reviewData.reviewText.toString();
                                      map2["rating"] = reviewData.rating.toString();
                                      var data = await Get.toNamed(
                                          RouterName.editReview,
                                          parameters: map2);
                                      if (data != null) {
                                        controller.setScreenState =
                                            ScreenState().screenStateLoading;
                                        controller.update();
                                        controller.onReady();
                                      }
                                    },
                                  ),
                                  SizedBox(width: 20),
                                  InkWell(
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onTap: () {
                                      controller.deletereview(
                                          reviewData.id.toString(), index);
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Text(
                            reviewData.reviewText ?? "",
                            // overflow: reviewData.reviewText!.length >30 ? TextOverflow.ellipsis : null,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: Constants.FONT_ARIEN,
                              fontSize: 14.sp,
                              color: const Color(0xFF757280),
                            ),
                          ),
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
            )

          ],
        ),
      );
    }
  }
}
