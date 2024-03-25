import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:geocoding/geocoding.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gym/app/Presenttation/Orders.dart';
import 'package:gym/app/Presenttation/home/views/home_view.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../gen/fonts.gen.dart';
import '../core/theme/common_widget.dart';
import '../core/theme/loading.dart';
import '../core/utils/Utils.dart';
import '../global_widgets/custom_app_bar.dart';
import '../routes/app_pages.dart';

class Select_Drop_Location extends StatefulWidget {
  var totalprice, quantity;
  Map? cartData;

  Select_Drop_Location(
      {Key? key, this.totalprice, this.cartData, this.quantity})
      : super(key: key);

  @override
  _Booking_Step_TwoState createState() => _Booking_Step_TwoState();
}

class _Booking_Step_TwoState extends State<Select_Drop_Location> {
  Completer<GoogleMapController> _controller = Completer();
  final getproductref = FirebaseDatabase.instance.reference();

  String selectedaddress = "";
  var uuid = new Uuid();

  String googlemapethem = "";

  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14.4746,
  );
  LatLng selectedgmaplocation = LatLng(19.080791633914032, 72.87360066930837);
  String username = "";
  late Razorpay razorpay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, errorHandler);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, successHandler);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWalletHandler);
  }

  void errorHandler(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.message!),
      backgroundColor: Colors.red,
    ));
    Navigator.pushNamedAndRemoveUntil(context, Routes.HOME, (route) => false);
  }

  void successHandler(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.paymentId!),
      backgroundColor: Colors.green,
    ));
    Loading().showloading(context);
    String orderId = "Gym2024${DateTime.now().microsecondsSinceEpoch}";

    //and thend download image url created

    var uploadproductref =
        FirebaseDatabase.instance.reference().child("Orders").child(orderId);

    uploadproductref.child(orderId.toString()).set({
      "order_id": orderId.toString(),
      "Username": username,
      "productid": widget.cartData!['productid'],
      "Payment_Status": "Success",
      "productimage": widget.cartData!['productimage'],
      "productname": widget.cartData!['productname'],
      "productdescription": widget.cartData!['productdescription'],
      "productprice": widget.totalprice,
      "quantity": widget.quantity,
    }).then((value) {
      Loading().dismissloading(context);
      getproductref.ref.child("Cart").remove().then((value) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.HOME, (route) => false);
      });
    }).onError((error, stackTrace) {
      Loading().dismissloading(context);
      Utils().fluttertoast(error.toString());
    });
  }

  void externalWalletHandler(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.walletName!),
      backgroundColor: Colors.green,
    ));
    Navigator.pushNamedAndRemoveUntil(context, Routes.HOME, (route) => false);
  }

  void fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      DatabaseReference userRef =
          FirebaseDatabase.instance.reference().child("users").child(userId);
      userRef.get().then((snapshot) {
        Map UserData = snapshot.value as Map;

        UserData['key'] = snapshot.key;
        username = UserData['name'];
        setState(() {});
      });
    } else {
      print("No user currently logged in.");
    }
  }

  Future<void> Searchlocation(LatLng latLng) async {
    try {
      Loading().showloading(context);
      selectedgmaplocation = latLng;

      CameraPosition cameraPosition = new CameraPosition(
        target: latLng,
        zoom: 15,
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      await placemarkFromCoordinates(latLng.latitude, latLng!.longitude)
          .then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];

        selectedaddress =
            '${place.street}, ${place.subLocality}, ${place.administrativeArea},  ${place.postalCode}';

        setState(() {});
        Loading().dismissloading(context);
      });
    } catch (e) {
      Loading().dismissloading(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
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
              rowitem(title: "Name", value: username),
              rowitem(title: "Pickup Address", value: selectedaddress),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
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
                          " " + r"₹" + "${widget.totalprice}",
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
                          openCheckout();
                        },
                        title: "Continue",
                        textcolor: Colors.white),
                  ],
                ),
              )
            ],
          )),
      resizeToAvoidBottomInset: false,
      appBar: CustomeAppbar(title: "Select Pickup Location"),
      backgroundColor: Colors.white,
      body: GoogleMap(
        initialCameraPosition: _kGoogle,
        zoomControlsEnabled: false,
        markers: Set<Marker>.of(<Marker>[
          Marker(
            draggable: true,
            markerId: MarkerId("1"),
            position: selectedgmaplocation,
            infoWindow: InfoWindow(
              title: 'Pickup Location',
            ),
            onDragEnd: ((newPosition) {
              print(newPosition.longitude);
              Searchlocation(newPosition);
            }),
          )
        ]),
        mapType: MapType.normal,
        myLocationButtonEnabled: false,
        onTap: (position) {
          Searchlocation(position);
        },
        compassEnabled: true,
        circles: Set.from([
          Circle(
            circleId: CircleId('Pickup_location'),
            center: selectedgmaplocation,
            radius: 100,
            fillColor: Colors.blue.withOpacity(0.3),
            strokeColor: Colors.blue,
            strokeWidth: 2,
          ),
        ]),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Widget rowitem({String? title, value}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          reausabletext("$title:",
              fontfamily: FontFamily.interSemiBold,
              color: Colors.black,
              fontsize: 16),
          SizedBox(
            width: 5.w,
          ),
          reausabletext("$value",
              fontfamily: FontFamily.interMedium,
              color: Colors.grey,
              widths: 195,
              fontsize: 15),
        ],
      ),
    );
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_uqR125FdCmwfbr",
      "amount": widget.totalprice * 100,
      "name": username,
      "description": " this is the test payment",
      "timeout": "180",
      "currency": "INR",
      "prefill": {
        "contact": "11111111111",
        "email": "test@abc.com",
      }
    };
    razorpay.open(options);
  }
}

Widget rowitem({String? title, value, double valuewidth = 195}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        reausabletext("$title:",
            fontfamily: FontFamily.interSemiBold,
            color: Colors.black,
            fontsize: 16),
        SizedBox(
          width: 5.w,
        ),
        reausabletext("$value",
            fontfamily: FontFamily.interMedium,
            color: Colors.grey,
            widths: valuewidth,
            fontsize: 15),
      ],
    ),
  );
}
