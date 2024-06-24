import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/savedPosts_bloc/states.dart';
import 'package:flutter_code/models/getAllSavedPostsModel.dart';
import 'package:flutter_code/models/savePostModel.dart';
import 'package:flutter_code/modules/GeneralView/SavedPosts/Saved_Posts.dart';
import 'package:flutter_code/shared/network/endpoints.dart';
import 'package:flutter_code/shared/network/remote/dio_helper.dart';

class SavedPostsCubit extends Cubit<SavedPostsStates> {
  SavedPostsCubit() : super(SavedPostsInitialState());

  static SavedPostsCubit get(context) => BlocProvider.of(context);

  SavedPostsResponse? getSavedPostsResponse;
  GetSavedPosts? getSavedPosts;
  GetDetailedSavedPost? getDetailedSavedPosts;
  List<GetDetailedSavedPost>? detailedSavedPosts = [];

  /// ----------------------- Save Post API ------------------------
  void savePost({
    required String token,
    required String postId,
  }) async {
    try {
      emit(SavedPostsLoadingState());

      await DioHelper.postData(
        url: "/savedPosts/$postId",
        data: {},
        token: token,
      );

      emit(SavedPostsSuccessState());
      getAllSavedPosts(token: token);
    } catch (error) {
      emit(SavedPostsErrorState());
    }
  }

  /// ----------------------- Get All Saved Posts API ------------------------
  void getAllSavedPosts({
    required String token,
  }) async {
    emit(GetAllSavedPostsLoadingState());

    try {
      final response = await DioHelper.getData(
        url: SAVED_POSTS,
        token: token,
      );

      getSavedPostsResponse = SavedPostsResponse.fromJson(response.data);
      detailedSavedPosts = getSavedPostsResponse?.savedPosts
          .expand<GetDetailedSavedPost>((savedPost) =>
      savedPost.posts.map((post) => post as GetDetailedSavedPost))
          .toList() ?? [];


      emit(GetAllSavedPostsSuccessState());
    } catch (error) {
      print(error.toString());
      emit(GetAllSavedPostsErrorState());
    }
  }

  /// ----------------------- Remove Saved Post API ------------------------
  void removeSavedPost({
    required String token,
    required String postId,
  }) async {
    emit(RemovePostLoadingState());

    try {
      await DioHelper.deleteData(
        url: "/savedPosts/$postId",
        token: token,
      );

      emit(RemovePostSuccessState());
      getAllSavedPosts(token: token);
    } catch (error) {
      emit(RemovePostErrorState());
    }
  }
}
