import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hippo/utils/constants.dart';

class PickerWorkExperience extends StatefulWidget {
  @override
  _PickerWorkExperienceState createState() => _PickerWorkExperienceState();
}

class _PickerWorkExperienceState extends State<PickerWorkExperience> {
  @override
  Widget build(BuildContext context) {
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
                        'Work Experience',
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
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: TextField(
                            style: TextStyle(
                              fontFamily: Constants.FONT_ARIEN,
                              fontSize: 18.sp,
                            ),
                            decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Experiance",
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
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Text(
                          'I have experience',
                          style: TextStyle(
                            fontFamily: Constants.FONT_ARIEN,
                            fontSize: 22.sp,
                            color: const Color(0xff0c6bc2),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            FlutterSwitch(
                              width: 51.w,
                              height: 34.h,
                              toggleSize: 34.r,
                              value: false,
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
                              onToggle: (val) {
                                setState(() {
                                  // status2 = val;
                                });
                              },
                            ),
                            SizedBox(
                              width: 13.w,
                            ),
                            Text(
                              'Newborns',
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
                        Row(
                          children: [
                            FlutterSwitch(
                              width: 51.w,
                              height: 34.h,
                              toggleSize: 34.r,
                              value: true,
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
                              onToggle: (val) {
                                setState(() {
                                  // status2 = val;
                                });
                              },
                            ),
                            SizedBox(
                              width: 13.w,
                            ),
                            Text(
                              'Toddlers',
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
                        Row(
                          children: [
                            FlutterSwitch(
                              width: 51.w,
                              height: 34.h,
                              toggleSize: 34.r,
                              value: true,
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
                              onToggle: (val) {
                                setState(() {
                                  // status2 = val;
                                });
                              },
                            ),
                            SizedBox(
                              width: 13.w,
                            ),
                            Text(
                              'School Age',
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
                        Row(
                          children: [
                            FlutterSwitch(
                              width: 51.w,
                              height: 34.h,
                              toggleSize: 34.r,
                              value: true,
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
                              onToggle: (val) {
                                setState(() {
                                  // status2 = val;
                                });
                              },
                            ),
                            SizedBox(
                              width: 13.w,
                            ),
                            Text(
                              '16+ years',
                              style: TextStyle(
                                fontFamily: Constants.FONT_ARIEN,
                                fontSize: 18.sp,
                                color: const Color(0xff707070),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        SizedBox(
                          height: 74.h,
                        ),
                        Container(
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
                          margin: EdgeInsets.only(bottom: 30.h),
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
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
