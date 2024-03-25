import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gym/app/Presenttation/Admin/Productcontroller.dart';
import 'package:gym/app/Presenttation/Admin/uploadproduct.dart';

import 'package:gym/gen/fonts.gen.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import '../core/theme/common_widget.dart';
import '../global_widgets/custom_app_bar.dart';
import '../routes/app_pages.dart';
import 'Cart_Controller.dart';
import 'Select_Location.dart';

class Cart extends StatefulWidget {
  Cart();

  @override
  State<Cart> createState() => _Uploadproductdata();
}

class _Uploadproductdata extends State<Cart> {
  final controller = Get.put(Cart_Controller());
  final getproductref = FirebaseDatabase.instance.reference();
  Map? cartData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppbar(title: "Cart"),
      bottomNavigationBar: controller.getquantity().toString() == "0"
          ? SizedBox()
          : Container(
              decoration: BoxDecoration(
                color: Color(0xffF9F7F7),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            reausabletext("Total",
                                fontfamily: FontFamily.interMedium,
                                color: Colors.grey,
                                fontsize: 16),
                            reausabletext(
                              " " + r"₹" + "${controller.gettotalprice()}",
                              color: Color(0xffFF6E00),
                              fontsize: 16,
                              fontfamily: FontFamily.interBold,
                            ),
                          ],
                        ),
                        reausablebutton(
                            width: 200,
                            height: 40,
                            ontap: () async {
                              setState(() {
                                controller.quantit.value = 0;
                                controller.quantit.value = 0;
                              });

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Select_Drop_Location(
                                      totalprice: controller.gettotalprice(),
                                      cartData: cartData,
                                      quantity: controller.getquantity(),
                                    ),
                                  ));


                            },
                            title: "Continue",
                            textcolor: Colors.white),
                      ],
                    ),
                  )
                ],
              )),
      body: FirebaseAnimatedList(
        query: getproductref.ref.child("Cart"),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map student = snapshot.value as Map;

          student['key'] = snapshot.key;
          cartData = student;

          return student.isEmpty
              ? reausabletext("OOps No Item Found!")
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  child: GestureDetector(
                    onTap: () {},
                    child: Card(
                        elevation: 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: 0.w, bottom: 10.h, top: 0.h),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CNetworkImage(
                                      imageurl: student['productimage'],
                                      width: 120,
                                      height: 100),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.h),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        reausabletext(
                                          "${student['productname']}",
                                          color: Colors.black,
                                          fontsize: 17,
                                          widths: 190.w,
                                          fontfamily: FontFamily.interSemiBold,
                                        ),
                                        reausabletext(
                                          "${student['productdescription']}",
                                          color: Colors.grey,
                                          fontsize: 13,
                                          widths: 190.w,
                                          fontfamily: FontFamily.interRegular,
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        reausabletext(
                                          " " + r"₹" + student['productprice'],
                                          color: Color(0xffFF6E00),
                                          fontsize: 16,
                                          widths: 190.w,
                                          fontfamily: FontFamily.interBold,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 5.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (controller.getquantity() >
                                                  1) {
                                                controller.decreasequantity();
                                                controller.removetotalprice(
                                                    int.parse(student[
                                                        'productprice']));
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                border: Border.all(
                                                    color: Color(0xffFF6E00),
                                                    width: 2)),
                                            child: const Icon(
                                              Icons.remove,
                                              color: Color(0xffFF6E00),
                                              size: 19,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Obx(() {
                                          return Text(
                                            "${controller.getquantity()}",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.bold),
                                          );
                                        }),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              controller.addtotalprice(
                                                  int.parse(
                                                      student['productprice']));
                                              controller.addquantity();
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                border: Border.all(
                                                    color: Color(0xffFF6E00),
                                                    width: 2)),
                                            child: const Icon(
                                              Icons.add,
                                              color: Color(0xffFF6E00),
                                              size: 19,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          getproductref.ref
                                              .child("Cart")
                                              .remove()
                                              .then((value) {
                                            controller.quantit.value = 0;
                                            controller.quantit.value = 0;
                                            Navigator.pushNamedAndRemoveUntil(context, Routes.HOME, (route) => false);

                                          });
                                        });
                                      },
                                      child: reausableIcon(
                                          icon: Icons.delete_outline_rounded,
                                          color: Colors.black,
                                          size: 25.sp),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ));
        },
      ),
    );
  }
}
