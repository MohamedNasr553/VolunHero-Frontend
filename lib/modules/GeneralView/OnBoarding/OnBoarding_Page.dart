import 'package:flutter/material.dart';
import 'package:flutter_code/modules/GeneralView/Login/Login_Page.dart';
import 'package:flutter_code/modules/GeneralView/OnBoarding2/OnBoarding2_Page.dart';
import 'package:flutter_code/modules/UserView/UserSignUp/User_SignUp_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/network/local/CacheHelper.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stroke_text/stroke_text.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    void submit(){
      CacheHelper.saveData(
        key: 'onBoarding',
        value: true,
      ).then((value){
        navigateAndFinish(context, LoginPage());
      });
    }

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
              submit();
            },
            text: 'Login',
            isUpperCase: false,
            fontWeight: FontWeight.w300,
            width: screenWidth / 1.1,
          ),
          const SizedBox(height: 15.0),
          defaultButton(
            function: () {
              navigateAndFinish(context, const OnBoarding2());
            },
            fontWeight: FontWeight.w300,
            text: 'Sign up',
            isUpperCase: false,
            width: screenWidth / 1.1,
          ),
        ],
      ),
    );
  }
}
