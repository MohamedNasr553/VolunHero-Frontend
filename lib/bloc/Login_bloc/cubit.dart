import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Layout_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/models/AnotherUserModel.dart';
import 'package:flutter_code/models/LoggedInUserModel.dart';
import 'package:flutter_code/models/LoginModel.dart';
import 'package:flutter_code/models/NotificationsModel.dart';
import 'package:flutter_code/models/OtherUserFollowings.dart';
import 'package:flutter_code/models/getMyFollowers.dart';
import 'package:flutter_code/models/getMyFollowing.dart';
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
    try {
      emit(UserLoginLoadingState());

      Map<String, dynamic> requestData = {
        'email': email,
        'password': password,
      };

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
    required String phone,
    required String address,
  }) async {
    try {
      emit(UpdateLoggedInUserLoadingState());

      Map<String, dynamic> requestData = {
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'address': address,
      };

      var value = await DioHelper.patchData(
        url: "/users/updateMe",
        data: requestData,
        token: token,
      );

      print("Request: ${value.toString()}");

      emit(UpdateLoggedInUserSuccessState());
    } catch (error) {
      emit(UpdateLoggedInUserErrorState(error.toString()));
    }
  }

  // --------------------------------- Chats ----------------------------------

  Future<void> deleteChat({
    required String? token,
    required String chatID,
  }) async {
    try {
      await DioHelper.deleteData(
        url: "/chat/$chatID",
        token: token,
      );
      showToast(
        text: "Chat Deleted Successfully",
        state: ToastStates.SUCCESS,
      );

      // Remove the chat from the local list
      chats.removeWhere((chat) => chat.id == chatID);

      emit(DeleteChatSuccessState());
    } catch (onError) {
      emit(DeleteChatErrorState(onError.toString()));
    }
  }

  void refreshChatPage(String chatId) async {
    emit(RefreshMessagesLoadingState());
    getLoggedInChats(token: loginModel!.refresh_token).then((value) {
      List<Chat> userChat = chats;
      for (int i = 0; i < userChat.length; i++) {
        if (userChat[i].id == chatId) {
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
      var response = await DioHelper.postData(
          url: CREATE_CHAT,
          data: requestData,
          token: loginModel!.refresh_token
      ).then((value) async {
        print(value);
        emit(CreateChatSuccessState());
      });
    } catch (error) {
      emit(CreateChatErrorState(error.toString()));
      return "Failed to create chat: $error";
    }
    return "function return";
  }

  Future<String> sendMessage(
      {required String chatId,
      required String senderId,
      required String text,
      required String token,
      required Chat? chat}) async {
    Map<String, dynamic> requestData = {
      'chatId': chatId,
      'senderId': senderId,
      'text': text,
    };

    try {
      emit(CreateMessageLoadingState());
      await DioHelper.postData(url: CREATE_MSG, data: requestData, token: token)
          .then((value) async {
        emit(CreateMessageSuccessState());
      });

      // Assuming DioHelper.postData returns the response directly
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
        for (int i = 0; i < chats.length; i++) {
          DioHelper.getData(url: GET_CHAT_MSGS + chats[i].id, token: token)
              .then((value) {
            //     print(i);
            //    print("   ");
            //    print(value.data);
            MessageResponse messageResponse =
                MessageResponse.fromJson(value.data);
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
  final StreamController<List<Chat>> _filteredChatsController =
      StreamController<List<Chat>>.broadcast();

  Stream<List<Chat>> get filteredChatsStream => _filteredChatsController.stream;

  List<Chat> getChatsBySearch(String searchChat) {
    filteredChats = [];
    emit(GetSearchChatLoadingState());

    for (int i = 0; i < chats.length; i++) {
      bool isMatch = false;
      if (chats[i].members[0].userId.id != loggedInUser!.id) {
        isMatch = chats[i]
            .members[0]
            .userId
            .userName
            .toLowerCase()
            .contains(searchChat.toLowerCase());
      }
      if (chats[i].members[1].userId.id != loggedInUser!.id) {
        isMatch = chats[i]
            .members[1]
            .userId
            .userName
            .toLowerCase()
            .contains(searchChat.toLowerCase());
      }
      if (isMatch) {
        filteredChats.add(chats[i]);
      }
    }

    _filteredChatsController
        .add(filteredChats); // Add the filtered chats to the stream
    emit(GetSearchChatSuccessState());
    return filteredChats;
  }

  @override
  Future<void> close() {
    _filteredChatsController.close();
    return super.close();
  }

  /// ------------------------- Get My Following ----------------------------
  UserProfile? userProfileFollowings;
  UserId? userIdFollowings;

  void getMyFollowings({
    required String? token,
  }) async {
    emit(GetMyFollowingLoadingState());

    DioHelper.getData(
      url: "/users/following",
      token: token,
    ).then((value) {
      userProfileFollowings = UserProfile.fromJson(value.data);

      emit(GetMyFollowingSuccessState());
    }).catchError((error) {
      emit(GetMyFollowingErrorState(error));
    });
  }

  /// ------------------------- Get My Followers ----------------------------
  GetMyFollowerResponse? userProfileFollowers;
  Follower? userIdFollowers;

  void getMyFollowers({
    required String? token,
  }) async {
    emit(GetMyFollowersLoadingState());

    DioHelper.getData(
      url: "/users/followers",
      token: token,
    ).then((value) {
      userProfileFollowers = GetMyFollowerResponse.fromJson(value.data);

      emit(GetMyFollowersSuccessState());
    }).catchError((error) {
      emit(GetMyFollowersErrorState(error));
    });
  }

  /// ------------------------- Get Other User Following ----------------------------
  OtherUserProfile? otherUserProfileFollowings;
  OtherUserId? otherUserIdFollowings;

  void getOtherUserFollowings({
    required String? token,
    required String? slugUsername,
    required String? id,
  }) async {
    emit(GetOtherUserFollowingLoadingState());

    DioHelper.getData(
      url: "/users/$slugUsername/$id/following",
      token: token,
    ).then((value) {
      otherUserProfileFollowings = OtherUserProfile.fromJson(value.data);

      emit(GetOtherUserFollowingSuccessState());
    }).catchError((error) {
      emit(GetOtherUserFollowingErrorState(error));
    });
  }

  /// ------------------------- Get Other User Followers ----------------------------
  GetMyFollowerResponse? otherUserProfileFollowers;
  Follower? otherUserIdFollowers;

  void getOtherUserFollowers({
    required String? token,
    required String? slugUsername,
    required String? id,
  }) async {
    emit(GetOtherUserFollowersLoadingState());

    DioHelper.getData(
      url: "/users/$slugUsername/$id/followers",
      token: token,
    ).then((value) {
      otherUserProfileFollowers = GetMyFollowerResponse.fromJson(value.data);
      emit(GetOtherUserFollowersSuccessState());
    }).catchError((error) {
      emit(GetOtherUserFollowersErrorState(error));
    });
  }

  // -------------------------- make follow using endpoints -----------------
  AnotherUser? anotherUser;
  String? IdOfSelected;






   bool flag = false;

  Future<void> handleFollow(
      {required String? token, required String? followId}) async {
    try {
      emit(FollowLoadingState());

      print("XD");
      print(flag);
      if (flag == false) {
          anotherUser!.followers.add({"userId": followId}); // Assuming followers is a list of objects with userId

        DioHelper.patchData(
          url: "/users/${followId}/makefollow",
          token: token,
        ).then((value) {
          print(value.data);
          // Add the user to the following list
          anotherUser!.isFollowed = true;
          emit(FollowSuccessState());
        });
      } else {
          anotherUser!.followers.removeWhere((user) => user["userId"] == followId);
        DioHelper.patchData(
          url: "/users/${followId}/makeunfollow",
          token: token,
        ).then((value) {
          print(value.data);
          // Remove the user from the following list
          anotherUser!.isFollowed = false;
          emit(UnFollowSuccessState());
        });
      }
      flag = !flag;
    } catch (error) {
      emit(FollowErrorState());
    }
  }



  bool inFollowing({required String? followId}) {
    for (int i = 0; i < loggedInUser!.following.length; i++) {
      if (loggedInUser!.following[i]["userId"] == followId) {
        return true;
      }
    }
    return false;
  }





  int getAnotherUserFollowers() {
    emit(GetAnotherUserFollowersState(anotherUser!.followers.length));
    return (anotherUser!.followers.length);
  }

  //---------------- another user posts endpoints ----------------------------
  AnotherUserPostsResponse? anotherUserPostsResponse;
  PostWrapper? postWrapper;

  Future<void> getAnotherUserPosts(
      {required String? token,
      required String userName,
      required String id}) async {
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

  /// --------------------------- Notifications --------------------------
  NotificationsModel? notificationsModel;

  Future<void> markNotification(String? token, String id) async {
    emit(MarkNotificationLoadingState());
    DioHelper.patchData(
      url: "/notifications/$id/read",
      token: token,
    ).then((value) {
      emit(MarkNotificationSuccessState());
    }).catchError((error) {
      emit(MarkNotificationErrorState(error.toString()));
    });
  }

  Future<void> getLoggedInUserNotifications(String? token) async {
    emit(GetLoggedInUserNotificationLoadingState());
    DioHelper.getData(
      url: "/notifications",
      token: token,
    ).then((value) {
      notificationsModel = NotificationsModel.fromJson(value.data);
      emit(GetLoggedInUserNotificationSuccessState());
    }).catchError((error) {
      emit(GetLoggedInUserNotificationErrorState(error));
    });
  }

  // --------------------------- Delete ME -----------------------------
  void deleteMe({
    required String token,
  }) {
    emit(DeleteMeLoadingState());

    DioHelper.deleteData(
      url: "/users/deleteMe",
      token: token,
    ).then((value) {
      emit(DeleteMeSuccessState());
    }).catchError((error) {
      emit(DeleteMeErrorState(error.toString()));
    });
  }
}
