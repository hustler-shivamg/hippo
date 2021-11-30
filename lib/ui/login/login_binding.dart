import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/user.dart';

/// createdby Daewu Bintara
/// Saturday, 1/30/21

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

class LoginController extends BaseController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    //  MyTranslations.init();

    setScreenState = screenStateOk;
    update();
  }



  void signInWithEmailAndPassword() async {
    showLoadingDialog();
    var map = new Map<String, dynamic>();

    map["email"] = emailController.text.trim();
    map["password"] = passwordController.text.trim();

    var res = await login(map);

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

        Get.offAllNamed(RouterName.dashboard);
        text = res.messages!;
        showSimpleSuccessSnackBar(message: text);
      } catch (e, stack) {
        print(stack);
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
