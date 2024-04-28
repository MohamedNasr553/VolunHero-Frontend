abstract class UserSignUpStates{}

class UserSignUpInitialState extends UserSignUpStates{}

class UserSignUpLoadingState extends UserSignUpStates{}

class UserSignUpSuccessState extends UserSignUpStates{}

class UserSignUpErrorState extends UserSignUpStates{
  final String error;

  UserSignUpErrorState(this.error);
}

class RegisterChangePasswordVisibilityState extends UserSignUpStates{}