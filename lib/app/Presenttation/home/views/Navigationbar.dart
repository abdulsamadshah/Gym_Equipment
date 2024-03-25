import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gym/app/Presenttation/Orders.dart';
import 'package:gym/app/Presenttation/home/controllers/home_controller.dart';

import '../../../../gen/assets.gen.dart';

import '../../../../gen/fonts.gen.dart';
import '../../../core/theme/appTheme.dart';
import '../../../core/theme/common_widget.dart';
import '../../../core/values/colors.dart';
import '../../../routes/app_pages.dart';
import '../../Cart.dart';
import '../Widget/Home_widget.dart';

class NavigationBars extends StatelessWidget {
   NavigationBars({Key? key}) : super(key: key);

   final controller = Get.put(HomeController());


   @override
  Widget build(BuildContext context) {

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
                Header(),
                ReusablelistItem(
                    name: "Home",
                    icon: Icons.account_circle_outlined,
                    height: 25,
                    width: 25,
                    func: () {
                      Navigator.pop(context);
                    }),
                ReusablelistItem(
                    name: "Cart",
                    icon: Icons.shopping_cart,
                    height: 25,
                    width: 25,
                    func: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Cart(),
                          ));
                    }),
                ReusablelistItem(
                    name: "Order",
                    icon: Icons.add_circle,
                    height: 25,
                    width: 25,
                    func: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Orders(),
                          ));
                    }),

                ReusablelistItem(
                    name: "LogOut",
                    icon: Icons.power_settings_new_outlined,
                    height: 25,
                    width: 25,
                    func: () {
                      Navigator.pop(context);

                      controller.signOut(context);
                    }),
                ReusablelistItem(
                    name: "Admin",
                    icon: Icons.account_box,
                    height: 25,
                    width: 25,
                    func: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.Admin);
                    }),
              ],
            ),
          )),
    );
  }
  Widget Header() {

    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.darkBlue,
              AppColors.darkBlue,
              AppColors.darkBlue,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 25.w, top: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 43.r,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                      radius: 40.r,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                          MyAppTheme.ProfilenotFoundImg),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reausabletext(
                              "${controller.UserData!['name']}",
                              widths: 150,
                              height: 1.1,
                              textoverflow: TextOverflow.ellipsis,
                              fontsize: 25,
                              maxline: 1,
                              fontfamily: FontFamily.interBold,
                              color: Colors.white),
                          reausabletext(
                              widths: 150,
                              textoverflow: TextOverflow.ellipsis,
                              maxline: 1,
                              "${controller.UserData!['email']}",
                              fontsize: 16,
                              fontfamily: FontFamily.interRegular,
                              color: Colors.white),
                        ],
                      ))
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ));
  }

}
