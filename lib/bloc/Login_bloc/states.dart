abstract class UserLoginStates {}

class UserLoginInitialState extends UserLoginStates {}

class UserLoginErrorState extends UserLoginStates {
  final String error;

  UserLoginErrorState(this.error);
}

class UserLoginLoadingState extends UserLoginStates {}

class UserLoginSuccessState extends UserLoginStates {}

class LoginChangePasswordState extends UserLoginStates {}
class LoginChangeFollowState extends UserLoginStates {}

class GetLoggedInUserLoadingState extends UserLoginStates {}

class GetLoggedInUserErrorState extends UserLoginStates {
  final String error;

  GetLoggedInUserErrorState(this.error);
}

class GetLoggedInUserSuccessState extends UserLoginStates {}

class UpdateLoggedInUserLoadingState extends UserLoginStates {}

class UpdateLoggedInUserSuccessState extends UserLoginStates {}

class UpdateLoggedInUserErrorState extends UserLoginStates {
  final String error;

  UpdateLoggedInUserErrorState(this.error);
}


class GetLoggedInUserChatsLoadingState extends UserLoginStates {}

class GetLoggedInUserChatsErrorState extends UserLoginStates {
  final String error;

  GetLoggedInUserChatsErrorState(this.error);
}

class GetLoggedInUserChatsSuccessState extends UserLoginStates {}
