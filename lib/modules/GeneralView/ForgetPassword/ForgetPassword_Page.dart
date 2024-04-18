import 'package:flutter/material.dart';
import 'package:flutter_code/modules/GeneralView/Login/Login_Page.dart';
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
                SizedBox(height: screenHeight / 14),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        navigateAndFinish(context, LoginPage());
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 23,
                      ),
                    )
                  ],
                ),
                SizedBox(height: screenHeight / 17),
                const Text(
                  "Forgot password",
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 0.02),
                const Text(
                  "Let us help you recover your password",
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight / 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const StrokeText(
                            text: "Email Address",
                            textStyle: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            strokeWidth: 1.0,
                            strokeColor: Colors.black,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          defaultTextFormField(
                            validate: (value){
                              if (value!.isEmpty) {
                                return 'please enter your email address';
                              }
                              return null;
                            },
                            controller: emailAddressController,
                            type: TextInputType.emailAddress,
                            hintText: 'Youremail@gmail.com',
                          ),
                          SizedBox(height: screenHeight / 15),
                          defaultButton(
                            function: () {
                              // navigateAndFinish(context, ResetPassword());
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
          ),
        ],
      ),
    );
  }
}
