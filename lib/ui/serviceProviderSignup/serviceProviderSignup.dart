import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/all_dropdown_values.dart';
import 'package:hippo/ui/pickerWorkExperiance.dart';
import 'package:hippo/ui/serviceProviderSignup/service_provider_signup_binding.dart';
import 'package:hippo/utils/constants.dart';
import 'package:hippo/x_utils/validator.dart';
import 'package:hippo/x_utils/widgets/my_text_form_field.dart';
import 'package:hippo/x_utils/widgets/app_dropdown_input.dart';
import 'package:hippo/ui/pickers/singleChoicePicker.dart';
import 'package:hippo/ui/pickers/multiChoicePicker.dart';
import 'package:get/get.dart';
import 'package:hippo/models/picker_result.dart';
import 'package:hippo/x_utils/widgets/toggle.dart';
import 'package:image_picker/image_picker.dart';

class ServiceProviderSignup extends BaseView<ServiceProviderSignupController> {
  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(context),
    );
  }

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      controller.image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    controller.refresh();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var formatter = DateFormat('dd-MM-yyyy');

  FocusNode? fname = FocusNode(),
      lname = FocusNode(),
      email = FocusNode(),
      password = FocusNode(),
      dob = FocusNode(),
      about = FocusNode(),
      homephone = FocusNode(),
      mobile = FocusNode(),
      city = FocusNode(),
      postal = FocusNode();

//  TextEditingController _date = new TextEditingController();

  _body(BuildContext context) {
    if (controller.screenStateIsLoading)
      return Center(child: CircularProgressIndicator());
    if (controller.screenStateIsError) return Text(XR().string.error_message);
    if (controller.screenStateIsOK) {
      Future<Null> _selectDate(BuildContext context) async {
        if (controller.selectedDate == null) {
          controller.selectedDate = DateTime.now();
        }
        final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: controller.selectedDate!,
            firstDate: DateTime(1901, 1),
            lastDate: DateTime.now());
        if (picked != null && picked != controller.selectedDate) {
          controller.selectedDate = picked;
          //        _date.value = TextEditingValue(text: picked.toString());
          controller.refresh();
          // setState(() {
          //
          // });

        }
      }

      return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 49.h,
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
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
                                height: 20.h,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          'registration'.tr,
                          style: TextStyle(
                            fontFamily: Constants.FONT_ARIEN,
                            fontSize: 32.sp,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      child: Container(
                        margin: EdgeInsets.only(right: 10.w),
                        width: 37.w,
                        height: 37.h,
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
                ],
              ),
              SizedBox(
                height: 28.h,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 6.h,
                      ),
                      Container(
                        width: double.infinity,
                        height: 140.h,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/sp_signup_bg.svg',
                              width: double.infinity,
                              height: 89.h,
                              fit: BoxFit.contain,
                            ),
                            InkWell(
                              onTap: () {
                                getImage();
                              },
                              child: Container(
                                width: 144.h,
                                height: 144.h,
                                child: controller.image == null
                                    ? Container(
                                        margin: EdgeInsets.all(8.r),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/images/upload_pic_bg.svg',
                                              width: 138.w,
                                              height: 138.w,
                                              fit: BoxFit.contain,
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/upload_pic_camera.svg',
                                                  height: 53.h,
                                                  fit: BoxFit.contain,
                                                ),
                                                SizedBox(
                                                  height: 4.h,
                                                ),
                                                Text(
                                                  'Download'.tr,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        Constants.FONT_ARIEN,
                                                    fontSize: 12.sp,
                                                    color:
                                                        const Color(0xffffffff),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        margin: EdgeInsets.all(1.r),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(
                                                  9999.0, 9999.0)),
                                          image: DecorationImage(
                                            image: FileImage(
                                              controller.image!,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xffffffff),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x29000000),
                                      offset: Offset(0, 0),
                                      blurRadius: 6.r,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 28.h,
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
                              height: 14.4.h,
                            ),
                            MyTextFormField(
                              labelText: "lname".tr,
                              focusNode: lname,
                              focusNodeNext: about,
                              controller: controller.lnameController,
                              validator: Validator().notEmpty,
                              onSaved: (value) =>
                                  controller.lnameController.text = value!,
                            ),
                            SizedBox(
                              height: 14.h,
                            ),
                            InkWell(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.w, right: 40.w),
                                        child: Text(
                                          controller.selectedDate == null
                                              ? "BirthDate".tr
                                              : formatter.format(
                                                  controller.selectedDate!),
                                          style: TextStyle(
                                            fontFamily: Constants.FONT_ARIEN,
                                            fontSize: 18.sp,
                                            color:
                                                controller.selectedDate == null
                                                    ? Color(0x77707070)
                                                    : Color(0xFF000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 12.5.w),
                                        child: SvgPicture.asset(
                                          'assets/images/spr_cal.svg',
                                          width: 24.w,
                                          height: 23.h,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                height: 55.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: const Color(0xffffffff),
                                  border: Border.all(
                                      width: 1.w,
                                      color: const Color(0x48707070)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 14.h,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: MyTextFormField(
                                      labelText: "AboutMe".tr,
                                      focusNode: about,
                                      focusNodeNext: homephone,
                                      padding: EdgeInsets.only(
                                          left: 20.w,
                                          top: 10.w,
                                          bottom: 10.w,
                                          right: 35.w),
                                      controller: controller.aboutController,
                                      validator: Validator().notEmpty,
                                      onSaved: (value) => controller
                                          .aboutController.text = value!,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 12.5.w),
                                      child: SvgPicture.asset(
                                        'assets/images/spl_edit_icon.svg',
                                        width: 24.w,
                                        height: 22.h,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              height: 55.h,
                            ),
                            SizedBox(
                              height: 14.h,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 20.w, right: 40.w),
                                      child: Text(
                                        "Sex".tr,
                                        style: TextStyle(
                                          fontFamily: Constants.FONT_ARIEN,
                                          fontSize: 18.sp,
                                          color: const Color(0xff707070),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          color: const Color(0x48707070),
                                          width: 1.w,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.isMale = true;
                                            controller.refresh();
                                          },
                                          child: Container(
                                            color: controller.isMale == true
                                                ? Colors.grey.shade300
                                                : Colors.white,
                                            child: Center(
                                                child: Text(
                                              "Male".tr,
                                              style: TextStyle(
                                                fontFamily:
                                                    Constants.FONT_ARIEN,
                                                fontSize: 14.sp,
                                                color: const Color(0xff707070),
                                              ),
                                            )),
                                            width: 100.w,
                                          ),
                                        ),
                                        Container(
                                          color: const Color(0x48707070),
                                          width: 1.w,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.isMale = false;
                                            controller.refresh();
                                          },
                                          child: Container(
                                            color: controller.isMale == false
                                                ? Colors.grey.shade300
                                                : Colors.white,
                                            child: Center(
                                                child: Text(
                                              "Female".tr,
                                              style: TextStyle(
                                                fontFamily:
                                                    Constants.FONT_ARIEN,
                                                fontSize: 14.sp,
                                                color: const Color(0xff707070),
                                              ),
                                            )),
                                            width: 100.w,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              height: 55.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: const Color(0xffffffff),
                                border: Border.all(
                                    width: 1.w, color: const Color(0x48707070)),
                              ),
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            Text(
                              'phone'.tr,
                              style: TextStyle(
                                fontFamily: Constants.FONT_ARIEN,
                                fontSize: 22.sp,
                                color: const Color(0xff0c6bc2),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            MyTextFormField(
                              focusNode: homephone,
                              focusNodeNext: mobile,
                              labelText: "homePhone".tr,
                              controller: controller.phoneController,
                              validator: Validator().notEmpty,
                              inputNumber: true,
                              onSaved: (value) =>
                                  controller.phoneController.text = value!,
                            ),
                            SizedBox(
                              height: 14.4.h,
                            ),
                            MyTextFormField(
                              labelText: "cellPhone".tr,
                              focusNode: mobile,
                              focusNodeNext: city,
                              controller: controller.cellPhoneController,
                              validator: Validator().notEmpty,
                              inputNumber: true,
                              onSaved: (value) =>
                                  controller.cellPhoneController.text = value!,
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            Text(
                              'Address'.tr,
                              style: TextStyle(
                                fontFamily: Constants.FONT_ARIEN,
                                fontSize: 22.sp,
                                color: const Color(0xff0c6bc2),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            MyTextFormField(
                              labelText: "City".tr,
                              focusNode: city,
                              focusNodeNext: postal,
                              controller: controller.cityController,
                              validator: Validator().notEmpty,
                              onSaved: (value) =>
                                  controller.cityController.text = value!,
                            ),
                            SizedBox(
                              height: 14.4.h,
                            ),
                            AppDropdownInput<DropdownValues>(
                              hintText: "Provence".tr,
                              options: controller.allValues!.state!,
                              value: controller.selectedState,
                              onChanged: (value) {
                                controller.selectedState = value;
                                controller.refresh();
                              },
                              getLabel: (DropdownValues? value) => value!.name!,
                            ),
                            SizedBox(
                              height: 14.4.h,
                            ),
                            MyTextFormField(
                              labelText: "PostalCode".tr,
                              focusNode: postal,
                              inputNumber: true,
                              controller: controller.pincodeController,
                              validator: Validator().notEmpty,
                              onSaved: (value) =>
                                  controller.pincodeController.text = value!,
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            Text(
                              'Education'.tr,
                              style: TextStyle(
                                fontFamily: Constants.FONT_ARIEN,
                                fontSize: 22.sp,
                                color: const Color(0xff0c6bc2),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            InkWell(
                              onTap: () async {
                                PickerResult? result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => SingleChoicePicker(
                                              title: "Education".tr,
                                              subTitle: "Education".tr,
                                              data: controller
                                                  .allValues?.educations!,
                                              commentTitle: "Education".tr,
                                            )));

                                if (result != null) {
                                  controller.education = result;

                                  print(result.title);
                                  print(result.selectedList?.length);
                                  controller.refresh();
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.w, right: 40.w),
                                        child: Text(
                                          "Education".tr,
                                          style: TextStyle(
                                            fontFamily: Constants.FONT_ARIEN,
                                            fontSize: 18.sp,
                                            color: const Color(0x77707070),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 12.5.w),
                                        child: SvgPicture.asset(
                                          'assets/images/spl_chevron.svg',
                                          width: 12.w,
                                          height: 20.5.h,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                height: 55.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: const Color(0xffffffff),
                                  border: Border.all(
                                      width: 1.w,
                                      color: const Color(0x48707070)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 14.h,
                            ),
                            InkWell(
                              onTap: () async {
                                PickerResult? result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => SingleChoicePicker(
                                              title: "Occupation".tr,
                                              subTitle: "Occupation".tr,
                                              data: controller
                                                  .allValues?.occupations!,
                                              showComment: false,
                                            )));

                                if (result != null) {
                                  controller.occupations = result;

                                  print(result.title);
                                  print(result.selectedList?.length);
                                  controller.refresh();
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.w, right: 40.w),
                                        child: Text(
                                          "Occupation".tr,
                                          style: TextStyle(
                                            fontFamily: Constants.FONT_ARIEN,
                                            fontSize: 18.sp,
                                            color: const Color(0x77707070),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 12.5.w),
                                        child: SvgPicture.asset(
                                          'assets/images/spl_chevron.svg',
                                          width: 12.w,
                                          height: 20.5.h,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                height: 55.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: const Color(0xffffffff),
                                  border: Border.all(
                                      width: 1.w,
                                      color: const Color(0x48707070)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 14.h,
                            ),
                            InkWell(
                              child: Container(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.w, right: 40.w),
                                        child: Text(
                                          "Languageknowledge".tr,
                                          style: TextStyle(
                                            fontFamily: Constants.FONT_ARIEN,
                                            fontSize: 18.sp,
                                            color: const Color(0x77707070),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 12.5.w),
                                        child: SvgPicture.asset(
                                          'assets/images/spl_chevron.svg',
                                          width: 12.w,
                                          height: 20.5.h,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                height: 55.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: const Color(0xffffffff),
                                  border: Border.all(
                                      width: 1.w,
                                      color: const Color(0x48707070)),
                                ),
                              ),
                              onTap: () async {
                                PickerResult? result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MultiChoicePicker(
                                              title: "Languageknowledge".tr,
                                              subTitle: "Language".tr,
                                              data: controller
                                                  .allValues?.languages!,
                                              showComment: false,
                                            )));

                                if (result != null) {
                                  controller.languagesKnown = result;

                                  print(result.title);
                                  print(result.selectedList?.length);
                                  controller.refresh();
                                }
                              },
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            Text(
                              'WorkExperience'.tr,
                              style: TextStyle(
                                fontFamily: Constants.FONT_ARIEN,
                                fontSize: 22.sp,
                                color: const Color(0xff0c6bc2),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            InkWell(
                              onTap: () async {
                                PickerResult? result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MultiChoicePicker(
                                              title: "WorkExperience".tr,
                                              subTitle: "IhaveExperience".tr,
                                              data: controller
                                                  .allValues?.workExperiences!,
                                              commentTitle: "Experience".tr,
                                            )));

                                if (result != null) {
                                  controller.workExperiance = result;

                                  print(result.title);
                                  print(result.selectedList?.length);
                                  controller.refresh();
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.w, right: 40.w),
                                        child: Text(
                                          "Experience".tr,
                                          style: TextStyle(
                                            fontFamily: Constants.FONT_ARIEN,
                                            fontSize: 18.sp,
                                            color: const Color(0x77707070),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 12.5.w),
                                        child: SvgPicture.asset(
                                          'assets/images/spl_chevron.svg',
                                          width: 12.w,
                                          height: 20.5.h,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                height: 55.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: const Color(0xffffffff),
                                  border: Border.all(
                                      width: 1.w,
                                      color: const Color(0x48707070)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            Text(
                              'Payments'.tr,
                              style: TextStyle(
                                fontFamily: Constants.FONT_ARIEN,
                                fontSize: 22.sp,
                                color: const Color(0xff0c6bc2),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              children: [
                                AppToggle(
                                  value: controller.perHour,
                                  onToggle: (value) {
                                    if (value == false) {
                                      controller.perHourController.clear();
                                    }
                                    controller.perHour = value;
                                    controller.refresh();
                                  },
                                ),
                                SizedBox(
                                  width: 13.w,
                                ),
                                Text(
                                  'PerHour'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 18.sp,
                                    color: const Color(0xff707070),
                                  ),
                                ),
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    child: TextField(
                                      controller: controller.perHourController,
                                      enabled: controller.perHour,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontFamily: Constants.FONT_ARIEN,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                          isDense: true,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          hintText: "Amount".tr,
                                          hintStyle: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontFamily: Constants.FONT_ARIEN,
                                            fontSize: 18.sp,
                                            color: const Color(0x77707070),
                                          )),
                                    ),
                                    width: 95.w,
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              children: [
                                AppToggle(
                                  value: controller.perDay,
                                  onToggle: (value) {
                                    if (value == false) {
                                      controller.perDayController.clear();
                                    }
                                    controller.perDay = value;
                                    controller.refresh();
                                  },
                                ),
                                SizedBox(
                                  width: 13.w,
                                ),
                                Text(
                                  'PerDay'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 18.sp,
                                    color: const Color(0xff707070),
                                  ),
                                ),
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    child: TextField(
                                      enabled: controller.perDay,
                                      controller: controller.perDayController,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontFamily: Constants.FONT_ARIEN,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                          isDense: true,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          hintText: "Amount".tr,
                                          hintStyle: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontFamily: Constants.FONT_ARIEN,
                                            fontSize: 18.sp,
                                            color: const Color(0x77707070),
                                          )),
                                    ),
                                    width: 95.w,
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              children: [
                                AppToggle(
                                  value: controller.perMonth,
                                  onToggle: (value) {
                                    if (value == false) {
                                      controller.perMonthController.clear();
                                    }
                                    controller.perMonth = value;
                                    controller.refresh();
                                  },
                                ),
                                SizedBox(
                                  width: 13.w,
                                ),
                                Text(
                                  'PerMonth'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 18.sp,
                                    color: const Color(0xff707070),
                                  ),
                                ),
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    child: TextField(
                                      enabled: controller.perMonth,
                                      controller: controller.perMonthController,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontFamily: Constants.FONT_ARIEN,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                          isDense: true,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          hintText: "Amount".tr,
                                          hintStyle: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontFamily: Constants.FONT_ARIEN,
                                            fontSize: 18.sp,
                                            color: const Color(0x77707070),
                                          )),
                                    ),
                                    width: 95.w,
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            Text(
                              'Other'.tr,
                              style: TextStyle(
                                fontFamily: Constants.FONT_ARIEN,
                                fontSize: 22.sp,
                                color: const Color(0xff0c6bc2),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              children: [
                                AppToggle(
                                  value: controller.smoker,
                                  onToggle: (value) {
                                    controller.smoker = value;
                                    controller.refresh();
                                  },
                                ),
                                SizedBox(
                                  width: 13.w,
                                ),
                                Text(
                                  'Smoker'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 18.sp,
                                    color: const Color(0xff707070),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                AppToggle(
                                  value: controller.haveKids,
                                  onToggle: (value) {
                                    controller.haveKids = value;
                                    controller.refresh();
                                  },
                                ),
                                SizedBox(
                                  width: 13.w,
                                ),
                                Text(
                                  'Havekids'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 18.sp,
                                    color: const Color(0xff707070),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                AppToggle(
                                  value: controller.haveDrivingLicance,
                                  onToggle: (value) {
                                    controller.haveDrivingLicance = value;
                                    controller.refresh();
                                  },
                                ),
                                SizedBox(
                                  width: 13.w,
                                ),
                                Text(
                                  'Havedrivinglicense'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 18.sp,
                                    color: const Color(0xff707070),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                AppToggle(
                                  value: controller.haveCar,
                                  onToggle: (value) {
                                    controller.haveCar = value;
                                    controller.refresh();
                                  },
                                ),
                                SizedBox(
                                  width: 13.w,
                                ),
                                Text(
                                  'Havecar'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 18.sp,
                                    color: const Color(0xff707070),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            SizedBox(
                              height: 74.h,
                            ),
                            InkWell(
                              onTap: () {
                                if (controller.fnameController.text.isEmpty) {
                                  controller.showSimpleErrorSnackBar(
                                      message: "Please Enter First Name");
                                } else if (controller
                                    .lnameController.text.isEmpty) {
                                  controller.showSimpleErrorSnackBar(
                                      message: "Please Enter Last Name");
                                } else if (controller.selectedDate == null) {
                                  controller.showSimpleErrorSnackBar(
                                      message: "Please Enter Birth Date");
                                } else if (controller
                                    .aboutController.text.isEmpty) {
                                  controller.showSimpleErrorSnackBar(
                                      message: "Please Enter About");
                                } else if (controller.isMale == null) {
                                  controller.showSimpleErrorSnackBar(
                                      message: "Please Select Gender");
                                }
                                // else if (controller
                                //     .phoneController.text.isEmpty) {
                                //   controller.showSimpleErrorSnackBar(
                                //       message: "Please Enter Home Phone");
                                // }
                                else if (controller
                                    .cellPhoneController.text.isEmpty) {
                                  controller.showSimpleErrorSnackBar(
                                      message: "Please Enter Cell Phone");
                                }
                                // else if (controller
                                //     .cityController.text.isEmpty) {
                                //   controller.showSimpleErrorSnackBar(
                                //       message: "Please Enter City");
                                // } else if (controller.selectedState == null) {
                                //   controller.showSimpleErrorSnackBar(
                                //       message: "Please Select Provence");
                                // } else if (controller
                                //     .pincodeController.text.isEmpty) {
                                //   controller.showSimpleErrorSnackBar(
                                //       message: "Please Enter Postal code");
                                // } else if (controller.education == null) {
                                //   controller.showSimpleErrorSnackBar(
                                //       message: "Please Enter Education");
                                // } else if (controller.occupations == null) {
                                //   controller.showSimpleErrorSnackBar(
                                //       message: "Please Enter Occupation");
                                // } else if (controller.languagesKnown == null) {
                                //   controller.showSimpleErrorSnackBar(
                                //       message: "Please Enter Language known");
                                // } else if (controller.workExperiance == null) {
                                //   controller.showSimpleErrorSnackBar(
                                //       message: "Please Enter Work Experience");
                                // }
                                else if (controller.perHour == true &&
                                    controller.perHourController.text.isEmpty) {
                                  controller.showSimpleErrorSnackBar(
                                      message: "Please Enter Per Hour Amount");
                                } else if (controller.perDay == true &&
                                    controller.perDayController.text.isEmpty) {
                                  controller.showSimpleErrorSnackBar(
                                      message: "Please Enter Per Day Amount");
                                } else if (controller.perMonth == true &&
                                    controller
                                        .perMonthController.text.isEmpty) {
                                  controller.showSimpleErrorSnackBar(
                                      message: "Please Enter Per Month Amount");
                                } else {
                                  controller.makeCaregiverRegisterApiCall();
                                }
                              },
                              child: Container(
                                child: Center(
                                  child: Text(
                                    'Register'.tr,
                                    style: TextStyle(
                                      fontFamily: Constants.FONT_ARIEN,
                                      fontSize: 22.sp,
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                margin: EdgeInsets.only(bottom: 30.h),
                                height: 67.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
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
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      );
    }
  }
}
