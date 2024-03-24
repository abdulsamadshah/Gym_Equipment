import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gym/app/Presenttation/SplashScreen.dart';

import 'app/core/const/global.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/routes/app_pages.dart';
Future<void> main() async {
  // Global.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(

        debugShowCheckedModeBanner: false,
        title: "Gym Equipment",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,

        theme: ThemeData(
            appBarTheme: AppBarTheme(
              centerTitle: true,
              // titleTextStyle: TextStyles.headingFourStyle(),
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              actionsIconTheme: const IconThemeData(color: Colors.black),
              elevation: 0,
            )),
      )));
}