import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/CreatePost_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Settings_bloc/cubit.dart';
import 'package:flutter_code/bloc/SignUp_bloc/cubit.dart';
import 'package:flutter_code/bloc/Layout_bloc/cubit.dart';
import 'package:flutter_code/bloc/SupportCalls_bloc/cubit.dart';
import 'package:flutter_code/bloc/savedPosts_bloc/cubit.dart';
import 'package:flutter_code/shared/styles/themes.dart';

class AppRoot extends StatelessWidget {
  //  final bool onBoarding;
  final Widget startWidget;

  const AppRoot({
    super.key,
    //  required this.onBoarding,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => UserSignUpCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => UserLoginCubit(),
        ),
        BlocProvider(
            create: (BuildContext context) => HomeLayoutCubit()
              ..initializeUserBottomItems(context)
              ..initializeOrganizationBottomItems(context)
              ..getAllPosts(
                  token:
                      UserLoginCubit.get(context).loginModel!.refresh_token ??
                          "")),
        BlocProvider(
          create: (BuildContext context) => CreatePostCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => SavedPostsCubit()
            ..getAllSavedPosts(
                token: UserLoginCubit.get(context).loginModel!.refresh_token ??
                    ""),
        ),
        BlocProvider(
          create: (BuildContext context) => SettingsCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => SupportCallsCubit()
            ..getAllEducationalUsers(
                token:
                    UserLoginCubit.get(context).loginModel!.refresh_token ?? "")
            ..getAllMedicalUsers(
                token:
                    UserLoginCubit.get(context).loginModel!.refresh_token ?? "")
            ..getAllGeneralUsers(
                token: UserLoginCubit.get(context).loginModel!.refresh_token ??
                    ""),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startWidget,
      ),
    );
  }
}
