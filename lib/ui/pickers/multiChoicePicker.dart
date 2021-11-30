import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hippo/models/all_dropdown_values.dart';
import 'package:hippo/utils/constants.dart';
import 'package:hippo/models/picker_result.dart';

class MultiChoicePicker extends StatefulWidget {
  final String? title;
  final String? subTitle;
  List<DropdownValues>? data;
  PickerResult? previousData;
  bool showComment = true;
  String? commentTitle = "";

  MultiChoicePicker(
      {Key? key,
      @required this.title,
      this.subTitle,
      this.data,
      this.previousData,
        this.commentTitle = "",
        this.showComment = true})
      : super(key: key);

  @override
  _MultiChoicePickerState createState() => _MultiChoicePickerState();
}

List<DropdownValues> selectedList = [];

class _MultiChoicePickerState extends State<MultiChoicePicker> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> createList(List<DropdownValues>? data) {
      List<Widget> mList = []; //you can't add equal
      for (int b = 0; b < data!.length; b++) {
        DropdownValues dataValue = data[b];

        mList.add(Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  FlutterSwitch(
                    width: 51.w,
                    height: 34.h,
                    toggleSize: 34.r,
                    value: selectedList.contains(dataValue),
                    borderRadius: 30.r,
                    padding: 1.r,
                    toggleColor: Colors.white,
                    switchBorder: Border.all(
                      color: Color(0xFFCCCFCC),
                      width: 0,
                    ),
                    toggleBorder: Border.all(
                      color: Color(0xFFCCCFCC),
                      width: 2.r,
                    ),
                    activeColor: Color(0xff91DFFE),
                    inactiveColor: Color(0xffE5E5E5),
                    onToggle: (value) {
                      setState(() {
                        if (value) {
                          selectedList.add(dataValue);
                        } else {
                          selectedList.remove(dataValue);
                        }
                      });
                    },
                  ),
                  SizedBox(
                    width: 13.w,
                  ),
                  Text(
                    dataValue.name!,
                    style: TextStyle(
                      fontFamily: Constants.FONT_ARIEN,
                      fontSize: 18.sp,
                      color: const Color(0xff707070),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ));

        //   mList.add(CheckboxListTile(
        //     onChanged: (bool? value) {
        //       setState(() {
        //         if (value!) {
        //           selectedList.add(cmap.id!);
        //         } else {
        //           selectedList.remove(cmap.id!);
        //         }
        //       });
        //     },
        //     value: selectedList.contains(cmap.id!),
        //     title: new Text(cmap.name!),
        //   ));
      }

      return mList;
    }

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
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10.w),
                          width: 30.w,
                          height: 30.h,
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/images/chevron.svg',
                              width: 12.w,
                              height: 20.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        widget.title!,
                        style: TextStyle(
                          fontFamily: Constants.FONT_ARIEN,
                          fontSize: 24.sp,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 28.h,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.showComment ? Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: TextField(
                            controller: myController,
                            style: TextStyle(
                              fontFamily: Constants.FONT_ARIEN,
                              fontSize: 18.sp,
                            ),
                            decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: widget.commentTitle,
                                hintStyle: TextStyle(
                                  fontFamily: Constants.FONT_ARIEN,
                                  fontSize: 18.sp,
                                  color: const Color(0x77707070),
                                )),
                          ),
                          height: 55.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: const Color(0xffffffff),
                            border: Border.all(
                                width: 1.w, color: const Color(0x48707070)),
                          ),
                        ):Container(),
                        SizedBox(
                          height: widget.showComment ?40.h:0,
                        ),
                        widget.showComment == true?Text(
                          widget.subTitle!,
                          style: TextStyle(
                            fontFamily: Constants.FONT_ARIEN,
                            fontSize: 22.sp,
                            color: const Color(0xff0c6bc2),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ):Container(),
                        SizedBox(
                          height: 15.h,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: createList(widget.data),
                        ),
                        // ListView.separated(
                        //   physics: ScrollPhysics(),
                        //   shrinkWrap: true,
                        //   itemCount: widget.data!.length,
                        //   itemBuilder: (BuildContext context, int index) {
                        //     var data = widget.data![index];
                        //
                        //     return Container(
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Row(
                        //             children: [
                        //               FlutterSwitch(
                        //                 width: 51.w,
                        //                 height: 34.h,
                        //                 toggleSize: 34.r,
                        //                 value: false,
                        //                 borderRadius: 30.r,
                        //                 padding: 1.r,
                        //                 toggleColor: Colors.white,
                        //                 switchBorder: Border.all(
                        //                   color: Color(0xFFCCCFCC),
                        //                   width: 0,
                        //                 ),
                        //                 toggleBorder: Border.all(
                        //                   color: Color(0xFFCCCFCC),
                        //                   width: 2.r,
                        //                 ),
                        //                 activeColor: Color(0xff91DFFE),
                        //                 inactiveColor: Color(0xffE5E5E5),
                        //                 onToggle: (val) {
                        //                   setState(() {
                        //                     // status2 = val;
                        //                   });
                        //                 },
                        //               ),
                        //               SizedBox(
                        //                 width: 13.w,
                        //               ),
                        //               Text(
                        //                 data.name!,
                        //                 style: TextStyle(
                        //                   fontFamily: Constants.FONT_ARIEN,
                        //                   fontSize: 18.sp,
                        //                   color: const Color(0xff707070),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //     );
                        //   },
                        //   separatorBuilder: (BuildContext context, int index) =>
                        //       SizedBox(
                        //     height: 10.h,
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            )),
            InkWell(
              onTap: () {
                Navigator.pop(
                    context,
                    PickerResult(
                        title: myController.text, selectedList: selectedList));
              },
              child: Container(
                child: Center(
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontFamily: Constants.FONT_ARIEN,
                      fontSize: 22.sp,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                margin: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
                height: 67.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: const Color(0xff0c6bc2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 60.r,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
