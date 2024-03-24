

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/fonts.gen.dart';
import '../theme/common_widget.dart';
import '../values/colors.dart';





class DialogBox {





  static Future<bool> popupdialog(BuildContext context,{String? title,String? content,void Function()? yes,void Function()? no})async {
    return (await showDialog(


      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,

        title: Text("${title}"),
        content: Text("${content}"),
        actions: <Widget>[
          TextButton(
            onPressed:no,

            child: Text('No'),
          ),
          TextButton(
            onPressed:yes,

            child: Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }


  static void UserfirstimeopenPermission(BuildContext context,{String? title,String? content,void Function()? yesontap,no})async {
    return  showDialog(


      barrierDismissible: false,


      context: context,
      builder: (context) => AlertDialog(

        insetPadding: EdgeInsets.only(bottom: 600.h),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        titlePadding: EdgeInsets.only(bottom: 10.h,left: 15.w,right: 15.w,top: 20.h),
        contentPadding: EdgeInsets.only(top: 5.h,left: 15.w,right: 15.w,bottom: 20.h),

        title: Center(
          child: reausabletext("Welcome ${title}!!",fontfamily: FontFamily.interRegular,fontsize: 17,widths: 240,maxline: 1,textoverflow: TextOverflow.ellipsis,align: TextAlign.center),
        ),
        content: SingleChildScrollView(child: reausabletext("${content}",fontfamily: FontFamily.interMedium,fontsize: 13,widths: 240,align: TextAlign.center,maxline: 5),),
        actions: [
         Padding(padding: EdgeInsets.only(left: 10.w,right: 10.w),child:  Row(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,

           children: [


          InkWell(
            onTap:no,
            child:    Container(
                child:Padding(padding: EdgeInsets.only(left: 15.w,right: 15.w,bottom: 5.h,top: 5.h),child:  Center(
                  child: reausabletext("EXIT",fontsize:11,color: AppColors.darkBlue,align: TextAlign.center ),

                ),)
            ),
          ),
            InkWell(
              onTap:yesontap,
              child:  Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.r),border: Border.all(color: AppColors.darkBlue,)),
                  child:Padding(padding: EdgeInsets.only(left: 15.w,right: 15.w,bottom: 5.h,top: 5.h),child:  Center(
                    child: reausabletext("LET'S GO",fontsize:11,color: AppColors.darkBlue,align: TextAlign.center ),

                  ),)
              ),
            )




           ],
         ),)
        ],
      ),
    );
  }


}
