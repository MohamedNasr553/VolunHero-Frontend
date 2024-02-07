import 'package:flutter/material.dart';
import 'package:flutter_code/layout/homePage/homepage.dart';
import 'package:flutter_code/modules/EditProfile/editProfile_Page.dart';
import 'package:flutter_code/modules/ForgetPassword/ForgetPassword_Page.dart';
import 'package:flutter_code/modules/GetSupport/Support_Page.dart';
import 'package:flutter_code/modules/Login/Login_Page.dart';
import 'package:flutter_code/modules/Notifications/Notifications_Page.dart';
import 'package:flutter_code/modules/OnBoarding/OnBoarding_Page.dart';
import 'package:flutter_code/modules/ResetPassword/ResetPassword_Page.dart';
import 'package:flutter_code/modules/SignUp/SignUp_Page.dart';
import 'package:flutter_code/shared/styles/themes.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: NotificationPage(),
    );
  }
}