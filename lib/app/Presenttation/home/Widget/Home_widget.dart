import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../core/theme/common_widget.dart';

Widget ReusablelistItem(
    {String? name,
    String? imagename,
    void Function()? func,
    int height = 25,
    IconData? icon,
    int width = 25}) {
  return Padding(
    padding: EdgeInsets.only(top: 10.h),
    child: InkWell(
        onTap: func,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25.w),
              child: Row(
                children: [
                  imagename == null
                      ? Icon(
                          icon,
                          size: 25.sp,
                        )
                      : SvgPicture.asset(
                          "$imagename",
                          height: height.h,
                          width: width.w,
                        ),
                  SizedBox(
                    width: 20.w,
                  ),
                  reausabletext(name.toString(),
                      fontfamily: FontFamily.interRegular,
                      fontsize: 16,
                      color: Colors.black),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),
          ],
        )),
  );
}

