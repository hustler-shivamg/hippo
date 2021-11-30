import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/ui/signup/otp_verification_binding.dart';
import 'package:hippo/utils/constants.dart';
import 'package:hippo/utils/styling.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class OTPVerificationScreen extends BaseView<OTPVerificationController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var mPin = "";

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
                            'confirmation'.tr,
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
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 142.h,
                  ),
                  Center(
                    child: Text(
                      'Verify code sent to your phone,',
                      style: TextStyle(
                        fontFamily: Constants.FONT_ARIEN,
                        fontSize: 18.sp,
                        color: const Color(0xFF707070),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:  EdgeInsets.symmetric(horizontal: 50.w),
                                          child: OTPTextField(
                                            length: 4,
                                            width: MediaQuery.of(context).size.width,
                                            textFieldAlignment: MainAxisAlignment.spaceAround,
                                            fieldStyle: FieldStyle.box,
                                            fieldWidth: 48.w,

                                            margin: EdgeInsets.symmetric(horizontal: 0.w),
                                            style: TextStyle(fontSize: 20.sp),
                                            onChanged: (pin) {
                                              print("Changed: " + pin);
                                              mPin = pin;
                                            },
                                            onCompleted: (pin) {
                                              print("Completed: " + pin);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 110.h,
                                        ),
                                        // Text(
                                        //   'AcceptCode'.tr,
                                        //   style: TextStyle(
                                        //     fontFamily: Constants.FONT_ARIEN,
                                        //     fontSize: 18.sp,
                                        //     color: const Color(0xff707070),
                                        //   ),
                                        //   textAlign: TextAlign.center,
                                        // ),
                                        // SizedBox(
                                        //   height: 22.h,
                                        // ),
                                        InkWell(
                                          onTap: () {
                                            controller.resendOTP();
                                          },
                                          child: Text(
                                            'retryCode'.tr,
                                            style: TextStyle(
                                              fontFamily: Constants.FONT_ARIEN,
                                              fontSize: 18.sp,
                                              color: const Color(0xff0c6bc2),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              InkWell(
                                onTap: () {
                                  controller.register(mPin);
                                },
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      'Verify'.tr,
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 19.sp,
                                        color: const Color(0xffffffff),

                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  margin: EdgeInsets.only(bottom: 76.h, top: 153.h),
                                  height: 48.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14.r),
                                    color: const Color(0xff0c6bc2),

                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      );
  }
}
