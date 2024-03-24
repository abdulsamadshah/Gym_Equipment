import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/app/Presenttation/Admin/uploadproduct.dart';
import 'package:gym/gen/fonts.gen.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';

import 'Uploadcategory.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _UploadcategoryState();
}

class _UploadcategoryState extends State<Admin> {
  final getcategoryref = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Uploadcategory(),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 30, top: 20),
              child: Text(

                "Post",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19,color: Colors.black),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                      child: Text(
                    "All Categories",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: FontFamily.interRegular,
                        fontSize: 17),
                  ))),
              Expanded(
                child: FirebaseAnimatedList(
                  query: getcategoryref.ref.child("Gym_Equipment_Category"),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    // Map<String, dynamic> datas = jsonDecode(jsonEncode(snapshot.value))  as Map<String, dynamic>;
                    Map student = snapshot.value as Map;
                    student['key'] = snapshot.key;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Uploadproductdata(
                                        student['categoryid'],
                                        student['categoryname'],
                                      )));
                        },
                        child: Center(
                          child: Stack(
                            children: [
                              Container(
                                height: 170.h,
                                width: 330.w,
                                child: Card(
                                    child: Stack(
                                  children: [
                                    Container(
                                      child: Image.network(
                                        student['categoryimage'],
                                        height: 160.h,
                                        width: 320.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, bottom: 5),
                                      child: Center(
                                          child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                student['categoryname'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        FontFamily.interRegular,
                                                    fontSize: 17),
                                              ))),
                                    ),
                                  ],
                                )),
                              ),
                            ],
                          ),
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
    );
  }
}
