import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/ui/login/forgot_binding.dart';
import 'package:hippo/utils/constants.dart';
import 'package:hippo/utils/styling.dart';
import 'package:hippo/x_utils/validator.dart';
import 'package:hippo/x_utils/widgets/my_text_form_field.dart';

class ForgotPassword extends BaseView<ForgotController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode? email = FocusNode();

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
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
                              "Forgot Password",
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
            SizedBox(
              height: 40.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
               physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 26.h),
                      child: Text(
                        "Enter Your Email Id",
                        style: TextStyle(
                          fontFamily: Constants.FONT_ARIEN,
                          fontSize: 22.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 43.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 26.h, right: 26.h),
                      child: MyTextFormField(
                        labelText: "email".tr,
                        focusNode: email,
                        validator: Validator().email,
                        controller: controller.emailController,
                      ),
                    ),
                    SizedBox(
                      height: 43.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 26.h, right: 26.h),
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            controller.sendForgotEmail();
                          }
                        },
                        child: Container(
                          child: Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                fontFamily: Constants.FONT_ARIEN,
                                fontSize: 19.sp,
                                color: const Color(0xffffffff),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          height: 48.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.r),
                            color: const Color(0xFF0C6BC2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
