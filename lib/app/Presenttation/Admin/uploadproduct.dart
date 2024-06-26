import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gym/app/Presenttation/Admin/Productcontroller.dart';
import 'package:gym/app/core/theme/loading.dart';
import 'package:gym/app/core/utils/Utils.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import '../../core/const/bottomSheet.dart';
import '../../core/theme/common_widget.dart';
import '../../core/utils/utility.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../routes/app_pages.dart';
import '../Auth/Widget/Home_widget.dart';
import 'Category.dart';

class Uploadproductdata extends StatefulWidget {
  var categoryid, categoryname;

  Uploadproductdata(this.categoryid, this.categoryname);

  @override
  State<Uploadproductdata> createState() => _Uploadproductdata();
}

class _Uploadproductdata extends State<Uploadproductdata> {

  final controller = Get.put(ProductContoller());

  var category;
  var Product_image;



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CustomeAppbar(title: 'Upload Product'),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 15.w),
        child: reausablebutton(
            ontap: () async {
              Loading().showloading(context);
              int productid = DateTime.now().microsecondsSinceEpoch;
              //i created image upload and she ref url
              firebase_storage.Reference ref = firebase_storage
                  .FirebaseStorage.instance
                  .ref("Gym_Equipment_Category$productid");

              UploadTask uploadtask = ref.putFile(File(Product_image)!);
              await Future.value(uploadtask);
              //and thend download image url created
              var productimg = await ref.getDownloadURL();

              var uploadproductref = FirebaseDatabase.instance
                  .reference()
                  .child("All_Product")
                  .child(widget.categoryname);

              uploadproductref.child(productid.toString()).set({
                "productid": productid.toString(),
                "productimage": productimg.toString(),
                "productname": controller.productname.text.toString(),
                "productdescription":
                    controller.productdescription.text.toString(),
                "productprice": controller.productprice.text.toString(),
                "quantity": controller.quantity.text.toString(),
              }).then((value) {
                Loading().dismissloading(context);
                Utils().fluttertoast("Product Uploaded Successfully");
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.HOME, (route) => false);
              }).onError((error, stackTrace) {
                Loading().dismissloading(context);
                Utils().fluttertoast(error.toString());
              });
            },
            title: "Upload Product",
            textcolor: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(

          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: [
                Padding(
                  //iamges loading offline
                  padding: const EdgeInsets.only(left: 0, top: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(),
                    child: InkWell(
                      onTap: () {
                        ModalImage bottomNavbar = ModalImage(
                            isImageCroppable: true,
                            onImageSelect: (path) async {
                              if (Utility.isNotNullEmptyOrFalse(path)) {
                                Product_image = path;
                                Navigator.pop(context);
                                setState(() {});
                              }
                            });
                        bottomNavbar.mainBottomSheet(context);
                      },
                      child: Container(

                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w),
                              child: Container(
                                  height: 140.w,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    border:
                                    Border.all(color: Colors.black),
                                    borderRadius:
                                    BorderRadius.circular(7.0),
                                  ),
                                  child: Container(
                                      width: double.maxFinite,

                                      child: Product_image != null
                                          ? ClipRRect(

                                        borderRadius:
                                        BorderRadius.circular(10),
                                        child: Image.file(

                                          width: double.maxFinite,
                                          File(Product_image),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                          : Container(
                                        child: Center(
                                            child: Text(
                                              "Click Here to Upload Product Image",
                                              style: TextStyle(
                                                  color:
                                                  Colors.white),
                                            )),
                                      ))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                textfield(context,
                    hintname: "Enter product name",
                    textctr: controller.productname,
                    prefixicon: Icons.add_box_sharp,
                    validators: (value) {
                      value = value?.trim();
                      if (value == null || value.toString().isEmpty) {
                        return 'product name cannot be empty';
                      } else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: 15.h,
                ),
                textfield(context,
                    hintname: "Enter product Description",
                    textctr: controller.productdescription,
                    prefixicon: Icons.add_box_sharp,
                    validators: (value) {
                      value = value?.trim();
                      if (value == null || value.toString().isEmpty) {
                        return 'product Description cannot be empty';
                      } else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: 15.h,
                ),
                textfield(context,
                    hintname: "Enter product Price",
                    textctr: controller.productprice,
                    prefixicon: Icons.add_box_sharp,
                    validators: (value) {
                      value = value?.trim();
                      if (value == null || value.toString().isEmpty) {
                        return 'product Price cannot be empty';
                      } else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: 15.h,
                ),
                textfield(context,
                    hintname: "Enter product Quantity",
                    textctr: controller.quantity,
                    prefixicon: Icons.ac_unit, validators: (value) {
                      value = value?.trim();
                      if (value == null || value.toString().isEmpty) {
                        return 'product Quantity cannot be empty';
                      } else {
                        return null;
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
