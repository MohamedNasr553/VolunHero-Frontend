import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/states.dart';
import 'package:flutter_code/layout/VolunHeroUserLayout/layout.dart';
import 'package:flutter_code/modules/GeneralView/Settings/yourAccountScreen.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset("assets/images/arrowLeft.svg"),
          onPressed: () {
            navigateAndFinish(context, const VolunHeroUserLayout());
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth / 20, vertical: screenHeight / 150),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/images/Setting_line.svg"),
                  SizedBox(
                    width: screenWidth / 25,
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      color: HexColor("296E6F"),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight / 30,
              ),
              const Text(
                "Account",
                style: TextStyle(
                  fontFamily: "Roboto",
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Update your info to keep track your account",
                style: TextStyle(
                  color: HexColor("656565"),
                  fontFamily: "Roboto",
                  fontSize: 11,
                ),
              ),
              SizedBox(
                height: screenHeight / 30,
              ),
              InkWell(
                onTap: () {
                  navigateToPage(context, const YourAccountPage());
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: 8.0,
                      bottom: 8.0,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: screenWidth / 80, end: screenWidth / 30),
                          child: Icon(
                            Icons.person,
                            size: 25,
                            color: HexColor("039FA2"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 140,
                          ),
                          child: const Text(
                            "Account information",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          "assets/images/Expand_right.svg",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight / 50,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: 8.0,
                      bottom: 8.0,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: screenWidth / 80, end: screenWidth / 25),
                          child: Icon(
                            Icons.notifications,
                            size: 25,
                            color: HexColor("039FA2"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 140,
                          ),
                          child: const Text(
                            "Notifications",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          "assets/images/Expand_right.svg",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight / 20,
              ),
              const Text(
                "Privacy",
                style: TextStyle(
                    fontFamily: "Roboto",
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Customize your privacy to make experience better",
                style: TextStyle(
                  color: HexColor("656565"),
                  fontFamily: "Roboto",
                  fontSize: 10,
                ),
              ),
              SizedBox(
                height: screenHeight / 50,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.security,
                          color: HexColor("039FA2"),
                        ),
                        SizedBox(
                          width: screenWidth / 50,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 40,
                          ),
                          child: const Text(
                            "Sign in & security",
                            style: TextStyle(
                                fontFamily: "Roboto",
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          "assets/images/Expand_right.svg",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight / 50,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 120,
                          ),
                          child: Icon(
                            Icons.help_outline_outlined,
                            color: HexColor("039FA2"),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth / 50,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 40,
                          ),
                          child: const Text(
                            "Help and support",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          "assets/images/Expand_right.svg",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight / 50,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                            "assets/images/arcticons_score-sheets.svg"),
                        SizedBox(
                          width: screenWidth / 50,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 60,
                          ),
                          child: const Text(
                            "Terms of Services",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset("assets/images/Expand_right.svg"),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight / 50,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                          ),
                          child: Icon(
                            Icons.exit_to_app_outlined,
                            color: HexColor("039FA2"),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth / 50,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 40,
                          ),
                          child: const Text(
                            "Log out",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset("assets/images/Expand_right.svg"),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
