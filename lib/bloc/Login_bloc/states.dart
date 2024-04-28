abstract class UserLoginStates{}

class UserLoginInitialState extends UserLoginStates{}

class UserLoginErrorState extends UserLoginStates{
  final String error;
  UserLoginErrorState(this.error);
}


class UserLoginLoadingState extends UserLoginStates{}

class UserLoginSuccessState extends UserLoginStates{}