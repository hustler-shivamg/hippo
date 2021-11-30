import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/service_provider.dart';

/// createdby Daewu Bintara
/// Saturday, 1/30/21

class MyReviewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyReviewsController());
  }
}

class MyReviewsController extends BaseController {
  List<Reviews> dataList = [];

  @override
  void onInit() async {
    super.onInit();
    setScreenState = screenStateLoading;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    // var id = Get.arguments;

    await getProviderList();
  }

  Future getProviderList() async {
    // var map = new Map<String, dynamic>();
    //
    // map["category_id"] = id;

    var res = await getMyReviews();

    String text = '';

    if (res.isError!) text = XR().string.error_message;

    if (res.status == true) {
      try {
        dataList.clear();
        res.body['result'].forEach((v) {
          dataList.add(Reviews.fromJson(v));
        });
      } catch (e, s) {
        print(s);
        text = "Something went wrong, try again later...";
        showSimpleErrorSnackBar(message: text);
      }
    } else {
      text = res.text!;
      showSimpleErrorSnackBar(message: text);
    }
    setScreenState = screenStateOk;
    refresh();
    //showSnackBar(title: "Response", message: text);
  }

  void deletereview(String reviewid, int index) async {
    Get.dialog(
        Material(
            color: Colors.black.withOpacity(0.1),
            child: AlertDialog(
              title: Text("Delete".tr),
              content: Text("Are you sure want to delete the review ?".tr),
              actions: [
                TextButton(
                  child: Text("YES".tr),
                  onPressed: () async {
                    var map = new Map<String, dynamic>();
                    map["review_id"] = reviewid;
                    var res = await deleteReview(map);
                    hideDialog();
                    String text = '';

                    if (res.isError!) text = XR().string.error_message;

                    if (res.status == true) {
                      try {
                        // var user = User.fromJson(res.body['result']);
                        // box.write(MyConfig.USER_DATA, user.toJson());
                        // box.write(MyConfig.IS_LOGGED_IN, true);
                        // text = res.messages!;
                        //
                        // box.write(MyConfig.TOKEN_STRING_KEY, user.apiToken);
                        //
                        // Get.offAllNamed(RouterName.dashboard);
                        // text = res.messages!;
                        showSimpleSuccessSnackBar(message: "Reivew deleted");
                        dataList.removeAt(index);
                        update();
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
                  },
                ),
                TextButton(
                  child: Text("NO".tr),
                  onPressed: () {
                    hideDialog();
                  },
                )
              ],
            )),
        barrierDismissible: false,
        name: "Confirmation Dialog");
  }
}
