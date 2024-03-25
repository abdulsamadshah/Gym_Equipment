import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gym/app/Presenttation/Admin/Productcontroller.dart';
import 'package:gym/app/Presenttation/Admin/uploadproduct.dart';
import 'package:gym/app/Presenttation/Cart.dart';

import 'package:gym/gen/fonts.gen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import '../core/theme/common_widget.dart';
import '../core/utils/Utils.dart';
import '../global_widgets/custom_app_bar.dart';

class Product extends StatefulWidget {
  var type;
  var categoryid, categoryname;

  Product(this.categoryid, this.categoryname, {this.type});

  @override
  State<Product> createState() => _Uploadproductdata();
}

class _Uploadproductdata extends State<Product> {
  final getproductref = FirebaseDatabase.instance.reference();
  final controller = Get.put(ProductContoller());

  var category;
  var Product_image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppbar(title: widget.categoryname),
      bottomNavigationBar: widget.type == "admin"
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 15.w),
              child: reausablebutton(
                  ontap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Uploadproductdata(
                                  widget.categoryid,
                                  widget.categoryname,
                                )));
                  },
                  title: "Add Product",
                  textcolor: Colors.white),
            )
          : SizedBox(),
      body: FirebaseAnimatedList(
        query:
            getproductref.ref.child("All_Product").child(widget.categoryname),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map student = snapshot.value as Map;
          student['key'] = snapshot.key;

          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: GestureDetector(
                onTap: () {

                },
                child: Card(
                    elevation: 1,
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: 0.w, bottom: 0.h, top: 0.h),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CNetworkImage(
                                  imageurl: student['productimage'],
                                  width: 120,
                                  height: 110),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Center(
                                      child: reausablebutton(
                                          ontap: () {
                                            //******************Add to Cart *************************//

                                            var uploadproductref =
                                            FirebaseDatabase.instance.reference().child("Cart");
                                            uploadproductref.remove();

                                            uploadproductref.child(student['productid']).set({
                                              "productid": student['productid'].toString(),
                                              "productimage": student['productimage'].toString(),
                                              "productname": student['productname'].toString(),
                                              "productdescription":
                                              student['productdescription'].toString(),
                                              "productprice": student['productprice'].toString(),
                                              "quantity": student['quantity'].toString(),
                                            }).then((value) {
                                              Utils().fluttertoast("Add to Cart Successfully");
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => Cart(),
                                                  ));
                                            }).onError((error, stackTrace) {
                                              Utils().fluttertoast(error.toString());
                                            });
                                          },
                                          title: "Add to Cart",
                                          width: 190,
                                          height: 30),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ));
        },
      ),
    );
  }
}
