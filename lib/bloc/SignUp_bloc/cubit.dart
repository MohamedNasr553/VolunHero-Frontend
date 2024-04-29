import 'dart:convert';
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

  // void registerUser({
  //   required String firstName,
  //   required String lastName,
  //   required String DOB,
  //   required String address,
  //   required String userName,
  //   required String email,
  //   required String password,
  //   required String cpassword,
  //   required String phone,
  //   required String specification,
  //   required String classification,
  //   File? attachments,
  // }) {
  //   emit(UserSignUpLoadingState());
  //
  //   Map<String, dynamic> requestData = {
  //     'firstName': firstName,
  //     'lastName': lastName,
  //     'DOB': DOB,
  //     'address': address,
  //     'userName': userName,
  //     'email': email,
  //     'password': password,
  //     'cpassword': cpassword,
  //     'phone': phone,
  //     'specification': specification,
  //   };
  //
  //   bool attachmentsRequired =
  //       (classification == "medical" || classification == "educational");
  //
  //   if (attachmentsRequired && attachments != null) {
  //     // Convert File to List<int> (bytes)
  //     List<int> fileBytes = attachments.readAsBytesSync();
  //     requestData['attachments'] = base64Encode(fileBytes);
  //   }
  //   else if (attachmentsRequired && attachments == null) {
  //     showToast(
  //       text:
  //           'Attachments are required for medical or educational classifications',
  //       state: ToastStates.ERROR,
  //     );
  //     emit(UserSignUpErrorState(
  //         "Attachments are required for medical or educational classifications"));
  //     return;
  //   }
  //
  //   DioHelper.postData(
  //     url: REGISTER,
  //     data: requestData,
  //   ).then((value) {
  //     signupModel = SignupModel.fromJson(value.data);
  //
  //     emit(UserSignUpSuccessState());
  //   }).catchError((error) {
  //     print(error);
  //
  //     emit(UserSignUpErrorState(error.toString()));
  //   });
  // }

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
    File? attachments,
  }) async {
    emit(UserSignUpLoadingState());

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

    bool attachmentsRequired =
        (classification == "medical" || classification == "educational");

    if (attachmentsRequired && attachments != null) {
      String fileName = attachments.path.split('/').last;
      formData.files.add(MapEntry(
        'attachments',
        await dio.MultipartFile.fromFile(
          attachments.path,
          filename: fileName,
        ),
      ));
    } else if (attachmentsRequired && attachments == null) {
      showToast(
        text:
            'Attachments are required for medical or educational classifications',
        state: ToastStates.ERROR,
      );
      emit(UserSignUpErrorState(
          "Attachments are required for medical or educational classifications"));
      return;
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
