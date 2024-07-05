import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/DonationForm_bloc/states.dart';
import 'package:flutter_code/models/AddDonationFormModel.dart';
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

      var request = await DioHelper.postData(
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
}
