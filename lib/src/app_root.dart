import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/OrganizationLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/layout/VolunHeroOrganizationLayout/layout.dart';
import 'package:flutter_code/layout/VolunHeroUserLayout/layout.dart';
import 'package:flutter_code/modules/GeneralView/AllQuestions/AllQuestions_Page.dart';
import 'package:flutter_code/modules/GeneralView/CreatePost/CreatePost_Page.dart';
import 'package:flutter_code/modules/GeneralView/Education/Education_Page.dart';
import 'package:flutter_code/modules/GeneralView/ForgetPassword/ForgetPassword_Page.dart';
import 'package:flutter_code/modules/GeneralView/GetSupport/Support_Page.dart';
import 'package:flutter_code/modules/GeneralView/Login/Login_Page.dart';
import 'package:flutter_code/modules/GeneralView/MedicalHelp/MedicalHelp_Page.dart';
import 'package:flutter_code/modules/GeneralView/OnBoarding/OnBoarding_Page.dart';
import 'package:flutter_code/modules/GeneralView/OnBoarding2/OnBoarding2_Page.dart';
import 'package:flutter_code/modules/GeneralView/ResetPassword/ResetPassword_Page.dart';
import 'package:flutter_code/modules/GeneralView/Settings/settingsPage.dart';
import 'package:flutter_code/modules/GeneralView/Settings/yourAccountScreen.dart';
import 'package:flutter_code/modules/UserView/UserChats/UserChatPage.dart';
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
        BlocProvider(
          create: (BuildContext context) => HomeOrganizationLayoutCubit()
            ..initializeBottomItems()
            ..homeLayoutScreens(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: const VolunHeroOrganizationLayout(),
      ),
    );
  }
}
