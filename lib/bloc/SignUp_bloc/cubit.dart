import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/SignUp_bloc/states.dart';
import 'package:flutter_code/models/SignUpModel.dart';
import 'package:flutter_code/shared/network/endpoints.dart';
import 'package:flutter_code/shared/network/remote/dio_helper.dart';

class UserSignUpCubit extends Cubit<UserSignUpStates> {
  UserSignUpCubit() : super(UserSignUpInitialState());

  static UserSignUpCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility;

  void changeVisibility() {
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(RegisterChangePasswordVisibilityState());
  }

  /// -------------- User Registration ---------------
  SignupModel? signupModel;

  void registerUser({
    required String firstName,
    required String lastName,
    required String dob,
    required String address,
    required String username,
    required String email,
    required String password,
    required String cPassword,
    required String phone,
    required String specification,
    required File? attachments,
    required String classification,
  }) {
    emit(UserSignUpLoadingState());

    // Check if attachments are required
    bool attachmentsRequired = (classification == "medical" || classification == "educational");

    // If attachments are required and not provided
    if (attachmentsRequired && attachments == null) {
      emit(UserSignUpErrorState("Attachments are required for medical or educational classifications"));
      return;
    }

    Map<String, dynamic> requestData = {
      'firstName': firstName,
      'lastName': lastName,
      'dob': dob,
      'address': address,
      'username': username,
      'email': email,
      'password': password,
      'cPassword': cPassword,
      'phone': phone,
      'specification': specification,
    };

    // Add attachments to the request data if provided
    if (attachmentsRequired && attachments != null) {
      requestData['attachments'] = attachments;
    }

    DioHelper.postData(
      url: REGISTER,
      data: requestData,
    ).then((value) {
      signupModel = SignupModel.fromJson(value.data);

      emit(UserSignUpSuccessState());
    }).catchError((error) {
      print(error);
      emit(UserSignUpErrorState(error.toString()));
    });
  }
}
