import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hippo/utils/constants.dart';

class AppToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onToggle;

  AppToggle({
    required this.value,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 51.w,
      height: 34.h,
      toggleSize: 34.r,
      value: value,
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
      onToggle: onToggle,
    );
  }
}
