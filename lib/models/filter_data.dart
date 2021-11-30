import 'package:hippo/models/all_dropdown_values.dart';

class FilterData {
  DropdownValues? age;
  int? gender;
  DropdownValues? selectedEducation;
  DropdownValues? selectedWorkExperiences;
  int? haveCar;
  bool? isReset = false;

  FilterData(
      {this.age,
      this.gender,
      this.selectedEducation,
      this.selectedWorkExperiences,
      this.haveCar});

  FilterData.initialize() {
    gender = 1;
    haveCar = 0;
    selectedEducation = DropdownValues.all();
    age = DropdownValues.all();
    selectedWorkExperiences = DropdownValues.all();
  }
}
