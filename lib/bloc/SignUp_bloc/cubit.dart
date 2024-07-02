import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:mime/mime.dart';
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
      MapEntry('firstName', firstName),//
      MapEntry('lastName', lastName),//
      MapEntry('userName', userName),//
      MapEntry('email', email),//
      MapEntry('password', password),//
      MapEntry('cpassword', cpassword),//
      MapEntry('phone', phone),//
      MapEntry('DOB', DOB),//
      MapEntry('address', address),//
      MapEntry('specification', specification),//
    ]);

    bool attachmentsRequired =
    (classification == "Medical" || classification == "Educational");
    print((profilePic==null));
    if (profilePic != null) {
      formData.files.add(
        MapEntry(
          'profilePic',
          await MultipartFile.fromFile(
            profilePic.path,
            filename: profilePic.path.split('/').last,
          ),
        ),
      );
    }


    // if (attachmentsRequired && attachments != null && attachments.isNotEmpty) {
    //   for (var file in attachments) {
    //     String fileName = file.path.split('/').last;
    //     formData.files.add(MapEntry(
    //       'attachments',
    //       await dio.MultipartFile.fromFile(
    //         file.path,
    //         filename: fileName,
    //       ),
    //     ));
    //   }
    //   emit(UserSignUpAttachmentState());
    // } else if (attachmentsRequired && (attachments == null || attachments.isEmpty)) {
    //   showToast(
    //     text: 'Attachments are required for medical or educational classifications',
    //     state: ToastStates.ERROR,
    //   );
    //   emit(UserSignUpErrorState("Attachments are required for medical or educational classifications"));
    //   return;
    // }

    try {
      for (int i=0;i<formData.fields.length;i++){
        print(formData.fields[i]);
      }
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


  Future<void> registerUserUsingHTTP({
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

    var request = http.MultipartRequest('POST', Uri.parse("https://volunhero.onrender.com/api/auth/signUp"));
    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields.addAll({
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'password': password,
      'cpassword': cpassword,
      'phone': phone,
      'DOB': DOB,
      'address': address,
      'specification': specification,
    });

    bool attachmentsRequired =
    (classification == "Medical" || classification == "Educational");

    if (profilePic != null) {
      var picStream = http.ByteStream(profilePic.openRead());
      var picLength = await profilePic.length();
      var picMultipartFile = http.MultipartFile(
        'profilePic',
        picStream,
        picLength,
        filename: profilePic.path.split('/').last,
      );
      request.files.add(picMultipartFile);
    }

    // Handle attachments if required
    // if (attachmentsRequired && attachments != null && attachments.isNotEmpty) {
    //   for (var file in attachments) {
    //     var fileStream = http.ByteStream(file.openRead());
    //     var fileLength = await file.length();
    //     var multipartFile = http.MultipartFile(
    //       'attachments',
    //       fileStream,
    //       fileLength,
    //       filename: file.path.split('/').last,
    //     );
    //     request.files.add(multipartFile);
    //   }
    // } else if (attachmentsRequired && (attachments == null || attachments.isEmpty)) {
    //   showToast(
    //     text: 'Attachments are required for medical or educational classifications',
    //     state: ToastStates.ERROR,
    //   );
    //   emit(UserSignUpErrorState("Attachments are required for medical or educational classifications"));
    //   return;
    // }

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        signupModel = SignupModel.fromJson(jsonDecode(response.body));
        emit(UserSignUpSuccessState());
      } else {
        print(response.reasonPhrase.toString());
        emit(UserSignUpErrorState('Failed to register user: ${response.reasonPhrase}'));
      }
    } catch (error) {
      print("Error: ");
      print(error.toString());
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