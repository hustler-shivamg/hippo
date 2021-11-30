import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';

/// createdby Daewu Bintara
/// Saturday, 1/30/21

class EditReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditReviewController());
  }
}

class EditReviewController extends BaseController {
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  var rating = 0;

  @override
  void onInit() async {
    super.onInit();
    var map = new Map<String, dynamic>();
    map = Get.parameters;
    commentController.text = map["review"];
    rating = int.parse(map["rating"]);

    //  MyTranslations.init();

    // setScreenState = screenStateOk;
    // update();
  }

  void addReview(String rating, String comment) async {
    showLoadingDialog();
    var map = new Map<String, dynamic>();

    map = Get.parameters;
    map["review_id"] = map["review_id"];
    map["rating"] = rating;
    map["review"] = comment;

    var res = await editMyReview(map);

    hideDialog();
    String text = '';

    if (res.isError!) text = XR().string.error_message;

    if (res.status == true) {
      try {
        text = res.messages!;

        // Get.until((route) => (route.settings.name == RouterName.dashboard));
        Get.back(result: true);
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
