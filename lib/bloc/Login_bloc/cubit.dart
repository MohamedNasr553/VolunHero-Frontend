import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/models/LoginModel.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../shared/network/endpoints.dart';
import '../../shared/network/remote/dio_helper.dart';

class UserLoginCubit extends Cubit<UserLoginStates> {
  UserLoginCubit() : super(UserLoginInitialState());

  static UserLoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  bool isPassword = true;
  IconData suffix = Icons.visibility;

  void changeVisibility() {
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(LoginChangePasswordState());
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    Map<String, dynamic> requestData = {
      'email': email,
      'password': password,
    };

    try {
      emit(UserLoginLoadingState());
      var value = await DioHelper.postData(
        url: LOGIN,
        data: requestData,
      );

      print(value.toString());
      loginModel = LoginModel.fromJson(value.data);
      emit(UserLoginSuccessState());
      String? accessToken = loginModel?.access_token;
      Map<String, dynamic> decodedTokenMap = JwtDecoder.decode(accessToken!);
      print("+++++++++++++++++++++++++++++++\n");
      DecodedToken? decodedToken;
      decodedToken = DecodedToken.fromMap(decodedTokenMap);
      print(decodedToken.toString());
      print("+++++++++++++++++++++++++++++++\n");
      showToast(text: "Logged in Successfully", state: ToastStates.SUCCESS);

      return "Logged in Successfully";
    } catch (error) {
      emit(UserLoginErrorState(error.toString()));
      showToast(text: "Something went Wrong!", state: ToastStates.ERROR);
      return "Something went Wrong!";
    }
  }

}
