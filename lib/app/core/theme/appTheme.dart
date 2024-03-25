
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/fonts.gen.dart';

import '../utils/utility.dart';

class MyAppTheme {
  static String ProfilenotFoundImg =
      "https://st3.depositphotos.com/9998432/13335/v/450/depositphotos_133351928-stock-illustration-default-placeholder-man-and-woman.jpg";
  static String notFoundImg =
      "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png";

  static Widget roundedTextFormField(BuildContext context,
      {bool enabled = true,
      double padding = 10,
      bool readOnly = false,
      InputDecoration? decoration,
      TextStyle? hintstyle,
      bool obscureText = false,
      TextInputType? keyboardType = TextInputType.text,
      TextInputAction? textInputAction = TextInputAction.next,
      Widget? prefix,
      Widget? suffix,
      TextEditingController? controller,
      void Function()? onEditingComplete,
      void Function(String? value)? onChanged,
      void Function()? onTap,
      void Function(String? value)? onSaved,
      void Function(String? value)? onFieldSubmitted,
      // List<TextInputFormatter>? inputFormatters,
      String? Function(String?)? validator,
      int? maxLength,
      int? maxLines,
      String? labelText,
      String? hintText,
      double? cursorHeight,
      double? width,
      String? initialValue,
      Color? fillColor,
      bool? filled,
      bool isRequired = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: SizedBox(
        width: width,
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          cursorHeight: cursorHeight,
          keyboardType: keyboardType,

          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(top: 18.h, bottom: 18.h, left: 25.w),
              labelStyle: const TextStyle(
                color: Colors.grey,
              ),
              counterText: "",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  borderSide: const BorderSide(
                      width: 1, style: BorderStyle.solid, color: Colors.red)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  borderSide: const BorderSide(
                      width: 1,
                      style: BorderStyle.solid,
                      color: Color.fromARGB(255, 96, 96, 97))),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xffe8e8e8), width: 1.5.w),
                  borderRadius: BorderRadius.all(Radius.circular(12.r))),
              hintText: hintText,
              hintStyle: hintstyle,
              prefix: prefix,
              filled: filled,
              fillColor: fillColor,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: suffix,
              ),
              suffixStyle: const TextStyle(color: Color(0xff90c03e))),

          onChanged: onChanged,
          // --- validate + control

          controller: controller,
          validator: validator,
          textInputAction: textInputAction,
          readOnly: readOnly,
          enabled: enabled,

          obscureText:
              Utility.isNullEmptyOrFalse(obscureText) ? false : obscureText,
          onEditingComplete: onEditingComplete,
          onSaved: onSaved,
          onTap: onTap,

          initialValue: initialValue,
          //inputFormatters: inputFormatters,
          onFieldSubmitted: onFieldSubmitted,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 15.sp,
          ),

          maxLength: maxLength,
          maxLines: maxLines,
        ),
      ),
    );
  }

  static Widget roundOutlinedTextButton(
      {required String btnText,
      void Function()? onPressed,
      Color? textColor,
      double textSize = 18.0,
      double radius = 18.0,
      Color? buttonColor,
      Color? fillColor,
      Color borderColor = Colors.white}) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                  side: BorderSide(color: borderColor)))),
      child: Text(
        " $btnText ",
        softWrap: false,
        style: TextStyle(
            color: textColor, fontSize: textSize, fontFamily: 'poppins'),
      ),
    );
  }

  static Widget customizedTextFormField(BuildContext context,
      {bool enabled = true,
      bool readOnly = false,
      InputDecoration? decoration,
      TextStyle? hintstyle,
      bool obscureText = false,
      TextInputType? keyboardType = TextInputType.text,
      TextInputAction? textInputAction = TextInputAction.next,
      Widget? prefix,
      Widget? suffix,
      Widget? prefixIcon,
      TextEditingController? controller,
      void Function()? onEditingComplete,
      void Function(String? value)? onChanged,
      void Function()? onTap,
      void Function(String? value)? onSaved,
      void Function(String? value)? onFieldSubmitted,
      List<TextInputFormatter>? inputFormatters,
      String? Function(String?)? validator,
      int? maxLength,
      int? maxLines,
      String? labelText,
      String? hintText,
      double? cursorHeight,
      double? width,
      String? initialValue,
      Color? fillColor,
      bool? filled,
      bool isRequired = false,
      GlobalKey? key,
      FocusNode? focusNode}) {
    return SizedBox(
      width: width,
      child: TextFormField(
        key: key,
        cursorColor: Theme.of(context).primaryColor,
        cursorHeight: cursorHeight,

        keyboardType: keyboardType,

        decoration: InputDecoration(
            enabled: enabled,
            prefixIcon: prefixIcon,
            labelStyle: const TextStyle(
              color: Colors.black,
              fontFamily: FontFamily.interMedium,
            ),
            counterText: "",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.r)),
                borderSide: const BorderSide(
                    width: 1, style: BorderStyle.solid, color: Colors.red)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.r)),
                borderSide: const BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                    color: Color.fromARGB(255, 96, 96, 97))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffe8e8e8), width: 1.5.w),
                borderRadius: BorderRadius.all(Radius.circular(50.r))),
            hintText: hintText,
            hintStyle: hintstyle,
            prefix: prefix,
            filled: filled,
            fillColor: fillColor,
            contentPadding: EdgeInsets.only(top: 0.h, left: 0.w, bottom: 20.h),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: suffix,
            ),
            suffixStyle: const TextStyle(
              color: Colors.black,
              fontFamily: FontFamily.interMedium,
            )),
        focusNode: focusNode,
        onChanged: onChanged,
        // --- validate + control

        controller: controller,
        validator: validator,
        textInputAction: textInputAction,
        readOnly: readOnly,
        enabled: enabled,

        obscureText:
            Utility.isNullEmptyOrFalse(obscureText) ? false : obscureText,
        onEditingComplete: onEditingComplete,
        onSaved: onSaved,
        onTap: onTap,
        inputFormatters: inputFormatters,
        initialValue: initialValue,
        //inputFormatters: inputFormatters,
        onFieldSubmitted: onFieldSubmitted,
        style: TextStyle(
          color: Colors.black,
          fontFamily: FontFamily.interMedium,
          fontSize: 15.sp,
        ),

        maxLength: maxLength,
        maxLines: maxLines,
      ),
    );
  }
}


