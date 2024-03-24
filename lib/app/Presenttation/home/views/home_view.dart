import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global_widgets/custom_app_bar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import 'Navigationbar.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomeAppbar(ontap: (){
          Navigator.pushNamed(context, Routes.Admin);
        }),
        drawer: NavigationBars(),

        body: Container(
          child: Text("hello"),
        )
    );
  }
}
