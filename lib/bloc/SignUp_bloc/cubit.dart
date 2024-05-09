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
    File? profilePic,
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
    print("classification: $classification");
    bool attachmentsRequired =
    (classification == "medical" || classification == "educational");


    print(classification);
    if(profilePic!=null){
      String fileName = profilePic.path.split('/').last;
      formData.files.add(MapEntry(
        'profilePic',
        await dio.MultipartFile.fromFile(
          profilePic.path,
          filename: fileName,
        ),
      ));
      print(formData.files);
      print(profilePic.path);
      print(fileName);
    }


    if (attachmentsRequired && attachments != null) {
      String fileName = attachments.path.split('/').last;
      formData.files.add(MapEntry(
        'attachments',
        await dio.MultipartFile.fromFile(
          attachments.path,
          filename: fileName,
        ),
      ));

    }
    else if (attachmentsRequired && attachments == null) {
      showToast(
        text:
        'Attachments are required for medical or educational classifications',
        state: ToastStates.ERROR,
      );
      emit(UserSignUpErrorState(
          "Attachments are required for medical or educational classifications"));
      return;
    }
    print("Att: $attachments" );
    print("prof: $profilePic" );
    print("#######################");
    print(formData.files);
    print("#######################");
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
      print("===============================");
      print(response.data);
      print("===============================");
      emit(UserSignUpSuccessState());
    } catch (error) {
      emit(UserSignUpErrorState(error.toString()));
    }
  }
}