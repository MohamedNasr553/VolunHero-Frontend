import 'package:flutter_code/modules/GeneralView/Login/Login_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/network/local/CacheHelper.dart';

void signOut(context){
  CacheHelper.removeData(key: "token").then((value){
    if(value){
      navigateAndFinish(context, LoginPage());
    }
  });
}

String? userToken = '';
Future<String?> getUserToken() async{
  return CacheHelper.get(key: 'token');
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}