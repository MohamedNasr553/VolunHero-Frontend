import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_code/bloc/SignUp_bloc/states.dart';
import 'package:flutter_code/models/SignUpModel.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/network/endpoints.dart';
import 'package:flutter_code/shared/network/remote/dio_helper.dart';
import 'package:permission_handler/permission_handler.dart';

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
  Future<void> registerUser({
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
    List<File>? attachments,
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
    print("Attachmentss");
    for(int i=0;i<attachments!.length;i++){
      print(attachments?[i].toString());
    }
    bool attachmentsRequired =
    (classification == "medical" || classification == "educational");

    if (profilePic != null) {
      String fileName = profilePic.path.split('/').last;
      formData.files.add(MapEntry(
        'profilePic',
        await dio.MultipartFile.fromFile(
          profilePic.path,
          filename: fileName,
        ),
      ));
      emit(UserSignUpProfileState());
    }

    if (attachmentsRequired && attachments != null && attachments.isNotEmpty) {
      for (var file in attachments) {
        String fileName = file.path.split('/').last;
        formData.files.add(MapEntry(
          'attachments',
          await dio.MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        ));
      }
      emit(UserSignUpAttachmentState());
    } else if (attachmentsRequired && (attachments == null || attachments.isEmpty)) {
      showToast(
        text: 'Attachments are required for medical or educational classifications',
        state: ToastStates.ERROR,
      );
      emit(UserSignUpErrorState("Attachments are required for medical or educational classifications"));
      return;
    }

    try {
      dio.Response response = await DioHelper.dio.post(
        REGISTER,
        data: formData,
        options: dio.Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      signupModel = SignupModel.fromJson(response.data);
      emit(UserSignUpSuccessState());
    } catch (error) {
      emit(UserSignUpErrorState(error.toString()));
    }
  }

  Future<void> requestPermission() async {
    var status = await Permission.storage.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      showToast(text: "You Should upload file", state: ToastStates.ERROR);
    }
  }
}