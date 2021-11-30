import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';

/// createdby Daewu Bintara
/// Saturday, 1/30/21

class ForgotOTPVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotOTPVerificationController());
  }
}

class ForgotOTPVerificationController extends BaseController {
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

    var res = await checkOTP(map);

    hideDialog();
    String text = '';

    if (res.isError!) text = XR().string.error_message;

    if (res.status == true) {
      try {
        print(res);
        var map2 = new Map<String, String>();
        map2["email"] = map["email"];
        map2["otp"] = otp;
        Get.toNamed(RouterName.resetPassword, parameters: map2);
        // var user = User.fromJson(res.body['result']);
        // box.write(MyConfig.USER_DATA, user.toJson());
        // box.write(MyConfig.IS_LOGGED_IN, true);
        // text = res.messages!;
        //
        // box.write(MyConfig.TOKEN_STRING_KEY, user.apiToken);
        // text = res.messages!;
        // showSimpleSuccessSnackBar(message: text);
        // Get.offAllNamed(RouterName.dashboard);
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
