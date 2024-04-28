import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/models/LoginModel.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../shared/network/endpoints.dart';
import '../../shared/network/remote/dio_helper.dart';

class UserLoginCubit extends Cubit<UserLoginStates> {
   UserLoginCubit() : super(UserLoginInitialState());
   static UserLoginCubit get(context) => BlocProvider.of(context);

   LoginModel? loginModel;


   String loginUser({
      required String email,
      required String password,
    }) {
      Map<String, dynamic> requestData = {
         'email': email,
         'password': password,
      };

      emit(UserLoginLoadingState());
      DioHelper.postData(
         url: LOGIN,
         data: requestData,
      ).then((value) {

         print(value.toString());
         loginModel = LoginModel.fromJson(value.data);
         emit(UserLoginSuccessState());
         String? accessToken = loginModel?.access_token;
         Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken!);
         print("+++++++++++++++++++++++++++++++\n");
         print(decodedToken.toString());
         //{_id: 662e2849c4ed7f0e0e58eff6, role: User, iat: 1714329692, exp: 1714331492}
         print("+++++++++++++++++++++++++++++++\n");
         return (value.toString());

      }).catchError((error) {
         emit(UserLoginErrorState(error.toString()));
         return(error);
      });
      return "";

    }
}
