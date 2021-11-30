import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/all_dropdown_values.dart';
import 'package:hippo/models/service_provider_business.dart';

/// createdby Daewu Bintara
/// Saturday, 1/30/21

class EntertainmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EntertainmentController());
  }
}

class EntertainmentController extends BaseController {
  List<ServiceProviderBusiness> dataList = [];
  List<ServiceProviderBusiness> originalList = [];
  List<DropdownValues>? cities;
  String title = "";
  int? selectedCityId;

  searchData(String query) {
    if (query.isNotEmpty) {
      List<ServiceProviderBusiness> tempList = [];

      originalList.forEach((element) {
        var list = element.serviceProviders!
            .where((element) =>
                element.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();
        if (list.length > 0) {
          element.serviceProviders = list;
          tempList.add(element);
        }
      });
      print(tempList.length);
      dataList = tempList;
    } else {
      dataList = originalList;
    }

    refresh();
  }

  @override
  void onInit() async {
    super.onInit();
    setScreenState = screenStateLoading;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    var id = Get.arguments;
    title = id[1];
    await getProviderList(id[0]);
  }

  Future getProviderList(String id) async {
    var res = await getBusinessProviders(id);

    String text = '';

    if (res.isError!) text = XR().string.error_message;

    if (res.status == true) {
      try {
        dataList.clear();
        originalList.clear();
        res.body['result'].forEach((v) {
          var data = ServiceProviderBusiness.fromJson(v);

          if (data.serviceProviders != null &&
              data.serviceProviders!.isNotEmpty) {
            dataList.add(ServiceProviderBusiness.fromJson(v));
            originalList.add(ServiceProviderBusiness.fromJson(v));
          }
        });
        cities = [];
        if (res.body["cities"] != null) {
          res.body["cities"].forEach((v) {
            cities?.add(DropdownValues.fromJson(v));
          });
        }
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

  // searchCityWise(int? id) {
  //   if (id != null) {
  //     dataList =
  //         originalList.where((element) => element.cityId == id).toList();
  //   } else {
  //     dataList = originalList;
  //   }
  //
  //   refresh();
  // }

  searchCityWise(int? id) {
    if (id != null && selectedCityId != id) {
      selectedCityId = id;
      List<ServiceProviderBusiness> tempList = [];

      originalList.forEach((element) {
        var list = element.serviceProviders!
            .where((element) => element.cityId == id)
            .toList();

        if (list.length > 0) {
          var data = ServiceProviderBusiness(
            id: element.id,
            subCategoryName: element.subCategoryName,
            serviceProviders: list,
          );
          tempList.add(data);
        }
      });
      print(tempList.length);
      dataList = tempList;
    } else {
      selectedCityId=null;
      dataList = originalList;
    }
    refresh();
  }
}
