import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/CreatePost_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/OrganizationLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/SignUp_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/shared/components/constants.dart';
import 'package:flutter_code/shared/styles/themes.dart';

class AppRoot extends StatelessWidget {
  final bool onBoarding;
  final Widget startWidget;

  const AppRoot({
    super.key,
    required this.onBoarding,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                HomeLayoutCubit()..initializeBottomItems()..getAllPosts(token: userToken ?? "")),
        BlocProvider(
            create: (BuildContext context) =>
                OrganizationLayoutCubit()..initializeBottomItems()),
        BlocProvider(
          create: (BuildContext context) => UserSignUpCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => UserLoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => CreatePostCubit(),
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
