import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/member.dart';
import 'package:hippo/models/user.dart';
import 'package:hippo/view_models/member/member_controller.dart';

/// createdby Daewu Bintara
/// Saturday, 1/30/21

class AddReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddReviewController());
  }
}

class AddReviewController extends BaseController {
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    //  MyTranslations.init();

    // setScreenState = screenStateOk;
    // update();
  }

  void addReview(String rating, String comment) async {
    showLoadingDialog();
    var map = new Map<String, dynamic>();

    map = Get.parameters;
    map["rating"] = rating;
    map["review_text"] = comment;

    var res = await addMyReview(map);

    hideDialog();
    String text = '';

    if (res.isError!) text = XR().string.error_message;

    if (res.status == true) {
      try {
        text = res.messages!;

        Get.until(
                (route) => (route.settings.name == RouterName.dashboard));

        //Get.back(result: true);
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
