import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/savedPosts_bloc/states.dart';
import 'package:flutter_code/models/getAllSavedPostsModel.dart';
import 'package:flutter_code/models/savePostModel.dart';
import 'package:flutter_code/shared/network/endpoints.dart';
import 'package:flutter_code/shared/network/remote/dio_helper.dart';

class SavedPostsCubit extends Cubit<SavedPostsStates> {
  SavedPostsCubit() : super(SavedPostsInitialState());

  static SavedPostsCubit get(context) => BlocProvider.of(context);

  /// ----------------------- Save Post API ------------------------

  SavedPostsResponse? savedPostsResponse;
  SavedPost? savedPost;

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
      ).then((value) {
        getAllSavedPosts(token: token);
      });

      emit(SavedPostsSuccessState());
    } catch (error) {
      emit(SavedPostsErrorState());
    }
  }

  /// ----------------------- Get All Saved Posts API ------------------------
  GetSavedPostsResponse? getSavedPostsResponse;
  GetSavedPosts? getSavedPosts;
  GetDetailedSavedPost? getDetailedSavedPost;

  Future<void> getAllSavedPosts({required String token}) async {
    emit(GetAllSavedPostsLoadingState());

    try {
      final response = await DioHelper.getData(
        url: SAVED_POSTS,
        token: token,
      );

      // Parse the API response
      getSavedPostsResponse = GetSavedPostsResponse.fromJson(response.data);

      if (getSavedPostsResponse != null &&
          getSavedPostsResponse!.savedPosts!.posts!.isNotEmpty) {
        getSavedPosts = getSavedPostsResponse!.savedPosts;

        emit(GetAllSavedPostsSuccessState());
      }
    } catch (error) {

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
