import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/user.dart';

/// createdby Daewu Bintara
/// Saturday, 1/30/21

class PersonalDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PersonalDetailController());
  }
}

class PersonalDetailController extends BaseController {
  TextEditingController emailController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  late User user1;


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
    getdta();
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

    map["first_name"] = fnameController.text.trim();
    map["last_name"] = lnameController.text.trim();
    map["cell_phone"] = phoneController.text.trim();
    map["email"] = emailController.text.trim();

    var res = await updateProfile(map);

    hideDialog();
    String text = '';

    if (res.isError!) text = XR().string.error_message;

    if (res.status == true) {
      try {
        var user = User.fromJson(res.body['result']);
        box.write(MyConfig.USER_DATA, user.toJson());
        // var map = new Map<String, String>();
        // map["first_name"] = fnameController.text.trim();
        // map["last_name"] = lnameController.text.trim();
        // map["cell_phone"] = phoneController.text.trim();
        // map["email"] = emailController.text.trim();
        // map["service_provider"] = "0";
        // map["profile_pic"] = "";
        // Get.toNamed(RouterName.otpVerification, parameters: map);
        Get.back(result: true);
        showSimpleSuccessSnackBar(message: res.body['message']);
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

  Future<void> getdta() async {
    var user = await box.read(MyConfig.USER_DATA);
    user1 = User.fromJson(user);
    emailController.text = user1.email.toString();

    fnameController.text = user1.enFirstName.toString();

    lnameController.text = user1.enLastName.toString();
    phoneController.text = user1.cellPhone.toString();
  }
}
