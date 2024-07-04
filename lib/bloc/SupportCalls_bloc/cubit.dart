import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/SupportCalls_bloc/states.dart';
import 'package:flutter_code/bloc/savedPosts_bloc/states.dart';
import 'package:flutter_code/models/getAllSavedPostsModel.dart';
import 'package:flutter_code/models/getUsersSupportCalls.dart';
import 'package:flutter_code/shared/network/endpoints.dart';
import 'package:flutter_code/shared/network/remote/dio_helper.dart';

class SupportCallsCubit extends Cubit<SupportCallsStates> {
  SupportCallsCubit() : super(SupportCallsInitialState());

  static SupportCallsCubit get(context) => BlocProvider.of(context);

  /// --------------------- Get All General Users ---------------------------
  SupportCallsUserModel? generalSupportCallsUserModel;
  SupportCallsUserDetails? generalSupportCallsUserDetails;

  Future<void> getAllGeneralUsers({required String token}) async {
    emit(GetAllGeneralLoadingState());

    try {
      final response = await DioHelper.getData(
        url: GENERAL_USERS,
        token: token,
      );

      // Log API response
      print("API Response Status Code: ${response.statusCode}");
      print("API Response Data: ${response.data}");

      if (response.statusCode == 200) {
        generalSupportCallsUserModel = SupportCallsUserModel.fromJson(response.data);

        if (generalSupportCallsUserModel != null &&
            generalSupportCallsUserModel!.users.isNotEmpty) {
          generalSupportCallsUserDetails = generalSupportCallsUserModel!.users[0];

          emit(GetAllGeneralSuccessState());
        } else {
          print("Empty user list or model is null.");
          emit(GetAllGeneralErrorState());
        }
      } else {
        print("Unexpected status code: ${response.statusCode}");
        emit(GetAllGeneralErrorState());
      }
    } catch (error) {
      print("Error fetching General Users: $error");
      emit(GetAllGeneralErrorState());
    }
  }


  /// --------------------- Get All Medical Users ---------------------------
  SupportCallsUserModel? medicalSupportCallsUserModel;
  SupportCallsUserDetails? medicalSupportCallsUserDetails;

  Future<void> getAllMedicalUsers({required String token}) async {
    emit(GetAllMedicalLoadingState());

    try {
      final response = await DioHelper.getData(
        url: MEDICAL_USERS,
        token: token,
      );

      // API response
      print("API Response: ${response.data.toString()}");

      // Parse the API response
      medicalSupportCallsUserModel =
          SupportCallsUserModel.fromJson(response.data);

      if (medicalSupportCallsUserModel != null &&
          medicalSupportCallsUserModel!.users.isNotEmpty) {
        medicalSupportCallsUserDetails = medicalSupportCallsUserModel!.users[0];

        emit(GetAllMedicalSuccessState());
      }
    } catch (error) {
      print("Error fetching Medical Users: $error");

      emit(GetAllMedicalErrorState());
    }
  }

  /// --------------------- Get All Educational Users ---------------------------
  SupportCallsUserModel? educationalSupportCallsUserModel;
  SupportCallsUserDetails? educationalSupportCallsUserDetails;

  Future<void> getAllEducationalUsers({required String token}) async {
    emit(GetAllEducationalLoadingState());

    try {
      final response = await DioHelper.getData(
        url: EDUCATIONAL_USERS,
        token: token,
      );

      // API response
      print("API Response: ${response.data.toString()}");

      // Parse the API response
      educationalSupportCallsUserModel =
          SupportCallsUserModel.fromJson(response.data);

      if (educationalSupportCallsUserModel != null &&
          educationalSupportCallsUserModel!.users.isNotEmpty) {
        educationalSupportCallsUserDetails =
            educationalSupportCallsUserModel!.users[0];

        emit(GetAllEducationalSuccessState());
      }
    } catch (error) {
      print("Error fetching Educational Users: $error");

      emit(GetAllEducationalErrorState());
    }
  }
}
