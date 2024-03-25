
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchUserData();
  }
  Map? UserData;

  void fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      DatabaseReference userRef =
      FirebaseDatabase.instance.reference().child("users").child(userId);
      userRef.get().then((snapshot) {
        UserData = snapshot.value as Map;

        UserData!['key'] = snapshot.key;
        print("Userdata:${UserData!['name']}");

      });
    } else {
      print("No user currently logged in.");
    }
  }

}
