import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/ui/addReview/add_review_binding.dart';
import 'package:hippo/utils/constants.dart';
import 'package:hippo/utils/styling.dart';
import 'package:get/get.dart';
import 'package:hippo/x_utils/validator.dart';
import 'package:hippo/x_utils/widgets/my_text_form_field.dart';

import '../caregiverDetail.dart';

class AddReviewScreen extends BaseView<AddReviewController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode? comment;
  TextEditingController commentController = TextEditingController();
  var rating = 0;

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                              'Review'.tr,
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
                child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 44.h,
                    ),
                    Center(
                      child: RatingBar(
                        itemSize: 38.r,
                        updateOnDrag: true,
                        initialRating: 0,
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
                        itemPadding: EdgeInsets.symmetric(horizontal: 1.5.w),
                        onRatingUpdate: (mRating) {
                          rating = mRating.toInt();
                          print(rating);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: MyTextFormField(

                        controller: commentController,
                        labelText: "",
                        validator: Validator().notEmpty,
                        maxLines: 8,
                        minLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                              fontFamily: Constants.FONT_ARIEN,
                              fontSize: 17.sp,
                              color: const Color(0xff1c1c1c),
                              height: 2),
                          children: [
                            TextSpan(
                              text: 'Please save'.tr + "\n",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text:
                              ' - Correctness\n - Do not insult each other\n - personal privacy \n'.tr,
                            ),
                            TextSpan(
                              text: ' ',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          if (rating == 0) {
                            controller.showSimpleErrorSnackBar(
                                message: "Please select rating");
                          } else if (commentController.text.isEmpty) {
                            controller.showSimpleErrorSnackBar(
                                message: "Please enter comment");
                          }else{
                            controller.addReview(rating.toString(),
                                commentController.text.toString());
                          }
                        },
                        child: Container(
                          width: 334.w,
                          height: 67.h,
                          child: Center(
                            child: Text(
                              'Post'.tr,
                              style: TextStyle(
                                height: 1,
                                fontFamily: Constants.FONT_ARIEN,
                                fontSize: 22.sp,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xff0c6bc2),
                            border: Border.all(
                                width: 1.0, color: const Color(0xffffffff)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 60,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      );
    }
  }
}
