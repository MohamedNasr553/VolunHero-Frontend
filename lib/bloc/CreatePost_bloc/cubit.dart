import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/CreatePost_bloc/states.dart';
import 'package:flutter_code/models/CreatePostModel.dart';
import 'package:flutter_code/shared/network/endpoints.dart';
import 'package:flutter_code/shared/network/remote/dio_helper.dart';

class CreatePostCubit extends Cubit<CreatePostStates> {
  CreatePostCubit() : super(CreatePostInitialState());

  static CreatePostCubit get(context) => BlocProvider.of(context);

  /// ----------------------- Create Posts API ------------------------

  CreatePostsResponse? createPostsResponse;
  Future<void> createPost({
    required String content,
    List<Map<String, dynamic>>? attachments,
    required String token,
  }) async {
    try {
      emit(CreatePostLoadingState());

      Map<String, dynamic> requestData = {
        'content': content,
      };

      print('Data Sent: $requestData.toString()');

      // Add attachments to data if available
      if (attachments != null && attachments.isNotEmpty) {
        requestData['attachments'] = attachments;
      }

      var createPostData = await DioHelper.postData(
        url: CREATE_POST,
        data: requestData,
        token: token,
      );

      print(createPostData.toString());
      emit(CreatePostSuccessState());
    }
    catch (error) {
      print('Error Creating Post: $error');

      emit(CreatePostErrorState());
    }
  }
}
