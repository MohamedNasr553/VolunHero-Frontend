import 'package:flutter/material.dart';
import 'package:flutter_code/layout/homePage/homepage.dart';
import 'package:flutter_code/modules/OnBoarding/OnBoarding_Page.dart';
import 'package:flutter_code/modules/ResetPassword/ResetPassword_Page.dart';
import 'package:flutter_code/shared/styles/themes.dart';

import '../modules/ForgetPassword/ForgetPassword_Page.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home:  ResetPassword(),
    );
  }
}