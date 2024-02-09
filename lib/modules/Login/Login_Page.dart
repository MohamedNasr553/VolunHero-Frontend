import 'package:flutter/material.dart';
import 'package:flutter_code/modules/ForgetPassword/ForgetPassword_Page.dart';
import 'package:flutter_code/modules/HomePage/homePage.dart';
import 'package:flutter_code/modules/SignUp/SignUp_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stroke_text/stroke_text.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  var formKey = GlobalKey<FormState>();
  var emailAddressController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: screenHeight / 0.5,
              child: SvgPicture.asset(
                "assets/images/Vector_401.svg",
                width: double.infinity,
                alignment: Alignment.topCenter,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 10.0,
                bottom: screenHeight / 0.68,
              ),
              child: const Row(
                children: [
                  StrokeText(
                    text: "We",
                    textStyle: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 47, 129, 131),
                    ),
                    strokeWidth: 3.0,
                    strokeColor: Colors.white,
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  Text(
                    "lcome Back !",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight / 0.79,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 20, 0),
                child: Form(
                  key: formKey,
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
                        height: 6.0,
                      ),
                      defaultTextFormField(
                        validate: (value){
                          if (value!.isEmpty) {
                            return 'please enter your Email Address';
                          }
                          return null;
                        },
                        controller: emailAddressController,
                        type: TextInputType.emailAddress,
                        hintText: 'Youremail@gmail.com',
                      ),
                      SizedBox(height: screenHeight / 50),
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
                        height: 6.0,
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
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                navigateToPage(context, ForgetPassword());
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(150, 70, 70, 70),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight / 5),
                      defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            showToast(
                              text: "Login Successfully",
                              state: ToastStates.SUCCESS,
                            );
                            navigateAndFinish(context, HomePage());
                          }
                        },
                        text: 'Login',
                        isUpperCase: false,
                        fontWeight: FontWeight.w300,
                        width: screenWidth / 1.1,
                      ),
                      SizedBox(height: screenHeight / 70),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don’t have an account?",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w200,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          SizedBox(width: screenWidth / 80),
                          InkWell(
                            onTap: () {
                              navigateAndFinish(context, SignupPage());
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: defaultColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
