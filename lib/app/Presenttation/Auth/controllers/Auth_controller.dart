import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gym/app/core/theme/loading.dart';
import 'package:gym/app/core/utils/Utils.dart';

import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> Login_authkey = GlobalKey<FormState>();
  final GlobalKey<FormState> Signup_authkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController UsernameController = TextEditingController();

  Future<void> login(BuildContext context) async {
    try {
      Loading().showloading(context);

          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Utils().fluttertoast("Login Successfully");
      Loading().dismissloading(context);

      // Utils().fluttertoast("${userCredential.toString()}");
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.HOME, (route) => false);

    } on FirebaseAuthException catch (e) {
      Loading().dismissloading(context);

      Utils().fluttertoast("${e.toString()}");
    }
  }

  Future<void> register(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Save user details to Firebase Database
      DatabaseReference userRef = FirebaseDatabase.instance
          .reference()
          .child('users')
          .child(userCredential.user!.uid);

      userRef.set({
        'name': UsernameController.text,
        'email': emailController.text,
      });

      Utils().fluttertoast("User registered successfully");
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.HOME, (route) => false);

    } on FirebaseAuthException catch (e) {
      Utils().fluttertoast("Something Went Wrong");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    UsernameController.dispose();
  }
}
