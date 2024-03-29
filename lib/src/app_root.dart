import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/layout_bloc/cubit.dart';
import 'package:flutter_code/layout/VolunHeroLayout/layout.dart';
import 'package:flutter_code/modules/AllQuestions/AllQuestions_Page.dart';
import 'package:flutter_code/modules/CreatePost/CreatePost_Page.dart';
import 'package:flutter_code/modules/EditProfile/editProfile_Page.dart';
import 'package:flutter_code/modules/Education/Education_Page.dart';
import 'package:flutter_code/modules/ForgetPassword/ForgetPassword_Page.dart';
import 'package:flutter_code/modules/GetSupport/Support_Page.dart';
import 'package:flutter_code/modules/HomePage/homePage.dart';
import 'package:flutter_code/modules/Login/Login_Page.dart';
import 'package:flutter_code/modules/MedicalHelp/MedicalHelp_Page.dart';
import 'package:flutter_code/modules/Notifications/Notifications_Page.dart';
import 'package:flutter_code/modules/OnBoarding/OnBoarding_Page.dart';
import 'package:flutter_code/modules/ResetPassword/ResetPassword_Page.dart';
import 'package:flutter_code/modules/SavedPost/Saved_Posts.dart';
import 'package:flutter_code/modules/SignUp/SignUp_Page.dart';
import 'package:flutter_code/shared/styles/themes.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => HomeLayoutCubit()
            ..initializeBottomItems()
            ..homeLayoutScreens(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: SavedPosts(),
      ),
    );
  }
}
