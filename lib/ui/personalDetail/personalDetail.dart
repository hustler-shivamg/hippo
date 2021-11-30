import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/ui/personalDetail/personalDetail_binding.dart';
import 'package:hippo/ui/serviceProviderSignup/serviceProviderSignup.dart';
import 'package:hippo/utils/constants.dart';
import 'package:hippo/utils/styling.dart';
import 'package:hippo/x_utils/utilities.dart';
import 'package:hippo/x_utils/validator.dart';
import 'package:hippo/x_utils/widgets/my_text_form_field.dart';

class PersonalDetail extends BaseView<PersonalDetailController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode? fname = FocusNode(),
      lname = FocusNode(),
      email = FocusNode(),
      phone = FocusNode();

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

    if (controller.screenStateIsOK)
      return Column(
        children: [
          // SvgPicture.asset(
          //   'assets/images/signup_bg.svg',
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   fit: BoxFit.cover,
          // ),
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
                            'Profile'.tr,
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        // physics: new ClampingScrollPhysics(),
                        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: AutofillGroup(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 37.h,
                                ),

                                MyTextFormField(
                                  labelText: "fname".tr,
                                  focusNode: fname,
                                  focusNodeNext: lname,
                                  controller: controller.fnameController,
                                  validator: Validator().notEmpty,
                                  onSaved: (value) =>
                                  controller.fnameController.text = value!,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                MyTextFormField(
                                  labelText: "lname".tr,
                                  focusNode: lname,
                                  focusNodeNext: phone,
                                  controller: controller.lnameController,
                                  validator: Validator().notEmpty,
                                  onSaved: (value) =>
                                  controller.lnameController.text = value!,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                AutofillGroup(
                                  child: MyTextFormField(
                                    autofillHints: [AutofillHints.telephoneNumber],
                                    labelText: "phone".tr,
                                    focusNode: phone,
                                    focusNodeNext: email,
                                    controller: controller.phoneController,
                                    validator: Validator().notEmpty,
                                    inputNumber: true,
                                    onSaved: (value) =>
                                    controller.phoneController.text = value!,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                MyTextFormField(
                                  enabled: false,
                                  labelText: "email".tr,
                                  //focusNode: email,
                                  // focusNodeNext: password,
                                  controller: controller.emailController,
                                  // validator: Validator().email,
                                  onSaved: (value) =>
                                  controller.emailController.text = value!,
                                ),
                                SizedBox(
                                  height: 21.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());

                                      controller.sendOtp();

                                      //Get.toNamed(RouterName.otpVerification, parameters: ["ajay"]);
                                    }
                                  },
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        'Update Details'.tr,
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
                                      color: const Color(0xff0c6bc2),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0x29000000),
                                          offset: Offset(0, 3),
                                          blurRadius: 60.r,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 62.h,
                                ),
                                // SizedBox(height: 350.h,)
                              ],
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
      );
  }
}
