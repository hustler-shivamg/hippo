import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/all_dropdown_values.dart';
import 'package:hippo/models/category.dart';
import 'package:hippo/models/filter_data.dart';
import 'package:hippo/models/member.dart';
import 'package:hippo/models/service_provider.dart';
import 'package:hippo/view_models/member/member_controller.dart';

/// createdby Daewu Bintara
/// Saturday, 1/30/21

class CaregiverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CaregiverController());
  }
}

class CaregiverController extends BaseController {
  List<ServiceProvider> dataList = [];
  List<ServiceProvider> originalList = [];
  List<DropdownValues>? educations;
  List<DropdownValues>? workExperiences;
  List<DropdownValues>? cities;
  List<DropdownValues>? age;
  FilterData? filterData;
  String title = "";
  int? selectedCityId;

  ScrollPhysics _physics = ClampingScrollPhysics();

  @override
  void onInit() async {
    super.onInit();
    setScreenState = screenStateLoading;
    if (filterData == null) {
      filterData = FilterData.initialize();
    }

    // MyTranslations.init();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    var id = Get.arguments;
    title = id[1] ?? "";
    await getProviderList(id[0]);
  }

  searchData(String query) {
    if (query.isNotEmpty) {
      dataList = originalList
          .where((element) =>
              element.firstName!.toLowerCase().contains(query.toLowerCase()) ||
              element.lastName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      dataList = originalList;
    }

    refresh();
  }

  searchCityWise(int? id) {
    if (id != null && selectedCityId != id) {
      selectedCityId=id;
      dataList.clear();
      dataList.addAll(originalList.where((element) => element.cityId == id).toList());
    } else {
      selectedCityId=null;
      dataList.clear();
      dataList.addAll(originalList);
    }

    refresh();
  }

  Future getProviderList(String id) async {
    //showLoadingDialog();
    var map = new Map<String, dynamic>();

    map["category_id"] = id;

    var res = await getProviders(map);

    //hideDialog();
    String text = '';

    if (res.isError!) text = XR().string.error_message;

    if (res.status == true) {
      try {
        dataList.clear();
        originalList.clear();
        res.body['result'].forEach((v) {
          dataList.add(ServiceProvider.fromJson(v));
          originalList.add(ServiceProvider.fromJson(v));
        });
        educations = [];
        educations?.add(DropdownValues.all());
        if (res.body['educations'] != null) {
          res.body["educations"].forEach((v) {
            educations?.add(DropdownValues.fromJson(v));
          });
        }
        workExperiences = [];
        workExperiences?.add(DropdownValues.all());

        if (res.body["work_experiences"] != null) {
          res.body["work_experiences"].forEach((v) {
            workExperiences?.add(DropdownValues.fromJson(v));
          });
        }
        cities = [];
        if (res.body["cities"] != null) {
          res.body["cities"].forEach((v) {
            cities?.add(DropdownValues.fromJson(v));
          });
        }

        age = [];
        age?.add(DropdownValues.all());
      } catch (e) {
        print(e);

        text = XR().string.error_message;
      }
    } else {
      text = res.text!;
    }
    setScreenState = screenStateOk;
    refresh();
    //showSnackBar(title: "Response", message: text);
  }

  void applyFilter(FilterData filterData) {
    this.filterData = filterData;
    dataList = originalList.where((element) {
      return (filterData.selectedEducation?.id == -1 ||
              element.educationId?.contains(
                      (filterData.selectedEducation?.id ?? "").toString()) ==
                  true) &&
          (filterData.selectedWorkExperiences?.id == -1 ||
              element.workExperienceId?.contains(
                      (filterData.selectedWorkExperiences?.id ?? "")
                          .toString()) ==
                  true) &&
          element.haveCar == filterData.haveCar &&
          element.gender == filterData.gender;
    }).toList();

    refresh();
  }

  void resetList() {
    dataList = originalList;
    filterData = FilterData.initialize();
    refresh();
  }
}
