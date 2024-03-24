

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/theme/common_widget.dart';
import '../core/values/colors.dart';

AppBar CustomeAppbar({String title="Dashboard",Color backgroundColor=AppColors.darkBlue,void Function()? ontap}){
  return AppBar(
    centerTitle: false,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white, size: 27.sp),
    backgroundColor: backgroundColor,
    title: reausabletext("$title"),
    actions: [
    InkWell(onTap: ontap,child:   reausableIcon(
        icon: Icons.notifications_outlined,
        color: Colors.white,
        size: 25),),
      SizedBox(
        width: 10.w,
        height: 10.h,
      )
    ],
  );
}