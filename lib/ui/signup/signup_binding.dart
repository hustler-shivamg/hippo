import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';

/// createdby Daewu Bintara
/// Saturday, 1/30/21

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupController());
  }
}

class SignupController extends BaseController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    // emailController.text = "ajay@gmail.com";
    // passwordController.text = "123456";
    // fnameController.text = "Ajay";
    // lnameController.text = "Jadeja";
    // phoneController.text = "1234567890";
  }

  @override
  void onInit() async {
    super.onInit();
    //setScreenState = screenStateLoading;
    // MyTranslations.init();
  }

  // @override
  // Future<void> onReady() async {
  //   super.onReady();
  //   var id = Get.arguments;
  //
  // }

  Future sendOtp() async {
    showLoadingDialog();
    var map = new Map<String, dynamic>();

    map["email"] = emailController.text.trim();

    var res = await sendOTP(map);

    hideDialog();
    String text = '';

    if (res.isError!) text = XR().string.error_message;

    if (res.status == true) {
      try {
        var map = new Map<String, String>();
        map["first_name"] = fnameController.text.trim();
        map["last_name"] = lnameController.text.trim();
        map["cell_phone"] = phoneController.text.trim();
        map["email"] = emailController.text.trim();
        map["password"] = passwordController.text.trim();
        map["service_provider"] = "0";
        map["profile_pic"] = "";
        Get.toNamed(RouterName.otpVerification, parameters: map);
      } catch (e) {
        e.printError();
        text = "Something went wrong, try again later...";
        showSimpleErrorSnackBar( message: text);
      }
    } else {
      text = res.messages!;
      showSimpleErrorSnackBar( message: text);
    }

  }
}
