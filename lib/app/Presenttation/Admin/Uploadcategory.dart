import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/app/core/theme/common_widget.dart';
import 'package:gym/app/core/utils/Utils.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

import '../../core/const/bottomSheet.dart';
import '../../core/utils/utility.dart';

import 'Category.dart';

class Uploadcategory extends StatefulWidget {
  const Uploadcategory({Key? key}) : super(key: key);

  @override
  State<Uploadcategory> createState() => _UploadcategoryState();
}

class _UploadcategoryState extends State<Uploadcategory> {
  final postref =
      FirebaseDatabase.instance.reference().child("Gym_Equipment_Category");
  final getcategoryref = FirebaseDatabase.instance.reference();
  TextEditingController product_name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController quantity = TextEditingController();

  String dropdownvalue = 'Plates';
  var items = [
    'Plates',
    "Benches",
    "Racks",
  ];

  // List of items in our dropdown menu
  var category_image;
  var category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category",style: TextStyle(color: Colors.black),),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: reausablebutton(
            ontap: () async {
              int categoryid = DateTime.now().microsecondsSinceEpoch;
              //i created image upload and she ref url
              firebase_storage.Reference ref = firebase_storage
                  .FirebaseStorage.instance
                  .ref("Gym_Equipment_Category$categoryid");

              UploadTask uploadtask = ref.putFile(File(category_image));
              await Future.value(uploadtask);
              //and thend download image url created
              var productimg = await ref.getDownloadURL();

              postref.child(dropdownvalue).set({
                "categoryid": categoryid.toString(),
                "categoryname": dropdownvalue.toString(),
                "categoryimage": productimg.toString(),
              }).then((value) {
           Navigator.push(context, MaterialPageRoute(builder: (context) => Category(),));
                Utils().fluttertoast("Uploaded Successfully");
              }).onError((error, stackTrace) {
                print(error.toString());
                Utils().fluttertoast(error.toString());
              });
            },
            title: "Upload Category"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
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
                                    category_image = path;
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: Container(
                                      height: 160.w,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        border: Border.all(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                      ),
                                      child: Container(
                                          child: category_image != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.file(
                                                    File(category_image),
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : Container(
                                                  child: Center(
                                                      child: Text(
                                                    "Click Here to Upload Category Image",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                                ))),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: Container(
                        height: 50.w,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(7.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Container(
                                width: 60.w,
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Select Category",
                                    labelText: "${dropdownvalue}",
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 150.w),
                                child: Container(
                                  child: SingleChildScrollView(
                                    child: DropdownButton(
                                      // Initial Value
                                      value: dropdownvalue,

                                      // Down Arrow Icon
                                      alignment: Alignment.bottomRight,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),

                                      // Array list of items
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(category = items),
                                        );
                                      }).toList(),

                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
