
import 'package:flutter/material.dart';
import 'package:gym/app/core/utils/Utils.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import '../../core/theme/common_widget.dart';
import '../../routes/app_pages.dart';


class Uploadproductdata extends StatefulWidget {
  var categoryid, categoryname;

  Uploadproductdata(this.categoryid, this.categoryname);

  @override
  State<Uploadproductdata> createState() => _Uploadproductdata();
}

class _Uploadproductdata extends State<Uploadproductdata> {
  final getproductref = FirebaseDatabase.instance.reference();
  TextEditingController productname = TextEditingController();
  TextEditingController productdescription = TextEditingController();
  TextEditingController productprice = TextEditingController();
  TextEditingController quantity = TextEditingController();

  // List of items in our dropdown menu
  var category;
  File? image;
  var pickimage = ImagePicker();
  File? categoryimage;
  var categorypickimage = ImagePicker();

  void selectimagedailog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Container(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getImagecamera();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.camera),
                      title: Text("Camera"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getImageGallery();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.browse_gallery),
                      title: Text("Gallery"),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Product"),
        actions: [
          InkWell(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.HOME, (route) => false);
              },
              child: Icon(Icons.home_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Stack(
          children: [
            Column(
              children: [
                SingleChildScrollView(
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
                                selectimagedailog(context);
                                print("selected");
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
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                        ),
                                        child: Container(
                                            child: image != null
                                                ? ClipRect(
                                                    child: Image.file(
                                                        image!.absolute,
                                                        fit: BoxFit.cover),
                                                  )
                                                : Container(
                                                    child: Center(
                                                        child: Text(
                                                      "Click Here to Upload Product Image",
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
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: productname,
                          decoration: InputDecoration(
                            hintText: "Enter product name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextField(
                          controller: productdescription,
                          decoration: InputDecoration(
                            hintText: "Enter product Description",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextField(
                          controller: productprice,
                          decoration: InputDecoration(
                            hintText: "Enter product Price",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextField(
                          controller: quantity,
                          decoration: InputDecoration(
                            hintText: "Enter product Quantity",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child:
                          reausablebutton(
                              ontap: () async {
                                int productid =
                                    DateTime.now().microsecondsSinceEpoch;
                                //i created image upload and she ref url
                                firebase_storage.Reference ref = firebase_storage
                                    .FirebaseStorage.instance
                                    .ref("starbabycategory$productid");

                                UploadTask uploadtask =
                                ref.putFile(image!.absolute);
                                await Future.value(uploadtask);
                                //and thend download image url created
                                var productimg = await ref.getDownloadURL();

                                var uploadproductref = FirebaseDatabase.instance
                                    .reference()
                                    .child("All Product")
                                    .child(widget.categoryname);
                                // .child(widget.categoryid);

                                uploadproductref.child(productid.toString()).set({
                                  "productid": productid.toString(),
                                  "productimage": productimg.toString(),
                                  "productname": productname.text.toString(),
                                  "productdescription": productdescription.text.toString(),
                                  "productprice": productprice.text.toString(),
                                  "quantity": quantity.text.toString(),
                                }).then((value) {
                                 Utils().fluttertoast("Uploaded Successfully");
                                }).onError((error, stackTrace) {

                                  Utils().fluttertoast(error.toString());
                                });
                              },
                              title: "Upload Product",
                              textcolor: Colors.white),


                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: FirebaseAnimatedList(
                    query: getproductref.ref.child("All Product").child(widget.categoryname),
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      // Map<String, dynamic> datas = jsonDecode(jsonEncode(snapshot.value))  as Map<String, dynamic>;
                      Map student = snapshot.value as Map;
                      student['key'] = snapshot.key;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Card(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image(
                                      height: 100,
                                      width: 100,
                                      image:
                                      NetworkImage(student['productimage'])),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 25),
                                          child: Text(
                                            student['productname'],
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          " " + r"₹" + student['productprice'],
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {
                                              // setState(() {
                                              //   showspinner=true;
                                              // });
                                              print("babygearproductid:${student['productid']}");

                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10, right: 10),
                                              child: Container(
                                                height: 35,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.deepPurple,
                                                    borderRadius:
                                                    BorderRadius.circular(5)),
                                                child: Center(
                                                  child: Text(
                                                    "Add to cart",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future getImageGallery() async {
    final pickfile = await pickimage.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickfile != null) {
        image = File(pickfile.path);
      } else {
        Utils().fluttertoast("No image selected");
      }
    });
  }

  Future getcategoryImageGallery() async {
    final categorypickfile =
        await categorypickimage.pickImage(source: ImageSource.gallery);
    setState(() {
      if (categorypickfile != null) {
        categoryimage = File(categorypickfile.path);
      } else {
        Utils().fluttertoast("No categoryimage selected");
      }
    });
  }

  Future getImagecamera() async {
    final pickfile = await pickimage.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickfile != null) {
        image = File(pickfile.path);
      } else {
        Utils().fluttertoast("No image selected");
      }
    });
  }
}
