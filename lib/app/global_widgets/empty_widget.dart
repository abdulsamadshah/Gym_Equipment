
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/theme/common_widget.dart';

Widget ServerandNetworkIssue({String? message}){
  return Expanded(
      child: Center(
        child: message=="Oops! Something Went Wrong"?reausabletext("Oops! Something Went Wrong",
            color: Colors.white):reausabletext("No Internet Connection",
            color: Colors.white)
      ));
}