import 'package:flutter/material.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/modules/GeneralView/Login/Login_Page.dart';
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
                onTap: () {
                  deleteAccountApproval(context);
                },
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

  void deleteAccountApproval(context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        var screenWidth = MediaQuery.of(context).size.width;
        var screenHeight = MediaQuery.of(context).size.height;

        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: screenHeight / 5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  top: screenHeight / 30,
                  start: screenWidth / 15,
                  end: screenWidth / 15,
                ),
                child: Column(
                  children: [
                    const Text(
                      "Are you sure you want to delete the account "
                          "permanently ?",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: screenHeight / 30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0.5,
                                    blurRadius: 0.5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: screenWidth / 15,
                                  end: screenWidth / 15,
                                  top: screenHeight / 100,
                                  bottom: screenHeight / 100,
                                ),
                                child: const Center(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth / 10),
                          GestureDetector(
                            onTap: () {
                              UserLoginCubit.get(context).deleteMe(
                                token: UserLoginCubit.get(context).loginModel!.refresh_token ?? "",
                              );
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  'Account Deleted',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ));
                              navigateToPage(context, LoginPage());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0.5,
                                    blurRadius: 0.5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: screenWidth / 20,
                                  end: screenWidth / 20,
                                  top: screenHeight / 100,
                                  bottom: screenHeight / 100,
                                ),
                                child: const Center(
                                  child: Text(
                                    "Delete Account",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(top: screenHeight / 200),
              child: Container(
                width: screenWidth / 10,
                height: 2.0,
                color: Colors.black54,
              ),
            ),
          ],
        );
      },
    );
  }
}
