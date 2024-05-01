import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/OrganizationLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/SignUp_bloc/cubit.dart';
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
import 'package:flutter_code/modules/OrganizationView/AllDonationFormPage/AllForms.dart';
import 'package:flutter_code/modules/OrganizationView/UpdateDonationForm/updateForm.dart';
import 'package:flutter_code/modules/UserView/UserEditProfile/editProfile_Page.dart';
import 'package:flutter_code/modules/UserView/UserSignUp/User_SignUp_Page.dart';
import 'package:flutter_code/shared/styles/themes.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                HomeLayoutCubit()..initializeBottomItems()),
        BlocProvider(
            create: (BuildContext context) =>
                OrganizationLayoutCubit()..initializeBottomItems()),
        BlocProvider(
          create: (BuildContext context) => UserSignUpCubit(),
        ),
        BlocProvider(create: (BuildContext context) => UserLoginCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: LoginPage(),
      ),
    );
  }
}
