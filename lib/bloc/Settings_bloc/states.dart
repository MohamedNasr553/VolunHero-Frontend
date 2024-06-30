abstract class SettingsStates {}

class SettingsInitialState extends SettingsStates {}

/// Update Password
class UpdatePasswordLoadingState extends SettingsStates{}

class UpdatePasswordSuccessState extends SettingsStates{}

class UpdatePasswordErrorState extends SettingsStates{}
