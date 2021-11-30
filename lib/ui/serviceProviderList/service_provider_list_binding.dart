import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/all_dropdown_values.dart';
import 'package:hippo/models/service_provider.dart';
import 'package:hippo/models/service_provider_business.dart';

/// createdby Daewu Bintara
/// Saturday, 1/30/21

class ServiceProviderListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServiceProviderListController());
  }
}

class ServiceProviderListController extends BaseController {
  List<ServiceProvider> dataList = [];
  List<ServiceProvider> originalList = [];
  List<DropdownValues>? cities = [];

  String? title = "";
  int? selectedCityId;

  @override
  void onInit() async {
    super.onInit();
    // setScreenState = screenStateLoading;
  }

  searchData(String query) {
    if (query.isNotEmpty) {
      dataList = originalList
          .where((element) =>
              element.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      dataList = originalList;
    }

    refresh();
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    await getProviderList();
  }

  Future getProviderList() async {
    dataList.clear();
    originalList.clear();
    var arguments = Get.arguments;
    title = arguments[1];
    dataList.addAll(arguments[0]);
    originalList.addAll(arguments[0]);
    if (arguments[2] != null) {
      cities?.addAll(arguments[2]);
    }
    refresh();
  }




  searchCityWise(int? id) {
    if (id != null && selectedCityId != id) {
      selectedCityId=id;
      dataList =
          originalList.where((element) => element.cityId == id).toList();
    } else {
      selectedCityId = null;
      dataList = originalList;
    }

    refresh();
  }
}
