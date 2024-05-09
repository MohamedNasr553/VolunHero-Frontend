import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/AnotherUser_bloc/states.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/shared/network/remote/dio_helper.dart';


class AnotherUserCubit extends Cubit<AnotherUserStates> {
  AnotherUserCubit() : super(AnotherUserInitialState());
  static AnotherUserCubit get(context) => BlocProvider.of(context);





}
