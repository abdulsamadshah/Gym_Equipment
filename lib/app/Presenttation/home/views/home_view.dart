import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../core/theme/common_widget.dart';
import '../../../global_widgets/custom_app_bar.dart';
import '../../../routes/app_pages.dart';
import '../../Product.dart';
import '../controllers/home_controller.dart';
import 'Navigationbar.dart';

class HomeView extends GetView<HomeController> {
  final getcategoryref = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomeAppbar(ontap: () {
        Navigator.pushNamed(context, Routes.Admin);
      }),
      drawer: NavigationBars(),
      body: FirebaseAnimatedList(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
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
                                  "${student['categoryname'] == "PLATES" ? 7 : 10} reviews",
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
    );
  }
}
