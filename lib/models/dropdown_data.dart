class DropdownData {
  int? id;
  String? name;

  DropdownData({this.id, this.name});

  DropdownData.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"] ?? json["category_name"] ?? "";
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    return map;
  }
}
