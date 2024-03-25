import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




class Loading {
  showloading(context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: ProgressIndicatator(),
          // Lottie.asset("assets/svg/loader.json"),
        ));
  }

  dismissloading(
      context,
      ) {
    Navigator.pop(context);
  }
}

Widget ProgressIndicatator(){
  return Center(
    child: Container(
        height: 70.h,
        width: 70.w,
        child: CircularProgressIndicator(
          backgroundColor: Color(0xffD0D0D0),
          color: Colors.deepPurpleAccent,
          strokeWidth: 10,


        )),
  );
}