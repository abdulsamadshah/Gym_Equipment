
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gym/app/core/utils/Utils.dart';
import 'package:gym/app/routes/app_pages.dart';


class HomeController extends GetxController {
  // Function to handle logout
  void signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(context, Routes.Login, (route) => false);
    } catch (e) {
    Utils().fluttertoast("Something Went Wrong");
    }
  }

}
