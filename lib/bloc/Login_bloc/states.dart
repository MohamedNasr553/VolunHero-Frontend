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

//// TODO: {follow states}
class FollowLoadingState extends UserLoginStates{}
class FollowErrorState extends UserLoginStates{}
class FollowSuccessState extends UserLoginStates{}
class UnFollowSuccessState extends UserLoginStates{}
class InFollowersState extends UserLoginStates{}
class NotInFollowersState extends UserLoginStates{}

/// another user getters states
class GetAnotherUserFollowersState extends UserLoginStates{
  final int followersLen;
  GetAnotherUserFollowersState(this.followersLen);
}

