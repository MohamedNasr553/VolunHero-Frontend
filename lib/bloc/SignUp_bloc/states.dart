abstract class UserSignUpStates{}

class UserSignUpInitialState extends UserSignUpStates{}

class UserSignUpLoadingState extends UserSignUpStates{}

class UserSignUpSuccessState extends UserSignUpStates{}
class UserSignUpProfileState extends UserSignUpStates{}
class UserSignUpAttachmentState extends UserSignUpStates{}

class UserSignUpErrorState extends UserSignUpStates{
  final String error;

  UserSignUpErrorState(this.error);
}

class RegisterChangePasswordVisibilityState extends UserSignUpStates{}

class RegisterChangeCPasswordVisibilityState extends UserSignUpStates{}