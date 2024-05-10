import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/models/AnotherUserModel.dart';
import 'package:flutter_code/models/LoggedInUserModel.dart';
import 'package:flutter_code/models/LoginModel.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../models/ChatsModel.dart';
import '../../shared/network/endpoints.dart';
import '../../shared/network/remote/dio_helper.dart';

class UserLoginCubit extends Cubit<UserLoginStates> {
  UserLoginCubit() : super(UserLoginInitialState());

  static UserLoginCubit get(context) => BlocProvider.of(context);
  AnotherUser? anotherUser;
  bool isPassword = true;
  IconData suffix = Icons.visibility;

  void changeVisibility() {
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(LoginChangePasswordState());
  }

  bool follow = false;

  void changeFollow() {
    follow = !follow;
    emit(LoginChangeFollowState());
  }

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
      String? accessToken = loginModel?.access_token;
      emit(UserLoginSuccessState());
      return "Logged In Successfully";
      // token validation
      if (accessToken != null && accessToken.isNotEmpty) {
        // Decode the token and check expiry
        Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
        int? expiryTimeInSeconds = decodedToken['exp'];
        if (expiryTimeInSeconds != null) {
          DateTime expiryDateTime =
          DateTime.fromMillisecondsSinceEpoch(expiryTimeInSeconds * 1000);
          if (expiryDateTime.isAfter(DateTime.now())) {
            // Token is valid, proceed with getting user data
            emit(UserLoginSuccessState());
            showToast(text: "Logged in Successfully", state: ToastStates.SUCCESS);
            getLoggedInUserData(token: loginModel!.refresh_token!);
           // return "Logged in Successfully";
          } else {
            // Token has expired
            emit(UserLoginErrorState("Token has expired"));
            showToast(text: "Token has expired", state: ToastStates.ERROR);
           // return "Token has expired";
          }
        } else {
          // Invalid token format
          emit(UserLoginErrorState("Invalid token format"));
          showToast(text: "Invalid token format", state: ToastStates.ERROR);
        //  return "Invalid token format";
        }
      } else {
        // Token is null or empty
        emit(UserLoginErrorState("Token is null or empty"));
        showToast(text: "Token is null or empty", state: ToastStates.ERROR);
       // return "Token is null or empty";
      }
    } catch (error) {
      emit(UserLoginErrorState(error.toString()));
      showToast(text: "Something went Wrong!", state: ToastStates.ERROR);
      return "Something went Wrong!";
    }
  }

  LoggedInUserModel? loggedInUserModel;
  LoggedInUserData? loggedInUserData;
  LoggedInUser? loggedInUser;

  Future<void> getLoggedInUserData({required String? token}) async {
    try {
      print("token in get logged in user: ");
      print(token);
      print("token in get logged in user: ");
      emit(GetLoggedInUserLoadingState());

      var value = await DioHelper.getData(
        url: GET_USER,
        token: token,
      );
      print(value);

      loggedInUserModel = LoggedInUserModel.fromJson(value.data);
      loggedInUserData = loggedInUserModel?.data;
      loggedInUser = loggedInUserData?.doc;
      print("XXXXXXXXXXXXXXXXXXXXX");
      print(loggedInUser.toString());
      print("XXXXXXXXXXXXXXXXXXXXX");
      emit(GetLoggedInUserSuccessState());
    } catch (error) {
      print('Error: $error');

      emit(GetLoggedInUserErrorState(error.toString()));
    }
  }
  
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
        'userName':userName,
        'phone':phone,
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
      for (int i =0;i<chatResponse!.chats.length;i++){
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

  /// --------------------------> make follow using endpoints <------------------
  bool inFollowing({required String? followId}){
    // id bat3 elanother
    for(int i=0;i<loggedInUser!.following.length;i++){
      if(loggedInUser!.following[i]["userId"] == followId){
        print("3amelo follow y3m");
        return true;
      }
    }
    return false;
  }

  Future<void> handleFollow({required String? token , required String? followId}) async {

    try {
      emit(FollowLoadingState());
      var value;

      if(inFollowing(followId: followId) == false){
         value = await DioHelper.patchData(
          url: "/users/${followId}/makefollow",
          token: token,
        );
         emit(FollowSuccessState());
      }else{
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

  int getAnotherUserFollowers(){
    emit(GetAnotherUserFollowersState(anotherUser!.followers.length));
    return (anotherUser!.followers.length);
  }

}
