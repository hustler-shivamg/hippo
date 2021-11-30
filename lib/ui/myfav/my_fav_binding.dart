import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/new_listing_data.dart';
import 'package:hippo/models/service_provider.dart';

/// createdby Daewu Bintara
/// Saturday, 1/30/21

class MyFavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyFavController());
  }
}

class MyFavController extends BaseController {

  List<NewListingData> newList = [];

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
    //F
    // map["category_id"] = id;

    var res = await getFav();


    String text = '';

    if (res.isError!) text = XR().string.error_message;

    if (res.status == true) {
      try {

        newList.clear();
        res.body['result'].forEach((v) {
          newList.add(NewListingData.fromJson(v));
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
