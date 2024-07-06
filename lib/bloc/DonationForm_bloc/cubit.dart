import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/DonationForm_bloc/states.dart';
import 'package:flutter_code/models/AddDonationFormModel.dart';
import 'package:flutter_code/models/GetAllDonationFormsModel.dart';
import 'package:flutter_code/shared/network/remote/dio_helper.dart';

class DonationFormCubit extends Cubit<DonationFormStates> {
  DonationFormCubit() : super(DonationFormInitialState());

  static DonationFormCubit get(context) => BlocProvider.of(context);

  // ----------------------- Add Donation Form -------------------------------
  AddDonationFormModel? addDonationFormModel;
  AddDonationForm? addDonationForm;

  void addDonationFormMethod({
    required String title,
    required DateTime? endDate,
    required String description,
    required String donationLink,
    required String token,
  }) async {
    try {
      emit(AddDonationFormLoadingState());

      Map<String, dynamic> requestData = {
        'title': title,
        'endDate': endDate?.toIso8601String(),
        'description': description,
        'donationLink': donationLink,
      };

      print('Request Data: $requestData');

      await DioHelper.postData(
        url: "/donationForm/",
        data: requestData,
        token: token,
      );

      emit(AddDonationFormSuccessState());
    } catch (error) {
      print(error.toString());
      emit(AddDonationFormErrorState());
    }
  }

  // -------------------------- Get All Donation Form ------------------------
  GetAllDonationFormsResponse? getAllDonationFormsResponse;
  DonationFormDetails? donationFormDetails;

  void getAllDonationForms({
    required String token,
  }) async {
    emit(GetAllDonationFormLoadingState());

    DioHelper.getData(
      url: "/donationForm/",
      token: token,
    ).then((value) {
      getAllDonationFormsResponse =
          GetAllDonationFormsResponse.fromJson(value.data);
      emit(GetAllDonationFormSuccessState());
    }).catchError((error) {
      emit(GetAllDonationFormErrorState());
    });
  }
  /// ----------------------- Delete Donation Form  -----------------------
  void deleteDonationForm({
    required String token,
    required String formId,
  }) {
    emit(DeleteDonationFormLoadingState());

    DioHelper.deleteData(
      url: "/donationForm/$formId",
      token: token,
    ).then((value) {
      emit(DeleteDonationFormSuccessState());

      getAllDonationForms(token: token);
      // getOwnerPosts(token: token);
      // getPostId(token: token, postId: postId);
    }).catchError((error) {
      emit(DeleteDonationFormErrorState());
    });
  }
}
