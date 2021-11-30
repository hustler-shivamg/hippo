import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/all_dropdown_values.dart';
import 'package:hippo/models/user.dart';
import 'package:hippo/models/picker_result.dart';

/// createdby Daewu Bintara
/// Saturday, 1/30/21

class ServiceProviderSignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServiceProviderSignupController());
  }
}

class ServiceProviderSignupController extends BaseController {
  var formatter = DateFormat('yyyy-MM-dd');

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cellPhoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController perHourController = TextEditingController();
  TextEditingController perDayController = TextEditingController();
  TextEditingController perMonthController = TextEditingController();
  File? image;

  DropDownResult? allValues;

  DateTime? selectedDate;
  bool? isMale;
  DropdownValues? selectedState;

  bool haveKids = false;
  bool haveCar = false;
  bool haveDrivingLicance = false;
  bool smoker = false;
  bool perHour = false;
  bool perMonth = false;
  bool perDay = false;

  PickerResult? workExperiance;
  PickerResult? education;
  PickerResult? occupations;
  PickerResult? languagesKnown;

  @override
  void onInit() async {
    super.onInit();
    setScreenState = screenStateLoading;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
//    var id = Get.arguments;

    await callGetAllDropDownAPI();
  }

  Future callGetAllDropDownAPI() async {
    var res = await getAllDropDowns();

    String text = '';

    if (res.isError!) text = XR().string.error_message;

    if (res.status == true) {
      try {
        allValues = DropDownResult.fromJson(res.body['result']);
      } catch (e) {
        print(e);

        text = XR().string.error_message;
      }
    } else {
      text = res.text!;
    }
    setScreenState = screenStateOk;
    refresh();
    //showSnackBar(title: "Response", message: text);
  }

  void makeCaregiverRegisterApiCall() async {
    showLoadingDialog();
    var map = new Map<String, dynamic>();

    //map = Get.parameters;
    if (image != null) {
      map["profile_pic"] = MultipartFile(image, filename: 'image.png');
    }
    map["first_name"] = fnameController.text;
    map["last_name"] = lnameController.text;
    map["cell_phone"] = cellPhoneController.text;
    //map["email"] = emailController.text;
    map["service_provider"] = "1";
    map["category_id"] = "1";
    map["sub_category_i"] = "";
    map["email"] = fnameController.text + lnameController.text + "@gmail.com";
    map["date_of_birth"] = formatter.format(selectedDate!);
    map["description"] = aboutController.text;
    map["gender"] = isMale == true ? "1" : "0";
    map["home_phone"] = phoneController.text;
    if (education != null) {
      map["education"] = education!.title;
      map["education_id"] = jsonEncode(
          education!.selectedList!.map((e) => e.id.toString()).toList());
    }

    if (occupations != null) {
      map["occupation"] = occupations!.title;
      map["occupation_id"] = jsonEncode(
          occupations!.selectedList!.map((e) => e.id.toString()).toList());
    }

    if (workExperiance != null) {
      map["work_experience"] = workExperiance!.title;
      map["work_experience_id"] = jsonEncode(
          workExperiance!.selectedList!.map((e) => e.id.toString()).toList());
    }

    if (languagesKnown != null) {
      map["language"] = jsonEncode(
          languagesKnown!.selectedList!.map((e) => e.id.toString()).toList());
    }
    map["price_per_hour"] = perHourController.text;
    map["price_per_day"] = perDayController.text;
    map["price_per_month"] = perMonthController.text;
    map["smoker"] = smoker ? "1" : "0";
    map["have_kids"] = haveKids ? "1" : "0";
    map["have_driving_license"] = haveDrivingLicance ? "1" : "0";
    map["have_car"] = haveCar ? "1" : "0";
    final form = FormData(map);

    var res = await doCaregiverRegister(form);

    hideDialog();
    String text = '';

    if (res.isError!) text = XR().string.error_message;

    if (res.status == true) {
      try {
        text = res.messages!;

        Get.back(result: true);
        showSimpleSuccessSnackBar(message: text);
      } catch (e) {
        e.printError();
        text = "Something went wrong, try again later...";
        showSimpleErrorSnackBar(message: text);
      }
    } else {
      text = res.messages!;
      showSimpleErrorSnackBar(message: text);
    }
  }
}
