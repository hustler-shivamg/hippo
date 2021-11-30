import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/member.dart';
import 'package:hippo/view_models/member/member_controller.dart';

/// createdby Daewu Bintara
/// Saturday, 1/30/21

class TestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TestController());
    Get.lazyPut(() => MemberController());
  }
}

class TestController extends BaseController {
  var count = 0;
  var member = Member();

  @override
  void onInit() async {
    setEnableScrollController = true;
    super.onInit();
    await 2.delay();
    setScreenState = screenStateOk;
    update();
  }

  void increment() {
    count++;
    update();
  }

  void entryMember() {
    member = Member(id: 1, name: "Daewu BP");
    update();
  }

  void onGetMember() async {
    showLoadingDialog();

    var res = await getDataMember();
    hideDialog();
    String text = '';

    if (res.isError!) text = XR().string.error_message;

    if (res.status == true) {
      try {
        var member = Member.fromMap(res.body['member']);
        text = member.name!;
      } catch (e) {
        text = XR().string.error_message;
      }
    } else {
      text = res.text!;
    }
    showSnackBar(title: "Response", message: text);
  }

  void onLogin() async {
    showLoadingDialog();
    var map = new Map<String, dynamic>();
    map["email"] = "hustler.jinal@gmail.com";
    map["password"] = "123456";

    var res = await login(map);

    hideDialog();
    String text = '';

    if (res.isError!) text = XR().string.error_message;



    if (res.status == true) {
      try {
        var member = Member.fromMap(res.body['member']);
        text = member.name!;
      } catch (e) {
        text = XR().string.error_message;
      }
    } else {
      text = res.text!;
    }
    showSnackBar(title: "Response", message: text);
  }

  void showAlertDialog() {
    showAlert(
        title: "Haloo",
        content: Text("Halo this is content"),
        barrierDismissible: false,
        confirmTextColor: Colors.white,
        textConfirm: "Okee",
        textCancel: "Batal",
        onConfirm: () {
          hideDialog();
        },
        onCancel: () {},
        actions: []);
  }

  void changeTheme() {
    if (Get.isDarkMode) {
      AppThemes().changeThemeMode(ThemeMode.light);
    } else {
      AppThemes().changeThemeMode(ThemeMode.dark);
    }
  }
}
