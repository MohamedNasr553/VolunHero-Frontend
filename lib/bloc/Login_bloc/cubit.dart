import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/models/LoginModel.dart';
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

  String loginUser({
    required String email,
    required String password,
  }) {
    Map<String, dynamic> requestData = {
      'email': email,
      'password': password,
    };

    emit(UserLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: requestData,
    ).then((value) {
      print(value.toString());
      loginModel = LoginModel.fromJson(value.data);
      emit(UserLoginSuccessState());
      String? accessToken = loginModel?.access_token;
      Map<String, dynamic> decodedTokenMap = JwtDecoder.decode(accessToken!);
      print("+++++++++++++++++++++++++++++++\n");
      //print(decodedTokenMap.toString());
      //{_id: 662e2849c4ed7f0e0e58eff6, role: User, iat: 1714329692, exp: 1714331492}
      DecodedToken? decodedToken;
      decodedToken = DecodedToken.fromMap(decodedTokenMap);
      print(decodedToken);
      print("+++++++++++++++++++++++++++++++\n");
      return (value.toString());
    }).catchError((error) {
      emit(UserLoginErrorState(error.toString()));
      return (error);
    });
    return "";
  }
}
