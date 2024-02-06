import 'package:flutter/material.dart';
import 'package:flutter_code/modules/Login/Login_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stroke_text/stroke_text.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  var formKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailAddressController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

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
                    text: "Cre",
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
                    "ate Account",
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
              height: screenHeight / 0.69,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 20, 0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const StrokeText(
                        text: "First name",
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
                            return 'please enter your First Name';
                          }
                          return null;
                        },
                        controller: firstNameController,
                        type: TextInputType.text,
                        labelText: 'First Name',
                      ),
                      SizedBox(height: screenHeight / 80),
                      const StrokeText(
                        text: "Last name",
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
                            return 'please enter your Last Name';
                          }
                          return null;
                        },
                        controller: lastNameController,
                        type: TextInputType.text,
                        labelText: 'Last Name',
                      ),
                      SizedBox(height: screenHeight / 80),
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
                        labelText: 'Youremail@gmail.com',
                      ),
                      SizedBox(height: screenHeight / 80),
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
                        labelText: 'Password',
                      ),
                      SizedBox(height: screenHeight / 80),
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
                        height: 6.0,
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
                        labelText: 'Confirm Password',
                      ),
                      SizedBox(height: screenHeight / 30),
                      defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            showToast(
                              text: "Registered Successfully",
                              state: ToastStates.SUCCESS,
                            );
                            navigateAndFinish(context, LoginPage());
                          }
                        },
                        text: 'Sign up',
                        isUpperCase: false,
                        fontWeight: FontWeight.w300,
                        width: screenWidth / 1.1,
                      ),
                      SizedBox(height: screenHeight / 70),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account.",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w200,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          SizedBox(width: screenWidth / 80),
                          InkWell(
                            onTap: () {
                              navigateToPage(context, LoginPage());
                            },
                            child: const Text(
                              "Login",
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
