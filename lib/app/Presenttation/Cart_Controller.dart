// ignore_for_file: file_names

import 'package:get/get.dart';

class Cart_Controller extends GetxController {
  RxInt _quantity = 0.obs;

  RxInt get quantit => _quantity;
  int _totalprice = 0;

  int get totalprice => _totalprice;

  void set setquantity(int qty) {
    _quantity.value = int.parse(qty.toString());
  }

  void set setrate(int rate) {
    _totalprice = int.parse(rate.toString());
  }

  addquantity() {
    _quantity++;
    print(_quantity);
  }

  decreasequantity() {
    _quantity--;
  }

  int getquantity() {
    return _quantity.value;
  }

  void addtotalprice(int productprice) {
    _totalprice = _totalprice + productprice;
  }

  void removetotalprice(int productprice) {
    _totalprice = _totalprice - productprice;
  }

  int gettotalprice() {
    return _totalprice;
  }
}
