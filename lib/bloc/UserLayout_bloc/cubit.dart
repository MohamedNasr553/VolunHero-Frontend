import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/states.dart';
import 'package:flutter_code/models/AddCommentModel.dart';
import 'package:flutter_code/models/AnotherUserModel.dart';
import 'package:flutter_code/models/GetCommentModel.dart';
import 'package:flutter_code/models/GetPostByIdModel.dart';
import 'package:flutter_code/models/HomePagePostsModel.dart';
import 'package:flutter_code/models/OwnerPostsModel.dart';
import 'package:flutter_code/modules/GeneralView/CreatePost/CreatePost_Page.dart';
import 'package:flutter_code/modules/GeneralView/GetSupport/Support_Page.dart';
import 'package:flutter_code/modules/GeneralView/HomePage/Home_Page.dart';
import 'package:flutter_code/modules/UserView/RoadBlocks/camera_view.dart';
import 'package:flutter_code/modules/GeneralView/Notifications/Notifications_Page.dart';
import 'package:flutter_code/shared/network/endpoints.dart';
import 'package:flutter_code/shared/network/remote/dio_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeLayoutCubit extends Cubit<LayoutStates> {
  HomeLayoutCubit() : super(LayoutInitialState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isActive = false;

  /// -------------------- Bottom Navigation Bar -----------------------
  List<BottomNavigationBarItem> bottomItems = [];

  Widget changeBottomIcon(int index, Widget a, Widget b) {
    emit(ChangeBottomIconColor());
    if (currentIndex == index) {
      return a;
    }
    return b;
  }

  void initializeBottomItems() {
    bottomItems = [
      BottomNavigationBarItem(
        icon: changeBottomIcon(
          0,
          SvgPicture.asset(
            "assets/images/Home_fill_colored.svg",
            width: 25.0,
            height: 25.0,
          ),
          SvgPicture.asset(
            "assets/images/Home_fill.svg",
            width: 25.0,
            height: 25.0,
          ),
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: changeBottomIcon(
            1,
            SvgPicture.asset(
              "assets/images/Phone_fill.svg",
              width: 25.0,
              height: 25.0,
            ),
            SvgPicture.asset(
              "assets/images/supportIcon.svg",
              width: 25.0,
              height: 25.0,
            )),
        label: 'Support',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.add_box_rounded,
        ),
        label: 'Post',
      ),
      BottomNavigationBarItem(
        icon: changeBottomIcon(
            3,
            SvgPicture.asset(
              "assets/images/Bell_fill_colored.svg",
              width: 25.0,
              height: 25.0,
            ),
            SvgPicture.asset(
              "assets/images/Bell_fill.svg",
              width: 25.0,
              height: 25.0,
            )),
        label: 'Notifications',
      ),
      BottomNavigationBarItem(
        icon: changeBottomIcon(
            4,
            SvgPicture.asset(
              "assets/images/View_alt_fill_activated.svg",
              width: 25.0,
              height: 25.0,
            ),
            SvgPicture.asset(
              "assets/images/View_alt_fill.svg",
              width: 25.0,
              height: 25.0,
            )),
        label: 'RoadBlocks',
      ),
    ];
  }

  var layoutScreens = [
    const HomePage(),
    const GetSupport(),
    const CreatePost(),
    NotificationPage(),
    const CameraView()
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    initializeBottomItems();
    emit(ChangeBottomNavBarState());
  }

  /// ----------------------- Get All Posts API ------------------------

  HomePagePostsResponse? homePagePostsModel;
  ModifiedPost? modifiedPost;

  void getAllPosts({required String token}) async {
    DioHelper.getData(
      url: GET_ALL_POSTS,
      token: token,
    ).then((value) {
      emit(HomePagePostsLoadingState());
      homePagePostsModel = HomePagePostsResponse.fromJson(value.data);

      print('Parsed HomePagePostsModel: $homePagePostsModel'.toString());
      emit(HomePagePostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomePagePostsErrorState());
    });
  }

  /// ----------------------- Get Post by ID -----------------------
  GetPostById? getPostById;
  SpecificPost? post;

  void getPostId({required String token, required String postId}) async {
    emit(GetPostByIdLoadingState());

    DioHelper.getData(
      url: "/post/$postId",
      token: token,
    ).then((value) {
      emit(GetPostByIdSuccessState());
      getPostById = GetPostById.fromJson(value.data);
      getCommentById(token: token, postId: postId);
    }).catchError((error) {
      print(error.toString());

      emit(GetPostByIdErrorState());
    });
  }

  /// -------------------- Get Comment by Post ID ------------------
  GetCommentsResponse? getCommentsResponse;
  Comment? comment;

  void getCommentById({required String token, required String postId}) async {
    emit(GetCommentLoadingState());

    DioHelper.getData(
      url: "/post/$postId/comment",
      token: token,
    ).then((value) {
      getCommentsResponse = GetCommentsResponse.fromJson(value.data);
      emit(GetCommentSuccessState());
      // print("Comments parsed: $getCommentsResponse".toString());
    }).catchError((error) {
      print(error.toString());

      emit(GetCommentErrorState());
    });
  }

  /// ----------------------- Add Comment --------------------------
  AddCommentResponse? addCommentResponse;
  AddComment? addComment;

  void createComment({
    required String content,
    required String token,
    required String postId,
  }) async {
    try {
      emit(AddCommentLoadingState());

      // Make the HTTP POST request
      await DioHelper.postData(
        url: "/post/$postId/comment",
        data: {
          'content': content,
        },
        token: token,
      );

      emit(AddCommentSuccessState());
      getPostId(token: token, postId: postId);
    } catch (error, stackTrace) {
      print('Error Creating Comment: $error');
      print('Stack Trace: $stackTrace');

      // Emit error state
      emit(AddCommentErrorState());
    }
  }

  /// ----------------------- Delete Comment -----------------------
  void deleteComment({
    required String token,
    required String postId,
    required commentId,
  }) {
    emit(DeleteCommentLoadingState());

    DioHelper.deleteData(
      url: "/post/$postId/comment/$commentId",
      token: token,
    ).then((value) {
      emit(DeleteCommentSuccessState());

      getAllPosts(token: token);
      getOwnerPosts(token: token);
      getPostId(token: token, postId: postId);
    }).catchError((error) {
      print(error.toString());

      emit(DeleteCommentErrorState());
    });
  }

  /// ----------------------- Like Post API ------------------------

  void likePostUI(ModifiedPost post) {
    post.liked = !post.liked;
    emit(ChangeLikePostState());
  }

  void likePost({required String token, required String postId}) {
    emit(LikePostLoadingState());

    DioHelper.patchData(
      url: "/post/$postId/like",
      token: token,
    ).then((value) {
      emit(LikePostSuccessState());

      getAllPosts(token: token);
      getOwnerPosts(token: token);
      // getAnotherUserData(token: token, id: postId);
      getPostId(token: token, postId: postId);
    }).catchError((error) {
      print(error.toString());

      emit(LikePostErrorState());
    });
  }

  /// ----------------------- Delete Post API ------------------------

  void deletePost({required String token, required String postId}) {
    emit(DeletePostLoadingState());

    DioHelper.deleteData(
      url: "/post/$postId",
      token: token,
    ).then((value) {
      emit(DeletePostSuccessState());

      getAllPosts(token: token);
      getOwnerPosts(token: token);
    }).catchError((error) {
      print(error.toString());

      emit(DeletePostErrorState());
    });
  }

  /// ----------------------- Share Post API ------------------------
  void sharePost({required String token, required String postId}) {
    emit(SharePostLoadingState());

    DioHelper.patchData(
      url: "/post/$postId/share",
      token: token,
    ).then((value) {
      emit(SharePostSuccessState());

      getAllPosts(token: token);
      getOwnerPosts(token: token);
    }).catchError((error) {
      print(error.toString());

      emit(SharePostErrorState());
    });
  }

  /// ----------------------- Owner Posts API ------------------------
  OwnerPostsResponse? ownerPostsModel;
  Posts? newPost;

  void getOwnerPosts({required String token}) async {
    DioHelper.getData(
      url: GET_OWNER_POSTS,
      token: token,
    ).then((value) {
      emit(OwnerPostsLoadingState());
      ownerPostsModel = OwnerPostsResponse.fromJson(value.data);

      print('Parsed OwnerPostsModel: $ownerPostsModel'.toString());
      emit(OwnerPostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(OwnerPostsErrorState());
    });
  }

  /// ---------------------------Another User ------------------

  AnotherUser? anotherUser;

  Future<void> getAnotherUserData(
      {required String? token, required String? id}) async {
    try {
      emit(GetAnotherUserDataLoadingState());
      var value = await DioHelper.getData(
        url: "/users/$id",
        token: token,
      );
      print("el another user: ");
      print(value);
      print("el another user: ");

      if (value != null) {
        // Parse the JSON response and assign it to the 'anotherUser' variable
        anotherUser = AnotherUser.fromJson(value.data["data"]["doc"]);
        // Now you can access the details of the user through 'anotherUser'
        print(anotherUser);
        emit(GetAnotherUserDataSuccessState());
      }
    } catch (error) {
      emit(GetAnotherUserDataErrorState());
      print('Error: $error');
    }
  }
}
