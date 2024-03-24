
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class MessageUtils {
  static showSuccessSnackBar({
    required String title,
    required String message,
  }) {
    Get.snackbar(title, message,
        colorText: Colors.black,
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(0),
        borderRadius: 0.0,
        maxWidth: double.infinity,
        boxShadows: [BoxShadow(color: Colors.grey, blurRadius: 2)]);
  }

  static showErrorSnackBar({
    required String title,
    required String message,
  }) {
    Get.snackbar(title, message,
        colorText: Colors.white,
        backgroundColor: Colors.red[600],
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(0),
        borderRadius: 0.0,
        maxWidth: double.infinity,
        boxShadows: [BoxShadow(color: Colors.red, blurRadius: 2)]);
  }



  static showToastMessage({required String msg}) {
    // Hide keyboard before showing toast
    FocusManager.instance.primaryFocus!.unfocus();
    Fluttertoast.showToast(
        msg: msg, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
  }


  static hideSnackBar() {
    ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
  }


}
