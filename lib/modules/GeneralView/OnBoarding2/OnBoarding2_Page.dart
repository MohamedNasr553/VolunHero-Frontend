import 'package:flutter/material.dart';
import 'package:flutter_code/modules/OrganizationView/OrganizationSignUp/Organization_SignUp_Page.dart';
import 'package:flutter_code/modules/UserView/UserSignUp/User_SignUp_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stroke_text/stroke_text.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: screenHeight / 1.5,
                child: SvgPicture.asset(
                  "assets/images/Vector_401.svg",
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                ),
              ),
              Positioned(
                top: screenHeight / 4.4,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 90.0,
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const StrokeText(
                      text: "VolunHero",
                      textStyle: TextStyle(
                        fontSize: 43.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 68, 114),
                      ),
                      strokeWidth: 3.0,
                      strokeColor: Colors.white,
                    ),
                    const SizedBox(height: 5.0,),
                    const Text(
                      "Connecting Hearts, Guiding Paths",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                        color: defaultColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          defaultButton(
            function: () {
              navigateAndFinish(context, const UserSignupPage());
            },
            text: 'Sign up as a user',
            isUpperCase: false,
            fontSize: 17.0,
            fontWeight: FontWeight.w100,
            width: screenWidth / 1.1,
          ),
          const SizedBox(height: 15.0),
          defaultButton(
            function: () {
              navigateAndFinish(context, const OrganizationSignUp());
            },
            fontWeight: FontWeight.w100,
            fontSize: 17.0,
            text: 'Sign up as an organization',
            isUpperCase: false,
            width: screenWidth / 1.1,
          ),
        ],
      ),
    );
  }
}
