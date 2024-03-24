import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym/app/Presenttation/home/views/home_view.dart';

import '../../gen/assets.gen.dart';

import '../routes/app_pages.dart';
import 'Auth/views/Login.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Add a delay using Future.delayed to show the splash screen for a few seconds
    Future.delayed(Duration(seconds: 2), () {
      checkLoginStatus(context);
    });

    return Container(
      // width: MediaQuery.sizeOf(context).width,
      // height:MediaQuery.sizeOf(context).height,
      child: Image.asset(Assets.images.appicon.path,width: MediaQuery.sizeOf(context).width,height:MediaQuery.sizeOf(context).height ),
    );
  }

  // Function to check user's login status
  void checkLoginStatus(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.HOME, (route) => false);

      } else {

        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) => LoginScreen()));
        Navigator.of(context).pushReplacementNamed(Routes.Login);
      }
    });
  }
}
