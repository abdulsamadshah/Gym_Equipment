import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../values/colors.dart';

Widget CNetworkImage(
    {String? imageurl,
    int height = 170,
    int width = 340,
    double borderradius = 8,
    String? circlindicator}) {
  return Container(
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderradius.r),
        child: CachedNetworkImage(
          height: height.h,
          imageUrl: "${imageurl}",
          fit: BoxFit.fill,
          placeholder: (context, string) => circlindicator == "no"
              ? SizedBox()
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ));
}

Widget ReausableLoading() {
  return Center(
    child: CircularProgressIndicator(
      color: Colors.white,
      backgroundColor: Colors.grey,
      strokeWidth: 5,
    ),
  );
}

Widget ContainerNetworkImage(
    {String? imageurl,
    int height = 100,
    int width = 100,
    double borderradius = 8,
    String? circlindicator}) {
  return Container(
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
              alignment: Alignment(-.2, 0),
              image: NetworkImage(imageurl.toString()),
              fit: BoxFit.cover)));
}

Widget reausableIcon(
    {required IconData icon,
    Color color = Colors.black,
    double size = 20,
    void Function()? ontap}) {
  return InkWell(
    onTap: ontap,
    child: Icon(
      icon,
      color: color,
      size: size.sp,
    ),
  );
}

Widget reausababletextfield(
  TextEditingController textctr,
  String hintname, {
  double? height,
  double? width,
  double top = 5,
  double left = 15,
  double bottom = 0,
  TextInputType? keyboardtype,
  FormFieldValidator? validators,
  Color hintcolor = Colors.black,
  int? maxline,
  bool? dense,
  double? hintfontsize,
  bool? enable,
  Color fillColor = Colors.white,
  String? otptext,
  bool? filled,
  String? postcode,
  void Function(String value)? onsubmitted,
  void Function(String value)? onchange,
}) {
  return Container(
    width: width,
    child: TextFormField(
      enabled: enable,
      onChanged: onchange,
      onFieldSubmitted: onsubmitted,
      // autofillHints: [ AutofillHints.oneTimeCode ],
      controller: textctr,
      validator: validators,
      maxLines: maxline,
      keyboardType: keyboardtype,
      decoration: InputDecoration(
        filled: filled,
        isDense: dense,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xffDEDEDE), width: 0.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.textbordercolor, width: 0.0),
        ),
        hintText: '$hintname',
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.textbordercolor, width: 0.0),
        ),
        focusedBorder: OutlineInputBorder(
          //<-- SEE HERE
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey, width: 0.0),
        ),
        contentPadding:
            EdgeInsets.only(top: top.h, left: left.w, bottom: bottom.h),
        hintStyle: TextStyle(color: hintcolor, fontSize: hintfontsize),
      ),
    ),
  );
}

Widget reausablebutton(
    {void Function()? ontap,
    String? title,
    int width = 320,
    int height = 50,
    Color textcolor = Colors.white,
    double borderradiues = 30,
    String? type}) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderradiues.r),
        color: AppColors.darkBlue,
      ),
      child: Center(
        child: Text(
          "$title",
          style: TextStyle(
              fontSize: 18.sp,
              fontFamily: FontFamily.interSemiBold,
              color: textcolor),
        ),
      ),
    ),
  );
}

Widget ReusableJobDetail(String type, var value,
    // {int height = 30,
    // int width = 150,
    // int fontsize = 17,
    // int textheight = 30,
    // int textwidth = 120,
    {int height = 30,
    int width = 90,
    int fontsize = 17,
    int textheight = 30,
    int textwidth = 75,
    int textfontsize = 15}) {
  return Container(
    child: Row(
      children: [
        Container(
          width: width.w,
          height: height.h,
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade300,
            // border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Center(
              child: Text(
                "${type}",
                style: TextStyle(
                  fontSize: fontsize.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        // SizedBox(width: 8,),
        Container(
          width: textwidth.w,
          height: textheight.h,
          decoration: BoxDecoration(
            // color: Colors.grey,
            // border: Border.all(color: Colors.black),
            // borderRadius: BorderRadius.circular(0),

            border: Border(
              right: BorderSide(
                color: Colors.black,
                width: 0,
              ),
              top: BorderSide(
                color: Colors.black,
                width: 0,
              ),
              bottom: BorderSide(
                color: Colors.black,
                width: 0,
              ),
            ),
          ),
          child: Center(
            child: Text(
              value,
              maxLines: 2,
              style: TextStyle(
                fontSize: textfontsize.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget ReusableUpderline() {
  return const Divider(
    color: Colors.black,
  );
}

AppBar reusableAppbar(String title, Color color) {
  return AppBar(
    // Color.fromARGB(240, 132, 104, 236)
    backgroundColor: color,
    leading: const BackButton(color: Colors.white),
    centerTitle: false,
    title: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    elevation: 0,
  );
}

Widget LostinternetConnection() {
  return Align(
    alignment: Alignment.center,
    child: Center(child: Image.asset(Assets.images.enternetlost.path)),
  );
}

Widget ReausableAssetsIcon(
    {String? assetspath, double? height, double? width}) {
  return Align(
    alignment: Alignment.center,
    child: Image.asset(
      height: height,
      width: width,
      "$assetspath",
      // height: 220.h,
    ),
  );
}

Widget reausabletext(String title,
    {int fontsize = 20,
    Color? color,
    String fontfamily = "geographeditwebbold",
    FontWeight? fontweight,
    double? height,
    double? widths,
    TextDecoration? decorattion,
    Color? backcolor,
    Color? decorationcolor,
    TextAlign? align,
    int? maxline,
    TextOverflow? textoverflow}) {
  return Container(
    width: widths,
    child: Text(
      textAlign: align,
      title,
      overflow: textoverflow,
      maxLines: maxline,
      style: TextStyle(
          decoration: decorattion,
          backgroundColor: backcolor,
          height: height,
          fontFamily: fontfamily,
          fontSize: fontsize.sp,
          color: color,
          decorationColor: decorationcolor,
          fontWeight: fontweight),
    ),
  );
}

AppBar JobAppbar(
  BuildContext context, {
  void Function()? onback,
  String? title,
  String? menu,
  IconData? menuicon,
  void Function()? menuontap,
  GlobalKey? key,
  double elevation = 0,
}) {
  return AppBar(
    centerTitle: true,
    elevation: elevation,
    leading: Container(
      child: InkWell(
        onTap: onback,
        child: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
      ),
    ),
    backgroundColor: AppColors.darkBlue,
    surfaceTintColor: Colors.white,
    title: Text(
      key: key,
      "${title}",
      style: TextStyle(
          fontFamily: FontFamily.interBold,
          fontSize: 21.sp,
          color: Colors.white),
    ),
    actions: [
      menu != ""
          ? InkWell(
              onTap: menuontap,
              child: SizedBox(
                width: 40,
                child: Icon(
                  menuicon,
                  // FontAwesomeIcons.ellipsisVertical
                  color: Colors.white,
                  size: 22.sp,
                ),
              ),
            )
          : SizedBox()
    ],
  );
}
