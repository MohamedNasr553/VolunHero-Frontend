abstract class LayoutStates {}

/// Home Page Initialization
class LayoutInitialState extends LayoutStates {}

class ChangeBottomNavBarState extends LayoutStates {}

class HomeChangeBottomNavBarState extends LayoutStates{}

class ToggleRoadBlocksState extends LayoutStates {}

class ChangeBottomIconColor extends LayoutStates{}

/// Get All Posts
class HomePagePostsLoadingState extends LayoutStates{}

class HomePagePostsSuccessState extends LayoutStates{}

class HomePagePostsErrorState extends LayoutStates{}

/// Get Post By ID
class GetPostByIdLoadingState extends LayoutStates{}

class GetPostByIdSuccessState extends LayoutStates{}

class GetPostByIdErrorState extends LayoutStates{}

/// Get Comment By Post ID
class GetCommentLoadingState extends LayoutStates{}

class GetCommentSuccessState extends LayoutStates{}

class GetCommentErrorState extends LayoutStates{}

/// Like Post
class LikePostLoadingState extends LayoutStates{}

class LikePostSuccessState extends LayoutStates{}

class LikePostErrorState extends LayoutStates{}

class ChangeLikePostState extends LayoutStates{}

/// Delete Post
class DeletePostLoadingState extends LayoutStates{}

class DeletePostSuccessState extends LayoutStates{}

class DeletePostErrorState extends LayoutStates{}

/// Share Post
class SharePostLoadingState extends LayoutStates{}

class SharePostSuccessState extends LayoutStates{}

class SharePostErrorState extends LayoutStates{}

/// Posts of owner
class OwnerPostsInitialState extends LayoutStates {}

class OwnerPostsLoadingState extends LayoutStates {}

class OwnerPostsSuccessState extends LayoutStates{}

class OwnerPostsErrorState extends LayoutStates {}

/// Another User States
class GetAnotherUserDataLoadingState extends LayoutStates{}

class GetAnotherUserDataErrorState extends LayoutStates{}

class GetAnotherUserDataSuccessState extends LayoutStates{}
