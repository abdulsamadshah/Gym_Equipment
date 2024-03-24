import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProductContoller extends GetxController {
  TextEditingController productname = TextEditingController();
  TextEditingController productdescription = TextEditingController();
  TextEditingController productprice = TextEditingController();
  TextEditingController quantity = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productdescription.dispose();
    productname.dispose();
    productprice.dispose();
    quantity.dispose();
  }
}
