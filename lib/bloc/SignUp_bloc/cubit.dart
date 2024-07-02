import 'dart:core';
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

  /// --------------------------------- Sign up --------------------------------
  // SignupModel? signupModel;
  // NewUser? newUser;
  //
  // Future<void> registerUser({
  //   required String firstName,
  //   required String lastName,
  //   required String phone,
  //   required String DOB,
  //   required String address,
  //   required String userName,
  //   required String email,
  //   required String password,
  //   required String cpassword,
  //   required String specification,
  //   required File? profilePic,
  //   required String classification,
  //   required List<File>? attachments,
  // }) async {
  //   emit(UserSignUpLoadingState());
  //
  //   // Create FormData object to hold form fields and files
  //   dio.FormData formData = dio.FormData();
  //
  //   // Add form fields using a list of MapEntry<String, String>
  //   formData.fields.addAll([
  //     MapEntry('firstName', firstName),
  //     MapEntry('lastName', lastName),
  //     MapEntry('userName', userName),
  //     MapEntry('email', email),
  //     MapEntry('password', password),
  //     MapEntry('cpassword', cpassword),
  //     MapEntry('phone', phone),
  //     MapEntry('DOB', DOB),
  //     MapEntry('address', address),
  //     MapEntry('specification', specification),
  //   ]);
  //
  //   // Check if attachments are required and provided
  //   bool attachmentsRequired =
  //   (classification == "Medical" || classification == "Educational");
  //   if (attachmentsRequired && (attachments == null || attachments.isEmpty)) {
  //     emit(UserSignUpErrorState(
  //         "Attachments are required for Medical or Educational specifications."));
  //     return;
  //   }
  //
  //   // Add profile picture file to FormData if provided
  //   if (profilePic != null) {
  //     formData.files.add(
  //       MapEntry(
  //         'profilePic',
  //         await dio.MultipartFile.fromFile(
  //           profilePic.path,
  //           filename: profilePic.path.split('/').last,
  //         ),
  //       ),
  //     );
  //   }
  //
  //   // Add attachments files to FormData if provided
  //   if (attachments != null) {
  //     for (File file in attachments) {
  //       formData.files.add(
  //         MapEntry(
  //           'attachments',
  //           await dio.MultipartFile.fromFile(
  //             file.path,
  //             filename: file.path.split('/').last,
  //           ),
  //         ),
  //       );
  //     }
  //   }
  //
  //   try {
  //     // Print formData fields for debugging
  //     print("---------- Form Data Fields ------------- \n");
  //     formData.fields.forEach((entry) {
  //       print('${entry.key}: ${entry.value}');
  //     });
  //
  //     // Make POST request using Dio with FormData
  //     dio.Response response = await DioHelper.dio.post(
  //       REGISTER,
  //       data: formData,
  //     );
  //
  //     // Handle success response
  //     signupModel = SignupModel.fromJson(response.data);
  //
  //     print('Response: ${response.data}');
  //
  //     emit(UserSignUpSuccessState());
  //   } catch (error) {
  //     emit(UserSignUpErrorState(error.toString()));
  //   }
  // }
  //
  // Future<void> requestPermission() async {
  //   var status = await Permission.storage.request();
  //   if (status.isDenied || status.isPermanentlyDenied) {
  //     showToast(text: "You Should upload file", state: ToastStates.ERROR);
  //   }
  // }
}
