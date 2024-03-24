import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:gym/gen/fonts.gen.dart';
import '../../../../gen/assets.gen.dart';
import '../../../core/theme/common_widget.dart';
import '../../../core/values/colors.dart';
import '../../../routes/app_pages.dart';
import '../Widget/Home_widget.dart';
import '../controllers/Auth_controller.dart';

class LoginScreen extends GetView<AuthController> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: JobAppbar(context, title: "Kyc Detail", menu: "no", onback: () {
      //   Navigator.pop(context);
      // }),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Form(
              key: controller.Login_authkey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Center(
                      child: Image.asset(
                        "${Assets.images.appicon.path}",
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    textfield(context,

                        hintname: "Email Id",
                        textctr: controller.emailController,
                        prefixicon: Icons.email_outlined, validators: (value) {
                      String patttern =
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                      RegExp regExp = RegExp(patttern);
                      value = value?.trim();
                      if (value == null || value.toString().isEmpty) {
                        return 'Email address is required';
                      } else if (!regExp.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      } else {
                        return null;
                      }
                    }),
                    SizedBox(
                      height: 15.h,
                    ),
                    textfield(context,

                        hintname: "Passsword",
                        textctr: controller.passwordController,
                        prefixicon: Icons.key, validators: (value) {
                      value = value?.trim();
                      if (value == null || value.toString().isEmpty) {
                        return 'Password cannot be empty';
                      } else if (value.toString().length<6) {
                        return 'Six digit Password are required';
                      } else {
                        return null;
                      }
                    }),

                    SizedBox(
                      height: 50.h,
                    ),
                    reausablebutton(
                        ontap: () {
                          if (controller.Login_authkey.currentState!
                              .validate()) {
                            controller.login(context);
                          }
                        },
                        title: "Sign in",
                        textcolor: Colors.white),
                    SizedBox(
                      height: 40.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        reausabletext(
                          "Create Account?",
                          color: Colors.grey,
                          fontsize: 14,
                          fontfamily: FontFamily.interRegular,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.SignUp);
                          },
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: reausabletext(
                              "Sign Up",
                              color: AppColors.darkBlue,
                              fontsize: 16,
                              fontfamily: FontFamily.interRegular,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
