import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/modules/GeneralView/OnBoarding/OnBoarding_Page.dart';
import 'package:flutter_code/shared/bloc_observer.dart';
import 'package:flutter_code/shared/network/remote/dio_helper.dart';
import 'package:flutter_code/src/app_root.dart';

void main() async {
  // ensure that everything in the main method has finished then run MyApp.
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  // Widget widget;
  // bool onBoarding = CacheHelper.get(key: 'onBoarding') ?? false;

  // userToken = await getUserToken();
  // print(userToken);

  // if (onBoarding) {
  //   if (userToken != null) {
  //     widget = const VolunHeroUserLayout();
  //   } else {
  //     widget = LoginPage();
  //   }
  // } else {
  //   widget = const OnBoarding();
  // }

  runApp(const AppRoot(
    // onBoarding: onBoarding,
    startWidget: OnBoarding(),
  ));
}
