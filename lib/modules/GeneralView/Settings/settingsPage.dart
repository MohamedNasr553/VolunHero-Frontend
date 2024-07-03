import 'package:flutter/material.dart';
import 'package:flutter_code/layout/VolunHeroLayout/layout.dart';
import 'package:flutter_code/modules/GeneralView/Login/Login_Page.dart';
import 'package:flutter_code/modules/GeneralView/Settings/termsOfServices.dart';
import 'package:flutter_code/modules/GeneralView/accountInformation/accountInformationScreen.dart';
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
            navigateAndFinish(context, const VolunHeroLayout());
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth / 20,
          vertical: screenHeight / 150,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Settings
              Row(
                children: [
                  SvgPicture.asset("assets/images/Setting_line.svg"),
                  SizedBox(width: screenWidth / 25),
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
              SizedBox(height: screenHeight / 30),
              // Account
              const Text(
                "Account",
                style: TextStyle(
                  fontFamily: "Roboto",
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight / 150),
              // Account Details
              Text(
                "Update your info to keep track your account",
                style: TextStyle(
                  color: HexColor("656565"),
                  fontFamily: "Roboto",
                  fontSize: 10,
                ),
              ),
              SizedBox(height: screenHeight / 30),
              buildSettingsItem(
                Icons.person,
                "Account Information",
                context,
                const AccountInformationPage(),
              ),
              SizedBox(height: screenHeight / 50),
              buildSettingsItem(
                Icons.notifications,
                "Notifications",
                context,
                const SettingsPage(),
              ),
              SizedBox(height: screenHeight / 25),
              const Text(
                "Privacy",
                style: TextStyle(
                    fontFamily: "Roboto",
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: screenHeight / 150),
              Text(
                "Customize your privacy to make experience better",
                style: TextStyle(
                  color: HexColor("656565"),
                  fontFamily: "Roboto",
                  fontSize: 10,
                ),
              ),
              SizedBox(height: screenHeight / 30),
              buildSettingsItem(
                Icons.security,
                "Sign in & Privacy",
                context,
                const SettingsPage(),
              ),
              SizedBox(height: screenHeight / 50),
              buildSettingsItem(
                Icons.pending_actions,
                "Terms of services",
                context,
                const TermsOfServices(),
              ),
              SizedBox(height: screenHeight / 50),
              buildSettingsItem(
                Icons.exit_to_app_outlined,
                "Log out",
                context,
                LoginPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
