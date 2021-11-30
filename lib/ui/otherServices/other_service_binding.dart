import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/service_provider_business.dart';

/// createdby Daewu Bintara
/// Saturday, 1/30/21

class OtherServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtherServicesController());
  }
}

class OtherServicesController extends BaseController {
  List<ServiceProviderBusiness> dataList = [];
  List<ServiceProviderBusiness> originalList = [];

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
}
