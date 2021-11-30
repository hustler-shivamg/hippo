import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/service_provider.dart';

/// createdby Daewu Bintara
/// Saturday, 1/30/21

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
  }
}

class SearchController extends BaseController {
  TextEditingController searchTxtController = TextEditingController();
  List<ServiceProvider> dataList = [];
  bool isSearched = false;

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

  Future searchData() async {
    showLoadingDialog();
    var map = new Map<String, dynamic>();

    map["search_text"] = searchTxtController.text.trim();

    var res = await getProviders(map);

    hideDialog();
    String text = '';

    if (res.isError!) text = XR().string.error_message;

    if (res.status == true) {
      isSearched = true;
      try {
        dataList.clear();
        res.body['result'].forEach((v) {
          dataList.add(ServiceProvider.fromJson(v));
        });
        print(dataList.length);
        refresh();
      } catch (e) {
        e.printError();
        text = "Something went wrong, try again later...";
        showSimpleErrorSnackBar(message: text);
      }
    } else {
      // isSearched = false;
      text = res.messages!;
      showSimpleErrorSnackBar(message: text);
    }

  }
}
