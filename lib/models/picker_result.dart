/// createdby Daewu Bintara
/// Friday, 1/22/21

import 'dart:convert';

import 'package:hippo/models/all_dropdown_values.dart';

class PickerResult {
  PickerResult({
    this.title,
    this.selectedList,
  });

  String? title;
  List<DropdownValues>? selectedList = [];

  @override
  String toString() {
    return title ?? "";
  }
}
