import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/app/Presenttation/Admin/uploadproduct.dart';
import 'package:gym/gen/fonts.gen.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';

import '../../core/theme/common_widget.dart';
import '../../core/values/colors.dart';
import '../Product.dart';
import 'Uploadcategory.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _UploadcategoryState();
}

class _UploadcategoryState extends State<Category> {
  final getcategoryref = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white, size: 27.sp),
        centerTitle: false,
        backgroundColor: AppColors.darkBlue,
        title: reausabletext("Category"),
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
              child: reausabletext("Post",
                  fontfamily: FontFamily.interSemiBold, fontsize: 19),
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
                  padding: EdgeInsets.only(left: 20.w, bottom: 15.h, top: 10.h),
                  child: Container(
                      child: Text(
                    "All Categories",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: FontFamily.interBold,
                        fontSize: 17),
                  ))),
              Expanded(
                child: FirebaseAnimatedList(
                  query: getcategoryref.ref.child("Gym_Equipment_Category"),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    Map student = snapshot.value as Map;
                    student['key'] = snapshot.key;

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Card(
                        elevation: 2,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Product(
                                          student['categoryid'],
                                          student['categoryname'],
                                          type: "admin",
                                        )));
                          },
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
                                    height: 150.h,
                                    width: double.maxFinite,
                                    imageUrl: "${student['categoryimage']}",
                                    fit: BoxFit.fill,
                                    placeholder: (context, string) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      reausabletext(
                                        "${student['categoryname']}",
                                        color: Colors.black,
                                        fontsize: 17,
                                        widths: 290.w,
                                        fontfamily: FontFamily.interBold,
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Row(
                                        children: [
                                          RatingBar(
                                              initialRating: 5,
                                              ignoreGestures: true,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 20.sp,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 0),
                                              ratingWidget: RatingWidget(
                                                  full: const Icon(
                                                    Icons.star,
                                                    color: Colors.deepOrange,
                                                  ),
                                                  half: const Icon(
                                                    Icons.star_half,
                                                    color: Colors.deepOrange,
                                                  ),
                                                  empty: const Icon(
                                                    Icons.star_outline,
                                                    color: Colors.deepOrange,
                                                  )),
                                              onRatingUpdate: (value) {}),
                                          reausabletext(
                                            "${student['categoryname']=="PLATES"?7:10} reviews",
                                            color: Colors.black,
                                            fontsize: 14,
                                            widths: 200.w,
                                            fontfamily: FontFamily.interMedium,
                                          ),
                                        ],
                                      )
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
