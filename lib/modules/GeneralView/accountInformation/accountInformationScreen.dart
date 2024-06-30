import 'package:flutter/material.dart';
import 'package:flutter_code/modules/GeneralView/Settings/settingsPage.dart';
import 'package:flutter_code/modules/GeneralView/updatePassword/updatePasswordPage.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stroke_text/stroke_text.dart';

class AccountInformationPage extends StatelessWidget {
  const AccountInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset("assets/images/arrowLeft.svg"),
          onPressed: () {
            navigateAndFinish(context, const SettingsPage());
          },
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StrokeText(
              text: "Your Account",
              textStyle: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
                color: HexColor("296E6F"),
              ),
              strokeWidth: 1.0,
              strokeColor: Colors.white,
            ),
            Text(
              "See more details about your account security",
              style: TextStyle(
                  color: HexColor("656565"),
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  fontSize: 10),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 42.0),
          child: Column(
            children: [
              // assets/images/lock.svg
              buttonComponent(
                "assets/images/lock.svg",
                "Update Password",
                context,
                const UpdatePassword(),
              ),
              SizedBox(height: screenHeight / 30),
              buildSettingsItem(
                Icons.email_outlined,
                'Change Email',
                context,
                const SettingsPage(),
              ),
              SizedBox(height: screenHeight / 30),
              InkWell(
                onTap: () {},
                child: Container(
                  width: screenWidth / 1.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: screenHeight / 120,
                      bottom: screenHeight / 120,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 26,
                            end: screenWidth / 30,
                          ),
                          child: SvgPicture.asset(
                            "assets/images/delete_account.svg",
                            width: 23,
                            height: 23,
                          ),
                        ),
                        SizedBox(width: screenWidth / 30),
                        const Text(
                          "Delete Account",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            color: Colors.redAccent,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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

  Widget buttonComponent(
      String iconAsset, String title, BuildContext context, Widget screen) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () => navigateToPage(context, screen),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            top: screenHeight / 120,
            bottom: screenHeight / 120,
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: screenWidth / 30,
                  end: screenWidth / 30,
                ),
                child: SvgPicture.asset(iconAsset),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: screenWidth / 80,
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: "Roboto",
                    color: Colors.black87,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  end: screenWidth / 60,
                ),
                child: SvgPicture.asset("assets/images/Expand_right.svg"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
