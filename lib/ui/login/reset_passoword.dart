import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippo/base/base_controller.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/ui/login/reset_password_binding.dart';
import 'package:hippo/utils/constants.dart';
import 'package:hippo/utils/styling.dart';
import 'package:hippo/x_utils/validator.dart';
import 'package:hippo/x_utils/widgets/my_text_form_field.dart';

class ResetPasswordScreen extends BaseView<ResetPasswordController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode? email = FocusNode(), password = FocusNode();

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
                            'resetpassword'.tr,
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
            child: SingleChildScrollView(
              // physics: new ClampingScrollPhysics(),
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Container(
                // height: double.infinity,
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 53.h, left: 26.w),
                        child: Text(
                          'Enter New Password'.tr,
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
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          children: [
                            MyTextFormField(
                              labelText: "newpassword".tr,
                              focusNode: password,
                              controller: controller.passwordController,
                              validator: Validator().password,
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 23.h,
                            ),
                            MyTextFormField(
                              labelText: "confirmpassword".tr,
                              focusNode: email,
                              controller: controller.confirmPassController,
                              validator: Validator().password,
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 33.h,
                            ),
                            InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  controller.signInWithEmailAndPassword();
                                }

                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (_) => HomeScreen()));
                              },
                              child: Container(
                                child: Center(
                                  child: Text(
                                    "update".tr,
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
                            SizedBox(
                              height: 37.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
  }
}
