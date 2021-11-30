import 'package:hippo/models/all_dropdown_values.dart';
import 'package:hippo/models/service_provider.dart';

/// status : true
/// result : [{"id":2,"sub_category_name":"Զբոսայգիներ","service_providers":[{"id":2,"category_id":5,"sub_category_id":2,"first_name":null,"last_name":null,"profile_pic":null,"city":null,"state":null,"postal_code":null,"description":null,"home_phone":"2234567890","cell_phone":"1234567890","facebook_url":null,"instagram_url":null,"twitter_url":null},{"id":3,"category_id":5,"sub_category_id":2,"first_name":null,"last_name":null,"profile_pic":null,"city":null,"state":null,"postal_code":null,"description":null,"home_phone":"2234567890","cell_phone":"1234567890","facebook_url":null,"instagram_url":null,"twitter_url":null}]},{"id":4,"sub_category_name":"Սրճարան երեխաների համար","service_providers":[]}]
class ServiceProviderBusiness {
  int? id;
  String? subCategoryName;
  List<ServiceProvider>? serviceProviders;
  List<DropdownValues>? cities;

  ServiceProviderBusiness(
      {this.id, this.subCategoryName, this.serviceProviders,this.cities});

  ServiceProviderBusiness.fromJson(dynamic json) {
    id = json["id"];
    subCategoryName = json["sub_category_name"];
    if (json["service_providers"] != null) {
      serviceProviders = [];
      json["service_providers"].forEach((v) {
        serviceProviders?.add(ServiceProvider.fromJson(v));
      });
    }

    cities = [];
    if (json["cities"] != null) {
      json["cities"].forEach((v) {
        cities?.add(DropdownValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["sub_category_name"] = subCategoryName;
    if (serviceProviders != null) {
      map["service_providers"] =
          serviceProviders?.map((v) => v.toJson()).toList();
    }
    if (cities != null) {
      map["cities"] =
          cities?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
