import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../core/theme/appTheme.dart';
import '../../../core/theme/common_widget.dart';

Widget textfield(BuildContext context,
    {TextEditingController? textctr,
      String? hintname,
      IconData? prefixicon,
      void Function(String? value)? onChanged,
      FormFieldValidator? validators,
      void Function()? onTap,
      void Function(String? value)? onFieldSubmitted,
      bool enable = true,
      int? maxLength,
      TextInputType? keyboradtype,
      GlobalKey? key,
      List<TextInputFormatter>? inputFormatters,
      FocusNode? focusNode}) {
  return MyAppTheme.customizedTextFormField(
    filled: true,
    onTap: onTap,
    onFieldSubmitted: onFieldSubmitted,
    inputFormatters: inputFormatters,
    focusNode: focusNode,
    fillColor: Color(0xffF4F4F4),
    context,
    onChanged: onChanged,
    keyboardType: keyboradtype,
    enabled: enable,
    maxLength: maxLength,
    controller: textctr,
    validator: validators,
    hintText: hintname,
    prefixIcon: Icon(
      prefixicon,
      color: Color(0xff534A4A),
    ),
  );
}