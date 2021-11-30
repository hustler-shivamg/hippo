import 'package:hippo/models/service_provider.dart';

/// id : 2
/// category_name : "Childcare"
/// type : "business"
/// is_subcategory : false

class NewListingData {
  int? id;
  String? categoryName;
  String? type;
  bool? isSubcategory;
  List<ServiceProvider>? serviceProviders;

  NewListingData({
      this.id,
      this.categoryName,
      this.type,
      this.isSubcategory, this.serviceProviders});

  NewListingData.fromJson(dynamic json) {
    id = json['id'];
    categoryName = json['category_name'];
    type = json['type'];
    isSubcategory = json['is_subcategory'];
    if (json["data"] != null) {
      serviceProviders = [];
      json["data"].forEach((v) {
        serviceProviders?.add(ServiceProvider.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['category_name'] = categoryName;
    map['type'] = type;
    map['is_subcategory'] = isSubcategory;
    if (serviceProviders != null) {
      map["data"] =
          serviceProviders?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}