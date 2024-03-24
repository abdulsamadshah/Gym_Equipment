import 'package:get/get.dart';

import '../controllers/Auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    // Get.lazyPut<AuthController>(
    //       () => AuthController(),
    // );
  }
}

