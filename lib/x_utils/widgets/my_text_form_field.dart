import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hippo/utils/constants.dart';
import 'package:hippo/x_utils/validator.dart';

import '../currency_input_formater.dart';

/**
 * Created by daewubintara on
 * 11, September 2020 08.34
 */

// ignore: must_be_immutable
class MyTextFormField extends StatelessWidget {
  List<String>? autofillHints;
  ValueChanged<String>? onChanged;
  String labelText;
  String initialText;
  String hint;
  FocusNode? focusNode;
  FocusNode? focusNodeNext;
  bool obscureText;
  bool inputNumber;
  bool currencyMode;
  bool isRequired;
  bool _withIconShowHideText = false;
  int maxLength;
  int maxLines;
  int minLines;
  bool enabled;
  double borderRadius = 12.r;
  TextEditingController? controller;
  FormFieldSetter<String>? onSaved;
  String? Function(String?)? validator = Validator().notEmpty;
  EdgeInsets? padding = EdgeInsets.symmetric(
    vertical: 10.h,
    horizontal: 20.w,
  );

  MyTextFormField(
      {this.autofillHints = null,
      this.onChanged,
      this.isRequired = true,
      this.labelText = "",
      this.hint = "",
      this.initialText = "",
      this.focusNode,
      this.focusNodeNext,
      this.maxLength = 255,
      this.maxLines = 1,
      this.minLines = 1,
      this.onSaved,
      this.validator,
      this.controller,
      this.padding,
        this.enabled = true,
      this.currencyMode = false,
      this.inputNumber = false,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    if (obscureText) {
      _withIconShowHideText = true;
    }
    if (padding == null) {
      padding = EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 20.w,
      );
    }

    return StatefulBuilder(
      builder: (context, setState) {
        return Stack(
          children: [
            controller == null
                ? TextFormField(enabled: enabled,
                    autofillHints: autofillHints,
                    controller: null,
                    maxLength: maxLength,
                    minLines: minLines,
                    validator: validator,
                    onChanged: onChanged,
                    focusNode: focusNode,
                    onSaved: onSaved,
                    onFieldSubmitted: (val) {
                      if (focusNodeNext != null) {
                        FocusScope.of(context).unfocus();
                        FocusScope.of(context).requestFocus(focusNodeNext);
                      } else {
                        FocusScope.of(context).unfocus();
                        return FocusScope.of(context).requestFocus(FocusNode());
                      }
                    },
                    initialValue: initialText,
                    maxLines: maxLines,
                    obscureText: obscureText,
                    textInputAction: focusNodeNext != null
                        ? TextInputAction.next
                        : (maxLines > 1
                            ? TextInputAction.done
                            : TextInputAction.done),
                    keyboardType: inputNumber == true
                        ? TextInputType.number
                        : (maxLines > 1
                            ? TextInputType.multiline
                            : TextInputType.text),
                    inputFormatters: inputNumber == true
                        ? currencyMode == true
                            ? [
                                FilteringTextInputFormatter.digitsOnly,
                                CurrencyInputFormatter()
                              ]
                            : [FilteringTextInputFormatter.digitsOnly]
                        : null,
                    decoration: InputDecoration(
                      hintText: hint,
                      counterText: "",
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "$labelText",
                      contentPadding: padding,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                        borderSide: BorderSide(
                          width: 1.r,
                          color: const Color(0x48707070),
                        ),
                      ),
                    ),
                  )
                : TextFormField(
        enabled: enabled,
                    autofillHints: autofillHints,
                    controller: controller,
                    validator: validator,
                    minLines: minLines,
                    maxLength: maxLength,
                    onChanged: onChanged,
                    focusNode: focusNode,
                    onSaved: onSaved,
                    onFieldSubmitted: (val) {
                      if (focusNodeNext != null) {
                        FocusScope.of(context).unfocus();
                        FocusScope.of(context).requestFocus(focusNodeNext);
                      } else {
                        FocusScope.of(context).unfocus();
                        return FocusScope.of(context).requestFocus(FocusNode());
                      }
                    },
                    // initialValue: initialText,
                    maxLines: maxLines,
                    obscureText: obscureText,
                    textInputAction: focusNodeNext != null
                        ? TextInputAction.next
                        : (maxLines > 1
                            ? TextInputAction.done
                            : TextInputAction.done),
                    keyboardType: inputNumber == true
                        ? TextInputType.number
                        : (maxLines > 1
                            ? TextInputType.multiline
                            : TextInputType.text),
                    inputFormatters: inputNumber == true
                        ? (currencyMode == true
                            ? [
                                WhitelistingTextInputFormatter.digitsOnly,
                                CurrencyInputFormatter()
                              ]
                            : [WhitelistingTextInputFormatter.digitsOnly])
                        : null,
                    decoration: InputDecoration(
                      labelStyle: GoogleFonts.montserrat(fontSize: 18.sp,
                        color: const Color(0x77707070),),
                      hintText: hint,
                      counterText: "",
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "$labelText",
                      contentPadding: padding,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                        borderSide: BorderSide(
                          width: 1.r,
                          color: const Color(0x48707070),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                        borderSide: BorderSide(
                          width: 1.r,
                          color: const Color(0x48707070),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                        borderSide: BorderSide(
                          width: 1.r,
                          color: const Color(0xFF181818),
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                        borderSide: BorderSide(
                          width: 1.r,
                          color: const Color(0xFFCE7070),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                        borderSide: BorderSide(
                          width: 1.r,
                          color: const Color(0xFFCE7070),
                        ),
                      ),
                    ),
                  ),
            _withIconShowHideText == false
                ? Container()
                : Positioned(
                    right: 5,
                    top: 0,
                    child: IconButton(
                      icon: obscureText == true
                          ? Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            )
                          : Icon(
                              Icons.visibility,
                              color: Colors.grey,
                            ),
                      onPressed: () {
                        setState(() {
                          if (obscureText == true) {
                            obscureText = false;
                          } else {
                            obscureText = true;
                          }
                        });
                      },
                    ),
                  )
          ],
        );
      },
    );
  }
}
