import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/layout/VolunHeroUserLayout/layout.dart';
import 'package:flutter_code/modules/GeneralView/ForgetPassword/ForgetPassword_Page.dart';
import 'package:flutter_code/modules/GeneralView/OnBoarding2/OnBoarding2_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/components/constants.dart';
import 'package:flutter_code/shared/network/local/CacheHelper.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stroke_text/stroke_text.dart';

import '../../../bloc/Login_bloc/cubit.dart';
import '../../../bloc/Login_bloc/states.dart';
import '../../../bloc/UserLayout_bloc/cubit.dart';
import '../../../bloc/UserLayout_bloc/states.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  var formKey = GlobalKey<FormState>();
  var emailAddressController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<UserLoginCubit, UserLoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                    height: screenHeight / 0.5,
                    child: SvgPicture.asset(
                      "assets/images/Vector_401.svg",
                      width: double.infinity,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight / 14),
                      SizedBox(height: screenHeight / 17),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: screenWidth / 50,
                          top: screenHeight / 10,
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
                      SizedBox(height: screenHeight / 15),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
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
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your email address';
                                    }
                                    return null;
                                  },
                                  controller: emailAddressController,
                                  type: TextInputType.emailAddress,
                                  hintText: 'Youremail@gmail.com',
                                ),
                                SizedBox(height: screenHeight / 40),
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
                                TextFormField(
                                  obscureText:
                                  (UserLoginCubit.get(context).isPassword)
                                      ? true
                                      : false,
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your Password';
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    labelStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey.shade500,
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 20,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                        width: 1.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                        width: 1.0,
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        UserLoginCubit.get(context).suffix,
                                      ),
                                      onPressed: () {
                                        UserLoginCubit.get(context)
                                            .changeVisibility();
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight / 90),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: screenWidth / 1.55,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      navigateAndFinish(
                                          context, ForgetPassword());
                                    },
                                    child: const Text(
                                      "Forget Password?",
                                      style: TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight / 5.0),
                                (state is! UserLoginLoadingState)
                                    ? defaultButton(
                                  function: () {
                                    if (formKey.currentState!
                                        .validate()) {
                                      UserLoginCubit.get(context)
                                          .loginUser(
                                        email:
                                        emailAddressController.text,
                                        password: passwordController.text,
                                      )
                                          .then((value) {
                                        UserLoginCubit.get(context)
                                            .getLoggedInUserData(
                                            token: UserLoginCubit.get(
                                                context)
                                                .loginModel!
                                                .refresh_token)
                                            .then((value) {
                                          if (UserLoginCubit.get(context)
                                              .loggedInUser !=
                                              null) {
                                            navigateAndFinish(context,
                                                const VolunHeroUserLayout());
                                          }
                                        });
                                      });
                                    }
                                  },
                                  text: "Login",
                                  isUpperCase: false,
                                  fontWeight: FontWeight.w300,
                                  width: screenWidth / 1.1,
                                )
                                    : const Center(
                                  child: CircularProgressIndicator(
                                    color: defaultColor,
                                  ),
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
                                        navigateAndFinish(
                                            context, const OnBoarding2());
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
                ],
              ),
            ),
          );
        });
  }
}
