import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/models/LoggedInUserModel.dart';
import 'package:flutter_code/models/LoginModel.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../shared/network/endpoints.dart';
import '../../shared/network/remote/dio_helper.dart';

class UserLoginCubit extends Cubit<UserLoginStates> {
  UserLoginCubit() : super(UserLoginInitialState());

  static UserLoginCubit get(context) => BlocProvider.of(context);

  DecodedToken? decodedToken;
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
      print(loginModel?.refresh_token);
      emit(UserLoginSuccessState());
      String? accessToken = loginModel?.access_token;
      Map<String, dynamic> decodedTokenMap = JwtDecoder.decode(accessToken!);
      print("+++++++++++++++++++++++++++++++\n");

      decodedToken = DecodedToken.fromMap(decodedTokenMap);
      print(decodedToken.toString());
      print(decodedToken!.id);
      print("+++++++++++++++++++++++++++++++\n");
      showToast(text: "Logged in Successfully", state: ToastStates.SUCCESS);
      //getLoggedInUserData(token: loginModel!.refresh_token!);
      //getLoggedInUserData(token: loginModel!.refresh_token!);
      return "Logged in Successfully";
    } catch (error) {
      emit(UserLoginErrorState(error.toString()));
      showToast(text: "Something went Wrong!", state: ToastStates.ERROR);
      return "Something went Wrong!";
    }
  }

  LoggedInUserModel? loggedInUserModel;
  LoggedInUserData? loggedInUserData;
  LoggedInUser? loggedInUser;

  Future<String> getLoggedInUserData({required String token}) async {
    try {
      emit(GetLoggedInUserLoadingState());

      var value = await DioHelper.getData(
        url: GET_USER,
        token: token,
      );

      print(value);
      emit(GetLoggedInUserSuccessState());
      loggedInUser = LoggedInUser.fromJson(value.data['data']['doc']);

      print(loggedInUser.toString());
    } catch (error) {
      emit(GetLoggedInUserErrorState(error.toString()));
      print(error.toString());
    }
    return "";
  }

  Future<void> updateLoggedInUserData({
    required String token,
    required String firstName,
    required String lastName,
    required String userName,
    required String phone,
    required String address,
  }) async {
    try {
      emit(UpdateLoggedInUserLoadingState());
      Map<String, dynamic> requestData = {
        'firstName': firstName,
        'lastName': lastName,
        'userName':userName,
        'phone':phone,
        'address': address,
      };
      print(requestData.toString());

      var value = await DioHelper.patchData(
        url: UPDATE_USER,
        token: token,
        data: requestData,
      );

      print(value);
      emit(UpdateLoggedInUserSuccessState());
    } catch (error) {
      emit(UpdateLoggedInUserErrorState(error.toString()));
      print('Error updating user data: $error');
    }
  }
}
