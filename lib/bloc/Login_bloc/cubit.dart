import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/models/AnotherUserModel.dart';
import 'package:flutter_code/models/LoggedInUserModel.dart';
import 'package:flutter_code/models/LoginModel.dart';
import 'package:flutter_code/shared/components/components.dart';
import '../../models/ChatsModel.dart';
import '../../shared/network/endpoints.dart';
import '../../shared/network/remote/dio_helper.dart';

class UserLoginCubit extends Cubit<UserLoginStates> {
  UserLoginCubit() : super(UserLoginInitialState());

  static UserLoginCubit get(context) => BlocProvider.of(context);

  // -------------------- Password Visibility ---------------------
  bool isPassword = true;
  IconData suffix = Icons.visibility;

  void changeVisibility() {
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(LoginChangePasswordState());
  }

  // ----------------------------- Login ---------------------------
  DecodedToken? decodedToken;
  LoginModel? loginModel;

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    Map<String, dynamic> requestData = {
      'email': email,
      'password': password,
    };

    try {
      emit(UserLoginLoadingState());
      var value = await DioHelper.postData(
        url: LOGIN,
        data: requestData,
      );
      print(value.toString());

      loginModel = LoginModel.fromJson(value.data);

      print(loginModel?.refresh_token);
      emit(UserLoginSuccessState());
      showToast(text: "Logged In Successfully", state: ToastStates.SUCCESS);
      return "Logged In Successfully";
    } catch (error) {
      emit(UserLoginErrorState(error.toString()));
      showToast(
          text: "Email Address or Password is not correct!",
          state: ToastStates.ERROR);
      return "Something went Wrong!";
    }
  }

  // ------------------------- Get User Data -----------------------
  LoggedInUserModel? loggedInUserModel;
  LoggedInUserData? loggedInUserData;
  LoggedInUser? loggedInUser;

  Future<void> getLoggedInUserData({required String? token}) async {
    try {
      if (token == null) {
        emit(GetLoggedInUserErrorState("Token is null"));
        return;
      }

      emit(GetLoggedInUserLoadingState());
      var value = await DioHelper.getData(
        url: GET_USER,
        token: token,
      );
      print(value);
      loggedInUserModel = LoggedInUserModel.fromJson(value.data);
      loggedInUserData = loggedInUserModel!.data;
      loggedInUser = loggedInUserData!.doc;

      emit(GetLoggedInUserSuccessState());
    } catch (error) {
      print('Error: $error');

      emit(GetLoggedInUserErrorState(error.toString()));
    }
  }

  // ------------------------ Update User Data ---------------------
  Future<void> updateLoggedInUserData({
    required String token,
    required String firstName,
    required String lastName,
    required String userName,
    required String phone,
    required String address,
  }) async {
    try {
      emit(UpdateLoggedInUserLoadingState());
      Map<String, dynamic> requestData = {
        'firstName': firstName,
        'lastName': lastName,
        'userName': userName,
        'phone': phone,
        'address': address,
      };
      print(requestData.toString());

      var value = await DioHelper.patchData(
        url: UPDATE_USER,
        token: token,
        data: requestData,
      );

      print(value);
      emit(UpdateLoggedInUserSuccessState());
    } catch (error) {
      emit(UpdateLoggedInUserErrorState(error.toString()));
      print('Error updating user data: $error');
    }
  }

  // ------------------------- Get All Chats ------------------------
  ChatResponse? chatResponse;
  List<Chat> chats = [];

  Future<String> getLoggedInChats() async {
    try {
      emit(GetLoggedInUserChatsLoadingState());

      var value = await DioHelper.getData(
        url: GET_CHATS,
      );

      emit(GetLoggedInUserChatsSuccessState());
      chatResponse = ChatResponse.fromJson(value.data);
      for (int i = 0; i < chatResponse!.chats.length; i++) {
        chats.add(chatResponse!.chats[i]);
      }
      print("Chat Response => ");
      print(chatResponse);
      print("Chats: ");
      print(chats);
    } catch (error) {
      emit(GetLoggedInUserChatsErrorState(error.toString()));
      print(error.toString());
    }
    return "";
  }

  // --------------------------> Make follow using endpoints <------------------
  AnotherUser? anotherUser;

  bool inFollowing({required String? followId}) {
    // id bat3 elanother
    for (int i = 0; i < loggedInUser!.following.length; i++) {
      if (loggedInUser!.following[i]["userId"] == followId) {
        print("3amelo follow y3m");
        return true;
      }
    }
    return false;
  }

  Future<void> handleFollow(
      {required String? token, required String? followId}) async {
    try {
      emit(FollowLoadingState());
      var value;

      if (inFollowing(followId: followId) == false) {
        value = await DioHelper.patchData(
          url: "/users/${followId}/makefollow",
          token: token,
        );
        emit(FollowSuccessState());
      } else {
        value = await DioHelper.patchData(
          url: "/users/${followId}/makeunfollow",
          token: token,
        );
        emit(UnFollowSuccessState());
      }
      print("message el follow");
      print(value.data["message"] == "success");
      print(inFollowing(followId: followId));
      print("message el follow");
    } catch (error) {
      emit(FollowErrorState());
      print('Error: $error');
    }
  }

  int getAnotherUserFollowers() {
    emit(GetAnotherUserFollowersState(anotherUser!.followers.length));
    return (anotherUser!.followers.length);
  }

  bool follow = false;

  void changeFollow() {
    follow = !follow;
    emit(LoginChangeFollowState());
  }
}
