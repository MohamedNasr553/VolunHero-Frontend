import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_code/bloc/SignUp_bloc/states.dart';
import 'package:flutter_code/models/SignUpModel.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/network/endpoints.dart';
import 'package:flutter_code/shared/network/remote/dio_helper.dart';

class UserSignUpCubit extends Cubit<UserSignUpStates> {
  UserSignUpCubit() : super(UserSignUpInitialState());

  static UserSignUpCubit get(context) =>
      BlocProvider.of<UserSignUpCubit>(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(RegisterChangePasswordVisibilityState());
  }

  bool isCPassword = true;
  IconData cSuffix = Icons.visibility;

  void changeCPasswordVisibility() {
    isCPassword = !isCPassword;
    cSuffix = isCPassword ? Icons.visibility : Icons.visibility_off;
    emit(RegisterChangeCPasswordVisibilityState());
  }

  SignupModel? signupModel;
  String? _filePath;

  void registerUser({
    required String firstName,
    required String lastName,
    required String DOB,
    required String address,
    required String userName,
    required String email,
    required String password,
    required String cpassword,
    required String phone,
    required String specification,
    required String classification,
    required File? attachments,
  }) async {
    emit(UserSignUpLoadingState());

    if (attachments != null) {
      _filePath = attachments.path;
    }

    dio.FormData formData = dio.FormData();

    formData.fields.addAll([
      MapEntry('firstName', firstName),
      MapEntry('lastName', lastName),
      MapEntry('DOB', DOB),
      MapEntry('address', address),
      MapEntry('userName', userName),
      MapEntry('email', email),
      MapEntry('password', password),
      MapEntry('cpassword', cpassword),
      MapEntry('phone', phone),
      MapEntry('specification', specification),
    ]);

    print(formData.fields);
    print('File path: $_filePath');
    print('File path before adding attachment: $_filePath');

    if (classification == "medical" || classification == "educational") {
      if (_filePath != null) {
        // Add the file to the form data
        String fileName = _filePath!.split('/').last;
        formData.files.add(
          MapEntry(
            'attachments',
            await dio.MultipartFile.fromFile(
              _filePath!,
              filename: fileName,
            ),
          ),
        );

        print('FormData files: ${formData.files}');
      } else {
        // Handle case where attachments are required but not provided
        showToast(
          text: 'Specification attachment is required.',
          state: ToastStates.ERROR,
        );
        emit(
          UserSignUpErrorState(
            "Specification attachment is required.",
          ),
        );
        return;
      }
    }
    try {
      dio.Response response = await DioHelper.dio.post(
        REGISTER,
        data: formData,
        options: dio.Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            // Add any other headers if required
          },
        ),
      );

      signupModel = SignupModel.fromJson(response.data);

      emit(UserSignUpSuccessState());
    } catch (error) {
      print(error);

      emit(UserSignUpErrorState(error.toString()));
    }
  }
}
