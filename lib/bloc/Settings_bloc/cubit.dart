import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Settings_bloc/states.dart';
import 'package:flutter_code/models/updatePasswordModel.dart';
import 'package:flutter_code/shared/network/remote/dio_helper.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingsInitialState());

  static SettingsCubit get(context) => BlocProvider.of(context);

  /// ----------------------- Update Password API ------------------------
  UpdatePassword? updatePassword;
  UserInfo? userInfo;

  void updateUserPassword({
    required String currentPassword,
    required String newPassword,
    required String token,
  }) async {
    emit(UpdatePasswordLoadingState());

    try {
      final response = await DioHelper.patchData(
        url: "/users/updatePassword",
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
        token: token,
      );
      updatePassword = UpdatePassword.fromJson(response.data);
      print(response.toString());

      emit(UpdatePasswordSuccessState());
    } catch (error) {
      print(error.toString());

      emit(UpdatePasswordErrorState());
    }
  }
}