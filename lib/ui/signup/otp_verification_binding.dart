import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/category.dart';
import 'package:hippo/models/member.dart';
import 'package:hippo/models/service_provider.dart';
import 'package:hippo/models/user.dart';
import 'package:hippo/view_models/member/member_controller.dart';

/// createdby Daewu Bintara
/// Saturday, 1/30/21

class OTPVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OTPVerificationController());
  }
}

class OTPVerificationController extends BaseController {
  TextEditingController otpController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    //setScreenState = screenStateLoading;
    // MyTranslations.init();
  }

  Future register(String otp) async {
    showLoadingDialog();
    var map = new Map<String, dynamic>();
    map = Get.parameters;
    map["otp"] = otp;

    var res = await doRegister(map);

    hideDialog();
    String text = '';

    if (res.isError!) text = XR().string.error_message;

    if (res.status == true) {
      try {
        var user = User.fromJson(res.body['result']);
        box.write(MyConfig.USER_DATA, user.toJson());
        box.write(MyConfig.IS_LOGGED_IN, true);
        text = res.messages!;

        box.write(MyConfig.TOKEN_STRING_KEY, user.apiToken);
        text = res.messages!;
        showSimpleSuccessSnackBar(message: text);
        Get.offAllNamed(RouterName.dashboard);
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

  Future resendOTP() async {
    showLoadingDialog();
    var map = new Map<String, dynamic>();
    map = Get.parameters;

    var res = await sendOTP(map);

    hideDialog();
    String text = '';

    if (res.isError!) text = XR().string.error_message;

    if (res.status == true) {
      try {

        text = res.messages!;
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
