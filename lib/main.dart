import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/shared/bloc_observer.dart';
import 'package:flutter_code/shared/network/local/CacheHelper.dart';
import 'package:flutter_code/shared/network/remote/dio_helper.dart';
import 'package:flutter_code/src/app_root.dart';

void main() async {
  // ensure that everything in the main method has finished then run MyApp.
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  runApp(const AppRoot());
}