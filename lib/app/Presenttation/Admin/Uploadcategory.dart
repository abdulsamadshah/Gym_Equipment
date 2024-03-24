import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/app/core/theme/common_widget.dart';
import 'package:gym/app/core/utils/Utils.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import '../../core/const/bottomSheet.dart';
import '../../core/utils/utility.dart';

class Uploadcategory extends StatefulWidget {
  const Uploadcategory({Key? key}) : super(key: key);

  @override
  State<Uploadcategory> createState() => _UploadcategoryState();
}

class _UploadcategoryState extends State<Uploadcategory> {
  final postref =
      FirebaseDatabase.instance.reference().child("starbabiescategory");
  final getcategoryref = FirebaseDatabase.instance.reference();
  TextEditingController product_name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController quantity = TextEditingController();

  String dropdownvalue = 'BabyGear';
  var items = [
    'BabyGear',
    "ToysGaming",

  ];

  // List of items in our dropdown menu
  var category_image;
  var category;

  // File? image;
  // var pickimage = ImagePicker();
  // File? categoryimage;
  // var categorypickimage = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Category"),
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
                            // height: MediaQuery.of(context).size.height * .2,
                            // width: MediaQuery.of(context).size.height * 1,

                            child: Stack(
                              children: [
                                Container(
                                    height: 140,
                                    width: 320,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                    child: Container(
                                        child: category_image != null
                                            ? ClipRect(
                                                child: Image.file(
                                                    category_image!.absolute,
                                                    fit: BoxFit.cover),
                                              )
                                            : Container(
                                                child: Center(
                                                    child: Text(
                                                  "Click Here to Upload Category Image",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                              ))),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, top: 10),
                      child: Container(
                        // Container(
                        width: 320,
                        height: 40,
                        decoration: BoxDecoration(border: Border.all()),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Container(
                                width: 60,
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Select Category",
                                    labelText: "${dropdownvalue}",
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: Container(
                                child: SingleChildScrollView(
                                  child: DropdownButton(
                                    // Initial Value
                                    value: dropdownvalue,

                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),

                                    // Array list of items
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(category = items),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        //var dropdownvalue any object set now
                                        dropdownvalue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: reausablebutton(
                            ontap: () async {
                              int categoryid =
                                  DateTime.now().microsecondsSinceEpoch;
                              //i created image upload and she ref url
                              firebase_storage.Reference ref = firebase_storage
                                  .FirebaseStorage.instance
                                  .ref("starbabycategory$categoryid");

                              UploadTask uploadtask =
                                  ref.putFile(category_image!.absolute);
                              await Future.value(uploadtask);
                              //and thend download image url created
                              var productimg = await ref.getDownloadURL();

                              postref.child(dropdownvalue).set({
                                "categoryid": categoryid.toString(),
                                "categoryname": dropdownvalue.toString(),
                                "categoryimage": productimg.toString(),
                              }).then((value) {
                                Utils().fluttertoast("Uploaded Successfully");
                              }).onError((error, stackTrace) {
                                print(error.toString());
                                Utils().fluttertoast(error.toString());
                              });
                            },
                            title: "Upload Category"),
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
