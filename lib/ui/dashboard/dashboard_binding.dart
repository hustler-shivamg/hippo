import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/category.dart';
import 'package:hippo/models/member.dart';
import 'package:hippo/models/new_listing_data.dart';
import 'package:hippo/models/service_provider.dart';
import 'package:hippo/view_models/member/member_controller.dart';
import 'package:hippo/x_res/dummy.dart';

/// createdby Daewu Bintara
/// Saturday, 1/30/21

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
  }
}

class DashboardController extends BaseController {
  List<Category> category = [];
  List<NewListingData> newList = [];
  List<ServiceProvider>? serviceProviders = [];
  List<ServiceProvider>? caregivers = [];
  List<ServiceProvider>? kindergardens = [];
  Position? currentPosition;

  bool isLoggedIn() {
    var isLoggedIn = box.read(MyConfig.IS_LOGGED_IN);
    if (isLoggedIn == null) {
      isLoggedIn = false;
    }
    return isLoggedIn;
  }

  @override
  void onInit() async {
    super.onInit();
    setScreenState = screenStateLoading;
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: false)
        .then((Position position) {
      print("Position" + position.toString());
      currentPosition = position;
      if (currentPosition?.latitude != null) {
        box.write(MyConfig.USER_LOCATION_LATITUDE, currentPosition!.latitude);
      }
      if (currentPosition?.longitude != null) {
        box.write(MyConfig.USER_LOCATION_LONGITUDE, currentPosition!.longitude);
      }
      print("location stored");
      refresh();
    }).catchError((e, s) {
      print(s);
      print(e);
    });
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    MyTranslations.init();
    await getCategoriesList();
  }

  Future getCategoriesList() async {
    //showLoadingDialog();

    var res = await getCategories();

    //hideDialog();
    String text = '';

    if (res.isError!) text = XR().string.error_message;

    if (res.status == true) {
      try {
        category.clear();
        res.body['result'].forEach((v) {
          category.add(Category.fromJson(v));
        });

        newList.clear();
        res.body['latest_data'].forEach((v) {
          newList.add(NewListingData.fromJson(v));
        });

        // String data = Uri.decodeFull(Dummy.CAREGIVERS_JSON);
        // final jsonResult = jsonDecode(data); //latest Dart
        // jsonResult.forEach((v) {
        //   serviceProviders?.add(ServiceProvider.fromJson(v));
        // });

        serviceProviders?.clear();
        res.body['entertainment']["data"].forEach((v) {
          serviceProviders?.add(ServiceProvider.fromJson(v));
        });

        print(serviceProviders?.length ?? 0);

        // String data2 = Uri.decodeFull(Dummy.CAREGIVERS_JSON2);
        // final jsonResult2 = jsonDecode(data2); //latest Dart
        // caregivers?.clear();
        // jsonResult2.forEach((v) {
        //   caregivers?.add(ServiceProvider.fromJson(v));
        // });
        caregivers?.clear();
        res.body['caregivers']["data"].forEach((v) {
          caregivers?.add(ServiceProvider.fromJson(v));
        });

        kindergardens?.clear();
        res.body['kindergardens']["data"].forEach((v) {
          kindergardens?.add(ServiceProvider.fromJson(v));
        });

        print(caregivers?.length ?? 0);
      } catch (e) {
        print(e);

        text = XR().string.error_message;
      }
    } else {
      text = res.text!;
    }
    setScreenState = screenStateOk;
    refresh();
    // showSnackBar(title: "Response", message: text);
  }

  void changeLanguage() {
    print("change language");
    String? lang = box.read(MyConfig.LANGUAGE);
    print("currunt language $lang");

    if (lang == null || lang == 'arm') {
      MyTranslations.updateLocale(langCode: 'en');
    } else {
      MyTranslations.updateLocale(langCode: 'arm');
    }
    try {
      DashboardController testController = Get.find();
      testController.onInit();
    } catch (e) {}
  }

  void changeLanguageByCode(String code) {
    // print("change language");
    String? lang = box.read(MyConfig.LANGUAGE);
    // print("currunt language $lang");
    //
    // if (lang == null || lang == 'arm') {
    //
    // } else {
    //   MyTranslations.updateLocale(langCode: 'arm');
    // }

    if (code == lang) {
      return;
    }

    MyTranslations.updateLocale(langCode: code);
    try {
      DashboardController testController = Get.find();
      testController.onInit();
    } catch (e) {}
  }
}
