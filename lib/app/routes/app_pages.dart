import 'package:get/get.dart';
import 'package:gym/app/Presenttation/Admin/Admin.dart';
import 'package:gym/app/Presenttation/Auth/bindings/Auth_binding.dart';
import 'package:gym/app/Presenttation/Auth/views/Login.dart';
import 'package:gym/app/Presenttation/Auth/views/Registeration.dart';
import '../Presenttation/SplashScreen.dart';
import '../Presenttation/home/bindings/home_binding.dart';
import '../Presenttation/home/views/home_view.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SplashScreen;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),

      transition: Transition.topLevel,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: _Paths.SplashScreen,
      page: () => SplashScreen(),

      transition: Transition.topLevel,
      transitionDuration: Duration(milliseconds: 500),
    ),


    GetPage(
      name: _Paths.Login,
      page: () => LoginScreen(),
      binding: AuthBinding(),
      transition: Transition.topLevel,
      transitionDuration: Duration(milliseconds: 500),
    ),

    GetPage(
      name: _Paths.SignUp,
      page: () => Registeration(),
      binding: AuthBinding(),
      transition: Transition.topLevel,
      transitionDuration: Duration(milliseconds: 500),
    ),

    GetPage(
      name: _Paths.Admin,
      page: () => Admin(),
      transition: Transition.topLevel,
      transitionDuration: Duration(milliseconds: 500),
    ),
  ];
}
