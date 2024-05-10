import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/layout/VolunHeroUserLayout/layout.dart';
import 'package:flutter_code/modules/GeneralView/Login/Login_Page.dart';
import 'package:flutter_code/modules/GeneralView/OnBoarding/OnBoarding_Page.dart';
import 'package:flutter_code/shared/bloc_observer.dart';
import 'package:flutter_code/shared/components/constants.dart';
import 'package:flutter_code/shared/network/local/CacheHelper.dart';
import 'package:flutter_code/shared/network/remote/dio_helper.dart';
import 'package:flutter_code/src/app_root.dart';

void main() async {
  // ensure that everything in the main method has finished then run MyApp.
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  bool onBoarding = CacheHelper.get(key: 'onBoarding') ?? false;

  userToken = await getUserToken();
  print('User Token: ${userToken}');

  if (onBoarding) {
    if (userToken != null) {
      widget = const VolunHeroUserLayout();
    } else {
      widget = LoginPage();
    }
  } else {
    widget = const OnBoarding();
  }

  runApp(AppRoot(
    onBoarding: onBoarding,
    startWidget: widget,
  ));
}
