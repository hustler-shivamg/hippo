import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hippo/models/all_dropdown_values.dart';
import 'package:hippo/models/filter_data.dart';
import 'package:hippo/utils/constants.dart';
import 'package:get/get.dart';
import 'package:hippo/x_utils/widgets/app_dropdown_input.dart';

class FilterScreen extends StatefulWidget {
  List<DropdownValues>? educations;
  List<DropdownValues>? workExperiences;
  List<DropdownValues>? age;

  FilterData? filterData;

  FilterScreen({
    Key? key,
    this.educations,
    this.workExperiences,
    this.age,
    this.filterData,
  }) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<bool> _mGenderSelection = [false, true];
  List<bool> _mHaveCarSelection = [true, false];

  @override
  Widget build(BuildContext context) {
    if (widget.filterData == null) {
      widget.filterData = FilterData.initialize();
    }
    if (widget.educations == null) {
      widget.educations = [];
    }
    if (widget.workExperiences == null) {
      widget.workExperiences = [];
    }
    if (widget.age == null) {
      widget.age = [];
    }

    _mHaveCarSelection = [
      widget.filterData?.haveCar == 1,
      widget.filterData?.haveCar != 1
    ];

    _mGenderSelection = [
      widget.filterData?.gender == 1,
      widget.filterData?.gender != 1
    ];

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 49.h,
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/images/ic_filter.svg',
                    width: 56.34.w,
                    height: 86.h,
                    fit: BoxFit.contain,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: Container(
                      margin: EdgeInsets.only(right: 10.w),
                      width: 37.w,
                      height: 37.h,
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/close_icon.svg',
                          width: 37.w,
                          height: 37.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 28.5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 19.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 57.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Age".tr,
                          style: TextStyle(
                            fontFamily: Constants.FONT_ARIEN,
                            fontSize: 17.sp,
                            color: const Color(0xff707070),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<DropdownValues>(
                                value: widget.filterData?.age,
                                selectedItemBuilder: (BuildContext context) {
                                  return widget.age!
                                      .map<Widget>((DropdownValues data) {
                                    // return DropdownMenuItem(
                                    //   child: new Align(alignment: Alignment.centerRight, child: Text(  data.name ?? "")),
                                    //   value: data,);

                                    return Container(
                                      width: 100,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          data.name ?? "",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            height: 1,
                                            fontFamily: Constants.FONT_ARIEN,
                                            fontSize: 17.sp,
                                            color: const Color(0xFFB9B9B9),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList();
                                },
                                items: widget.age!.map((DropdownValues value) {
                                  return DropdownMenuItem<DropdownValues>(
                                    value: value,
                                    child: Text(
                                      value.name!,
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 17.sp,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  widget.filterData?.age = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffe2e2e2),
                    ),
                  ),
                  SizedBox(
                    height: 57.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Gender'.tr,
                          style: TextStyle(
                            fontFamily: Constants.FONT_ARIEN,
                            fontSize: 17.sp,
                            color: const Color(0xff707070),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: ToggleButtons(
                              onPressed: (int index) {
                                setState(() {
                                  _mGenderSelection[0] = false;
                                  _mGenderSelection[1] = false;
                                  _mGenderSelection[index] =
                                      !_mGenderSelection[index];

                                  widget.filterData?.gender =
                                      _mGenderSelection[0] == true ? 1 : 0;
                                });
                              },
                              constraints: BoxConstraints(maxHeight: 36.h),
                              isSelected: _mGenderSelection,
                              selectedColor: Colors.white,
                              fillColor: const Color(0xff92E0FF),
                              children: [
                                Container(
                                  color: _mGenderSelection[1] == true
                                      ? const Color(0xffF0F0F0)
                                      : null,
                                  child: Center(
                                    child: Text(
                                      'Male'.tr,
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 14.sp,
                                        color: _mGenderSelection[0] == true
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  width: 112.w,
                                  height: 31.h,
                                ),
                                Container(
                                  color: _mGenderSelection[0] == true
                                      ? const Color(0xffF0F0F0)
                                      : null,
                                  child: Center(
                                    child: Text(
                                      'Female'.tr,
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 14.sp,
                                        color: _mGenderSelection[1] == true
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  width: 112.w,
                                  height: 32.h,
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.r)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffe2e2e2),
                    ),
                  ),
                  SizedBox(
                    height: 57.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Education'.tr,
                          style: TextStyle(
                            fontFamily: Constants.FONT_ARIEN,
                            fontSize: 17.sp,
                            color: const Color(0xff707070),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<DropdownValues>(
                                value: widget.filterData?.selectedEducation,
                                selectedItemBuilder: (BuildContext context) {
                                  return widget.educations!
                                      .map<Widget>((DropdownValues data) {
                                    // return DropdownMenuItem(
                                    //   child: new Align(alignment: Alignment.centerRight, child: Text(  data.name ?? "")),
                                    //   value: data,);

                                    return Container(
                                      width: 100,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          data.name ?? "",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            height: 1,
                                            fontFamily: Constants.FONT_ARIEN,
                                            fontSize: 17.sp,
                                            color: const Color(0xFFB9B9B9),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList();
                                },
                                items: widget.educations!
                                    .map((DropdownValues value) {
                                  return DropdownMenuItem<DropdownValues>(
                                    value: value,
                                    child: Text(
                                      value.name!,
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 17.sp,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  widget.filterData?.selectedEducation = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffe2e2e2),
                    ),
                  ),
                  SizedBox(
                    height: 57.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'WorkExperience'.tr,
                          style: TextStyle(
                            fontFamily: Constants.FONT_ARIEN,
                            fontSize: 17.sp,
                            color: const Color(0xff707070),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<DropdownValues>(
                                value:
                                    widget.filterData?.selectedWorkExperiences,
                                selectedItemBuilder: (BuildContext context) {
                                  return widget.workExperiences!
                                      .map<Widget>((DropdownValues data) {
                                    // return DropdownMenuItem(
                                    //   child: new Align(alignment: Alignment.centerRight, child: Text(  data.name ?? "")),
                                    //   value: data,);

                                    return Container(
                                      width: 100,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          data.name ?? "",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            height: 1,
                                            fontFamily: Constants.FONT_ARIEN,
                                            fontSize: 17.sp,
                                            color: const Color(0xFFB9B9B9),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList();
                                },
                                items: widget.workExperiences!
                                    .map((DropdownValues value) {
                                  return DropdownMenuItem<DropdownValues>(
                                    value: value,
                                    child: Text(
                                      value.name!,
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 17.sp,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  widget.filterData?.selectedWorkExperiences =
                                      value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffe2e2e2),
                    ),
                  ),
                  SizedBox(
                    height: 57.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Car'.tr,
                          style: TextStyle(
                            fontFamily: Constants.FONT_ARIEN,
                            fontSize: 17.sp,
                            color: const Color(0xff707070),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: ToggleButtons(
                              onPressed: (int index) {
                                _mHaveCarSelection[0] = false;
                                _mHaveCarSelection[1] = false;
                                _mHaveCarSelection[index] =
                                    !_mHaveCarSelection[index];
                                widget.filterData?.haveCar =
                                    _mHaveCarSelection[0] == true ? 1 : 0;
                                setState(() {});
                              },
                              constraints: BoxConstraints(maxHeight: 36.h),
                              isSelected: _mHaveCarSelection,
                              selectedColor: Colors.white,
                              fillColor: const Color(0xff92E0FF),
                              children: [
                                Container(
                                  color: _mHaveCarSelection[1] == true
                                      ? const Color(0xffF0F0F0)
                                      : null,
                                  child: Center(
                                    child: Text(
                                      'Yes'.tr,
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 14.sp,
                                        color: _mHaveCarSelection[0] == true
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  width: 112.w,
                                  height: 31.h,
                                ),
                                Container(
                                  color: _mHaveCarSelection[0] == true
                                      ? const Color(0xffF0F0F0)
                                      : null,
                                  child: Center(
                                    child: Text(
                                      'No'.tr,
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 14.sp,
                                        color: _mHaveCarSelection[1] == true
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  width: 112.w,
                                  height: 32.h,
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.r)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffe2e2e2),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 30.h, horizontal: 18.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              widget.filterData?.isReset = false;
                              Navigator.pop(context, widget.filterData);
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  'Apply'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 22.sp,
                                    color: const Color(0xffffffff),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              height: 67.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0.r),
                                color: const Color(0xff0c6bc2),
                                border: Border.all(
                                    width: 1.0, color: const Color(0xffffffff)),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x29000000),
                                    offset: Offset(0, 3),
                                    blurRadius: 60,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              widget.filterData?.isReset = true;
                              Navigator.pop(context, widget.filterData);
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  'Reset'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 22.sp,
                                    color: const Color(0xffffffff),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              height: 67.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0.r),
                                color: const Color(0xff0c6bc2),
                                border: Border.all(
                                    width: 1.0, color: const Color(0xffffffff)),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x29000000),
                                    offset: Offset(0, 3),
                                    blurRadius: 60,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
