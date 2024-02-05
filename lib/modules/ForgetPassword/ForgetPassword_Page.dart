import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stroke_text/stroke_text.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  var formKey = GlobalKey<FormState>();
  var emailAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            child: SvgPicture.asset(
              "assets/images/Vector 402.svg",
              width: double.infinity,
              alignment: Alignment.topCenter,
            ),
          ),
          SizedBox(
            child: SvgPicture.asset(
              "assets/images/Vector 403.svg",
              width: double.infinity,
              alignment: Alignment.topCenter,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight / 19),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 22,
                      ),
                    )
                  ],
                ),
                SizedBox(height: screenHeight / 11.5),
                StrokeText(
                  text: "Forgot password",
                  textStyle: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  strokeWidth: 3.0,
                  strokeColor: Colors.white,
                ),
                SizedBox(height: 0.02),
                StrokeText(
                  text: "Let us help you recover your password",
                  textStyle: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  strokeWidth: 1.0,
                  strokeColor: Colors.white,
                ),
                SizedBox(height: screenHeight / 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StrokeText(
                            text: "Email Address",
                            textStyle: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            strokeWidth: 1.0,
                            strokeColor: Colors.black,
                          ),
                          SizedBox(height: 3,),
                          TextFormField(
                            controller: emailAddressController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your email address';
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'youremail@gmail.com',
                              labelStyle: TextStyle(
                                  color: Colors.grey, fontWeight: FontWeight.w400),
                              hintText: 'Enter your email here',
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontWeight: FontWeight.w400),
                              fillColor: Colors.white, // Set your desired background color here
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                              ),
                              // Consider adding errorText or counterText for validation/info
                            ),
                          ),
                          SizedBox(height: screenHeight / 15),
                          defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                showToast(
                                    text: "text", state: ToastStates.WARNING);
                              } else {
                                showToast(
                                    text: "Please Enter ",
                                    state: ToastStates.ERROR);
                              }
                            },
                            text: 'Send OTP',
                            isUpperCase: false,
                            fontWeight: FontWeight.w300,
                            width: screenWidth / 1.1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
