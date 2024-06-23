import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/savedPosts_bloc/states.dart';
import 'package:flutter_code/models/getAllSavedPostsModel.dart';
import 'package:flutter_code/models/savePostModel.dart';
import 'package:flutter_code/shared/network/endpoints.dart';
import 'package:flutter_code/shared/network/remote/dio_helper.dart';

class SavedPostsCubit extends Cubit<SavedPostsStates> {
  SavedPostsCubit() : super(SavedPostsInitialState());

  static SavedPostsCubit get(context) => BlocProvider.of(context);

  /// ----------------------- Save Posts API ------------------------

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
      );

      emit(SavedPostsSuccessState());
      getAllSavedPosts(token: token);
    } catch (error) {
      print('Error Creating Post: $error');

      emit(SavedPostsErrorState());
    }
  }

  /// ----------------------- Get All Saved Posts API ------------------------

  GetSavedPostsResponse? getSavedPostsResponse;
  GetSavedPosts? getSavedPosts;
  GetDetailedSavedPost? getDetailedSavedPost;

  void getAllSavedPosts({
    required String token,
  }) async {
    emit(GetAllSavedPostsLoadingState());

    try {
      final value = await DioHelper.getData(
        url: SAVED_POSTS,
        token: token,
      );

      getSavedPostsResponse = GetSavedPostsResponse.fromJson(value.data);

      getSavedPosts = getSavedPostsResponse?.savedPosts?.isNotEmpty == true
          ? getSavedPostsResponse!.savedPosts!.first
          : null;
      getDetailedSavedPost = getSavedPosts?.posts?.isNotEmpty == true
          ? getSavedPosts!.posts!.first
          : null;

      emit(GetAllSavedPostsSuccessState());
    } catch (error) {
      print(error.toString());

      emit(GetAllSavedPostsErrorState());
    }
  }
}
