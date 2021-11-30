import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/service_provider.dart';

/// createdby Daewu Bintara
/// Saturday, 1/30/21

class ProviderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProviderDetailController());
  }
}

class ProviderDetailController extends BaseController {
  TextEditingController otpController = TextEditingController();
  ServiceProvider? providerData = null;
  bool isFav = false;
  var map = new Map<String, dynamic>();
  double lat=0.0,lon=0.0,diffKM = 0.0,diffMeter = 0.0;
  String dropdownvalue = "";

  String value1= '';


  var _controller = ScrollController();
  ScrollPhysics physics = ClampingScrollPhysics();

  List<Hour>? hourList;

  int? selected;

  void setSelected(String value){
    print("value "+value);
    selected = int.parse(value);
  }

  @override
  void onInit() async {
    super.onInit();

    // MyTranslations parameters = Get.parameters;

    map = Get.parameters;
    getDetails();

    _controller.addListener(() {
      if (_controller.position.pixels <= 56){
        physics = ClampingScrollPhysics();
        refresh();
      }
        // setState(() => _physics = ClampingScrollPhysics());
      else {
        physics = BouncingScrollPhysics();
        refresh();
      }
        // setState(() => _physics = BouncingScrollPhysics());
    });

  }

  // Future<void> sel()async{
  //   await
  // }

  Future<void> getLocationFromStorage() async {
    // currentPosition = Position(longitude: longitude, latitude: latitude);
    lat = box.read(MyConfig.USER_LOCATION_LATITUDE);
    lon = box.read(MyConfig.USER_LOCATION_LONGITUDE);
    diffMeter = Geolocator.distanceBetween(lat, lon, double.parse(providerData?.latitude ?? "0.0"), double.parse(providerData?.longitude ?? "0.0"));
    print("diffMeter"+diffMeter.toString());
    diffKM = diffMeter/1000;
    refresh();
  }

  // dropDownHour(){
  //   return DropdownButton(
  //     value: dropdownvalue,
  //     icon: Icon(Icons.keyboard_arrow_down),
  //     items: providerData!.hours!.map((String items) {
  //       return DropdownMenuItem(
  //           value: items,
  //           child: Text(items)
  //       );
  //     }
  //     ).toList(),
  //     onChanged: (String? newValue){
  //         dropdownvalue = newValue!;
  //         refresh();
  //     },
  //   );
  // }

  Future getDetails() async {
    //showLoadingDialog();
    setScreenState = screenStateLoading;
    refresh();
    // map["id"] = id;
    // map["type"] = type;

    var res = await getProviderDetails(map);

    //hideDialog();
    String text = '';

    if (res.isError!) text = XR().string.error_message;

    if (res.status == true) {
      try {
        providerData = ServiceProvider.fromJson(res.body['result']);
        text = res.messages!;
        isFav = providerData?.isFavourite ?? false;
        setScreenState = screenStateOk;
        getLocationFromStorage();
      //  setSelected(text);

        hourList=providerData?.hours;
        // selected.value = providerData.hours.first.dayName!;

        print('hourList ${providerData?.hours}');
      } catch (e, stacktrace) {
        print(stacktrace);
        e.printError();
        text = "Something went wrong, try again later...";
        showSnackBar(title: "Login", message: text);
        setScreenState = screenStateError;
      }
    } else {
      text = res.messages!;
      showSimpleErrorSnackBar(message: text);
      setScreenState = screenStateError;
    }

    refresh();
    //
  }

  bool isLoggedIn() {
    var isLoggedIn = box.read(MyConfig.IS_LOGGED_IN);
    if (isLoggedIn == null) {
      isLoggedIn = false;
    }
    return isLoggedIn;
  }

  void addToFavList(Map<String, dynamic> map) async {
    showLoadingDialog();

    var res = await addToFav(map);

    hideDialog();
    String text = '';

    if (res.isError!) text = XR().string.error_message;

    if (res.status == true) {
      try {
        text = res.messages!;
        showSimpleSuccessSnackBar(message: text);
        isFav = !isFav;
        refresh();
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
