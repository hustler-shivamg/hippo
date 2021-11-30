import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/all_dropdown_values.dart';
import 'package:hippo/models/filter_data.dart';
import 'package:hippo/models/service_provider.dart';

/// createdby Daewu Bintara
/// Saturday, 1/30/21

class PediaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PediaController());
  }
}

class PediaController extends BaseController {
  List<ServiceProvider> dataList = [];
  List<ServiceProvider> originalList = [];
  FilterData? filterData;
  List<DropdownValues>? educations;
  List<DropdownValues>? workExperiences;
  List<DropdownValues>? age;
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
  @override
  void onInit() async {
    super.onInit();
    setScreenState = screenStateLoading;
    if (filterData == null) {
      filterData = FilterData.initialize();
    }
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    var id = Get.arguments;

     await getProviderList(id[0]);
  }

  Future getProviderList(String id) async {

    var map = new Map<String, dynamic>();

    map["category_id"] = id;

    var res = await getProviders(map);


    String text = '';

    if (res.isError!) text = XR().string.error_message;

    if (res.status == true) {
      try {
        dataList.clear();
        originalList.clear();
        res.body['result'].forEach((v) {
          originalList.add(ServiceProvider.fromJson(v));
          dataList.add(ServiceProvider.fromJson(v));
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
