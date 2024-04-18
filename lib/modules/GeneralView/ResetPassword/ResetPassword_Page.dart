import 'package:flutter/material.dart';
import 'package:flutter_code/modules/GeneralView/Login/Login_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stroke_text/stroke_text.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});

  var formKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

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
                SizedBox(height: screenHeight / 5),
                const Text(
                  "Reset password",
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 0.02),
                const Text(
                  "Enter your new password",
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight / 16.5),
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
                            text: "Password",
                            textStyle: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            strokeWidth: 1.0,
                            strokeColor: Colors.black,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultTextFormField(
                            isPassword: true,
                            validate: (value){
                              if (value!.isEmpty) {
                                return 'please enter your Password';
                              }
                              return null;
                            },
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            hintText: 'Password',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const StrokeText(
                            text: "Confirm Password",
                            textStyle: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            strokeWidth: 1.0,
                            strokeColor: Colors.black,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultTextFormField(
                            isPassword: true,
                            validate: (value){
                              if (value!.isEmpty) {
                                return 'please confirm password';
                              }
                              if (value != passwordController.text) {
                                return 'Passwords are not same';
                              }
                              return null;
                            },
                            controller: confirmPasswordController,
                            type: TextInputType.visiblePassword,
                            hintText: 'Confirm Password',
                          ),
                          SizedBox(height: screenHeight / 15),
                          defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                showToast(
                                  text: "Password Changed Successfully",
                                  state: ToastStates.SUCCESS,
                                );
                                navigateAndFinish(context, LoginPage());
                              }
                            },
                            text: 'Reset Password',
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
