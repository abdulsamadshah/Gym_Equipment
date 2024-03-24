import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gym/app/Presenttation/home/controllers/home_controller.dart';

import '../../../../gen/assets.gen.dart';

import '../Widget/Home_widget.dart';

class NavigationBars extends StatelessWidget {
  const NavigationBars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Drawer(
          width: 280.w,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
            ),
          ),
          child: Container(
            color: Colors.white,
            child: ListView(
              children: [
                ReusablelistItem(
                    name: "Edit Profile",
                    icon: Icons.account_circle_outlined,
                    height: 25,
                    width: 25,
                    func: () {}),
                ReusablelistItem(
                    name: "LogOut",
                    icon: Icons.power_settings_new_outlined,
                    height: 25,
                    width: 25,
                    func: () {
                      controller.signOut(context);
                    }),
              ],
            ),
          )),
    );
  }
}
