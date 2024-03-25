import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/app/Presenttation/Admin/uploadproduct.dart';
import 'package:gym/gen/fonts.gen.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';

import '../core/theme/common_widget.dart';
import '../core/values/colors.dart';
import 'Select_Location.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _UploadcategoryState();
}

class _UploadcategoryState extends State<Orders> {
  final getcategoryref = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white, size: 27.sp),
          centerTitle: false,
          backgroundColor: AppColors.darkBlue,
          title: reausabletext("Orders"),
        ),
        body: FirebaseAnimatedList(
          query: getcategoryref.ref.child("Orders"),
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map student = snapshot.value as Map;
            student['key'] = snapshot.key;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
              child: Card(
                elevation: 2,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7.r),
                              topRight: Radius.circular(7)),
                          child: CachedNetworkImage(
                            height: 120.h,
                            width: double.maxFinite,
                            imageUrl: "${student['productimage']}",
                            fit: BoxFit.fill,
                            placeholder: (context, string) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.w, vertical: 10.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              rowitem(title:"Product",value:"${student['productname']}",valuewidth: 230 ),
                              rowitem(title:"Name",value:student['Username'],valuewidth: 230 ),
                              rowitem(title:"Order Id",value:student['order_id'],valuewidth: 225 ),
                              rowitem(title:"Payment Status",value:student['Payment_Status'] ,valuewidth: 150),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
