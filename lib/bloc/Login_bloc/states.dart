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
class FollowLoadingState extends UserLoginStates {}

class FollowErrorState extends UserLoginStates {}

class FollowSuccessState extends UserLoginStates {}

class UnFollowSuccessState extends UserLoginStates {}

class InFollowersState extends UserLoginStates {}

class NotInFollowersState extends UserLoginStates {}

/// another user getters states
class GetAnotherUserFollowersState extends UserLoginStates {
  final int followersLen;

  GetAnotherUserFollowersState(this.followersLen);
}

// Another User Posts States
class GetAnotherUserPostsSuccessState extends UserLoginStates {}

class GetAnotherUserPostsLoadingState extends UserLoginStates {}

class GetAnotherUserPostsErrorState extends UserLoginStates {
  final String error;
  GetAnotherUserPostsErrorState(this.error);
}


// LoggedIn User Notifications States
class GetLoggedInUserNotificationSuccessState extends UserLoginStates {}

class GetLoggedInUserNotificationLoadingState extends UserLoginStates {}

class GetLoggedInUserNotificationErrorState extends UserLoginStates {
  final String error;
  GetLoggedInUserNotificationErrorState(this.error);
}

// LoggedIn User Mark Notification States
class MarkNotificationSuccessState extends UserLoginStates {}

class MarkNotificationLoadingState extends UserLoginStates {}

class MarkNotificationErrorState extends UserLoginStates {
  final String error;
  MarkNotificationErrorState(this.error);
}
// Get Search chat states
class GetSearchChatSuccessState extends UserLoginStates {}
class GetSearchChatLoadingState extends UserLoginStates {}

// Send message States
class CreateMessageSuccessState extends UserLoginStates {}

class CreateMessageLoadingState extends UserLoginStates {}

class CreateMessageErrorState extends UserLoginStates {
  final String error;

  CreateMessageErrorState(this.error);
}

class RefreshMessagesLoadingState extends UserLoginStates {}

class RefreshMessagesSuccessState extends UserLoginStates {}

class CreateChatSuccessState extends UserLoginStates {}

class CreateChatLoadingState extends UserLoginStates {}

class CreateChatErrorState extends UserLoginStates {
  final String error;

  CreateChatErrorState(this.error);
}
