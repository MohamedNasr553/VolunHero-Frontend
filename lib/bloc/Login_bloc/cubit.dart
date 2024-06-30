import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/models/AnotherUserModel.dart';
import 'package:flutter_code/models/LoggedInUserModel.dart';
import 'package:flutter_code/models/LoginModel.dart';
import 'package:flutter_code/models/NotificationsModel.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import '../../models/AnotherUserPostsModel.dart';
import '../../models/ChatsModel.dart';
import '../../shared/network/endpoints.dart';
import '../../shared/network/remote/dio_helper.dart';

class UserLoginCubit extends Cubit<UserLoginStates> {
  UserLoginCubit() : super(UserLoginInitialState());

  static UserLoginCubit get(context) => BlocProvider.of(context);

  // ------------------------- Password Visibility ----------------------------
  bool isPassword = true;
  IconData suffix = Icons.visibility;

  void changeVisibility() {
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(LoginChangePasswordState());
  }

  // --------------------------------- Login ----------------------------------
  DecodedToken? decodedToken;
  LoginModel? loginModel;

  Future<String> loginUser({
    required String email,
    required String password,
    required BuildContext context,
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

      loginModel = LoginModel.fromJson(value.data);

      emit(UserLoginSuccessState());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: defaultColor,
          content: Text(
            'Logged In Successfully',
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
        ),
      );
      return "Logged In Successfully";
    } catch (error) {
      emit(UserLoginErrorState(error.toString()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Email Address or Password is not correct',
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
        ),
      );
      return "Something went Wrong!";
    }
  }

  // -------------------------------- Get User --------------------------------
  LoggedInUserModel? loggedInUserModel;
  LoggedInUserData? loggedInUserData;
  LoggedInUser? loggedInUser;

  Future<void> getLoggedInUserData({required String? token}) async {
    try {
      emit(GetLoggedInUserLoadingState());

      var value = await DioHelper.getData(
        url: GET_USER,
        token: token,
      );

      loggedInUserModel = LoggedInUserModel.fromJson(value.data);
      loggedInUserData = loggedInUserModel?.data;
      loggedInUser = loggedInUserData?.doc;

      emit(GetLoggedInUserSuccessState());
    } catch (error) {

      emit(GetLoggedInUserErrorState(error.toString()));
    }
  }

  // ------------------------------ Update User -------------------------------
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


      emit(UpdateLoggedInUserSuccessState());
    } catch (error) {
      emit(UpdateLoggedInUserErrorState(error.toString()));
    }
  }

  // --------------------------------- Chats ----------------------------------

  void refreshChatPage(String chatId)async{
    emit(RefreshMessagesLoadingState());
    getLoggedInChats(token: loginModel!.refresh_token).then((value) {
      List<Chat> userChat = chats;
      for(int i=0;i<userChat.length;i++){
        if(userChat[i].id == chatId){
          selectedChat = userChat[i];
          getLoggedInChats(token: loginModel!.refresh_token);
          emit(RefreshMessagesSuccessState());
        }
      }
    });
  }


  Future<String> createChat({

    required String secondId,

  }) async {
    Map<String, dynamic> requestData = {
      'secondId': secondId
    };

    try {
      emit(CreateChatLoadingState());

    } catch (error) {
      emit(CreateChatErrorState(error.toString()));
      return "Failed to create chat: $error";
    }
    return "function return";
  }





  Future<String> sendMessage({
    required String chatId,
    required String senderId,
    required String text,
    required String token,
    required Chat? chat
  }) async {
    Map<String, dynamic> requestData = {
      'chatId': chatId,
      'senderId': senderId,
      'text': text,
    };
    print(text);
    print(chatId);
    print(senderId);

    try {
      emit(CreateMessageLoadingState());
      var response = await DioHelper.postData(
          url: CREATE_MSG,
          data: requestData,
          token: token
      ).then((value) async {
      emit(CreateMessageSuccessState());
      });

      // Assuming DioHelper.postData returns the response directly
      print("this is response of msg");
      print(response.data);
      print("this is response of msg");
      // After sending the message successfully, refresh the chat page

      return "Message sent successfully";
    } catch (error) {
      emit(CreateMessageErrorState(error.toString()));
      return "Failed to send message: $error";
    }
  }



  ChatResponse? chatResponse;
  List<Chat> chats = [];
  Chat? selectedChat;
  Future<String> getLoggedInChats({required String? token}) async {
    try {
      emit(GetLoggedInUserChatsLoadingState());
      DioHelper.getData(
        url: GET_CHATS,
        token: token,
      ).then((value) {
     //  print(value.data);
        chatResponse = ChatResponse.fromJson(value.data);
        chats = chatResponse!.chats;
       print(chatResponse);
        for(int i=0;i<chats.length;i++){
          DioHelper.getData(
              url:GET_CHAT_MSGS+chats[i].id,
              token: token
          ).then((value) {
       //     print(i);
        //    print("   ");
        //    print(value.data);
             MessageResponse messageResponse = MessageResponse.fromJson(value.data);
             chats[i].messages = messageResponse.messages;
          //   print(chats[i].messages);
          });
        }
         emit(GetLoggedInUserChatsSuccessState());
      }).catchError((error) {
        emit(GetLoggedInUserChatsErrorState(error.toString()));
      });

    } catch (error) {
      emit(GetLoggedInUserChatsErrorState(error.toString()));
    }
    return "";
  }


  List<Chat> filteredChats = [];
  final StreamController<List<Chat>> _filteredChatsController = StreamController<List<Chat>>.broadcast();

  Stream<List<Chat>> get filteredChatsStream => _filteredChatsController.stream;



  List<Chat> getChatsBySearch(String searchChat) {
    filteredChats = [];
    emit(GetSearchChatLoadingState());

    for (int i = 0; i < chats.length; i++) {
      bool isMatch = false;
      if (chats[i].members[0].userId.id != loggedInUser!.id) {
        isMatch = chats[i].members[0].userId.userName.toLowerCase().contains(searchChat.toLowerCase());
      }
      if (chats[i].members[1].userId.id != loggedInUser!.id) {
        isMatch = chats[i].members[1].userId.userName.toLowerCase().contains(searchChat.toLowerCase());
      }
      if (isMatch) {
        filteredChats.add(chats[i]);
      }
    }

    print(filteredChats);
    _filteredChatsController.add(filteredChats);  // Add the filtered chats to the stream
    emit(GetSearchChatSuccessState());
    return filteredChats;
  }

  @override
  Future<void> close() {
    _filteredChatsController.close();
    return super.close();
  }

  // -------------------------- make follow using endpoints -----------------
  AnotherUser? anotherUser;
  bool inFollowing({required String? followId}) {
    // id bat3 elanother
    for (int i = 0; i < loggedInUser!.following.length; i++) {
      if (loggedInUser!.following[i]["userId"] == followId) {
        return true;
      }
    }
    return false;
  }

  Future<void> handleFollow(
      {required String? token, required String? followId}) async {
    try {
      emit(FollowLoadingState());

      if (inFollowing(followId: followId) == false) {
        emit(FollowSuccessState());
      } else {
        emit(UnFollowSuccessState());
      }
    } catch (error) {
      emit(FollowErrorState());
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

  //---------------- another user posts endpoints----------------------------
  AnotherUserPostsResponse? anotherUserPostsResponse;
  PostWrapper? postWrapper;

  Future<void> getAnotherUserPosts({required String? token,required String userName,required String id}) async {

    DioHelper.getData(
      url: "/users/$userName/$id/post",
      token: token,
    ).then((value) {
      emit(GetAnotherUserPostsLoadingState());

      anotherUserPostsResponse = AnotherUserPostsResponse.fromJson(value.data);



     }).catchError((error) {

      emit(GetAnotherUserPostsErrorState(error));
    });
  }
  //---------------------------Notifications--------------------------
  NotificationsModel? notificationsModel;
  Future<void> markNotification(String? token,String id)async{
    emit(MarkNotificationLoadingState());
    DioHelper.patchData(
      url: "/notifications/$id/read",
      token: token,
    ).then((value) {
    emit(MarkNotificationSuccessState());

    }).catchError((error){
    emit(MarkNotificationErrorState(error.toString()));

    });
  }


  Future<void> getLoggedInUserNotifications(String? token)async{
    emit(GetLoggedInUserNotificationLoadingState());
    DioHelper.getData(
      url: "/notifications",
      token: token,
    ).then((value) {
      notificationsModel = NotificationsModel.fromJson(value.data);
      emit(GetLoggedInUserNotificationSuccessState());
      print(notificationsModel);

    }).catchError((error) {
      emit(GetLoggedInUserNotificationErrorState(error));
    });
  }
}












