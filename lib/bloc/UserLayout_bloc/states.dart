abstract class LayoutStates {}

class LayoutInitialState extends LayoutStates {}

class ChangeBottomNavBarState extends LayoutStates {}

class HomeChangeBottomNavBarState extends LayoutStates{}

class ToggleRoadBlocksState extends LayoutStates {}

class ChangeBottomIconColor extends LayoutStates{}

class HomePagePostsLoadingState extends LayoutStates{}

class HomePagePostsSuccessState extends LayoutStates{}

class HomePagePostsErrorState extends LayoutStates{}

class LikePostLoadingState extends LayoutStates{}

class LikePostSuccessState extends LayoutStates{}

class LikePostErrorState extends LayoutStates{}

class ChangeLikePostState extends LayoutStates{}

class DeletePostLoadingState extends LayoutStates{}

class DeletePostSuccessState extends LayoutStates{}

class DeletePostErrorState extends LayoutStates{}

/// Posts of owner
class OwnerPostsInitialState extends LayoutStates {}

class OwnerPostsLoadingState extends LayoutStates {}

class OwnerPostsSuccessState extends LayoutStates{}

class OwnerPostsErrorState extends LayoutStates {}

/// Another User States
class GetAnotherUserDataLoadingState extends LayoutStates{}

class GetAnotherUserDataErrorState extends LayoutStates{}

class GetAnotherUserDataSuccessState extends LayoutStates{}
