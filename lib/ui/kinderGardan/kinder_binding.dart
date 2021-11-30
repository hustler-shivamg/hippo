import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/service_provider.dart';

/// createdby Daewu Bintara
/// Saturday, 1/30/21

class KinderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => KinderController());
  }
}

class KinderController extends BaseController {
  List<ServiceProvider> dataList = [];
  List<ServiceProvider> originalList = [];

  @override
  void onInit() async {
    super.onInit();
    setScreenState = screenStateLoading;
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
          print(v.toString());
          dataList.add(ServiceProvider.fromJson(v));
          originalList.add(ServiceProvider.fromJson(v));
        });
      } catch (e) {
        print(e);
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
}
