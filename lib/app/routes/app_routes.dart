part of 'app_pages.dart';


abstract class Routes {
  Routes._();
  static const SplashScreen = _Paths.SplashScreen;
  static const HOME = _Paths.HOME;
  static const Login = _Paths.Login;
  static const SignUp = _Paths.SignUp;
  static const Admin = _Paths.Admin;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const SplashScreen = '/SplashScreen';
  static const Login = '/Login';
  static const SignUp = '/SignUp';
  static const Admin = '/Admin';
}
