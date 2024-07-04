abstract class LayoutStates {}

/// Home Page Initialization
class LayoutInitialState extends LayoutStates {}

class ChangeOrganizationBottomNavBarState extends LayoutStates {}

class ChangeUserBottomNavBarState extends LayoutStates {}

class ToggleRoadBlocksState extends LayoutStates {}

class ChangeBottomIconColor extends LayoutStates {}

/// Get All Posts
class HomePagePostsLoadingState extends LayoutStates {}

class HomePagePostsSuccessState extends LayoutStates {}

class HomePagePostsErrorState extends LayoutStates {}

/// Get Post By ID
class GetPostByIdLoadingState extends LayoutStates {}

class GetPostByIdSuccessState extends LayoutStates {}

class GetPostByIdErrorState extends LayoutStates {}

/// Get Comment By Post ID
class GetCommentLoadingState extends LayoutStates {}

class GetCommentSuccessState extends LayoutStates {}

class GetCommentErrorState extends LayoutStates {}

/// Add Comment
class AddCommentLoadingState extends LayoutStates {}

class AddCommentSuccessState extends LayoutStates {}

class AddCommentErrorState extends LayoutStates {}

/// Delete Comment
class DeleteCommentLoadingState extends LayoutStates {}

class DeleteCommentSuccessState extends LayoutStates {}

class DeleteCommentErrorState extends LayoutStates {}

/// Like Post
class LikePostLoadingState extends LayoutStates {}

class LikePostSuccessState extends LayoutStates {}

class LikePostErrorState extends LayoutStates {}

class ChangeLikePostState extends LayoutStates {}

/// Get Likes On A Post
class GetLikesOnPostLoadingState extends LayoutStates {}

class GetLikesOnPostSuccessState extends LayoutStates {}

class GetLikesOnPostErrorState extends LayoutStates {}

/// Delete Post
class DeletePostLoadingState extends LayoutStates {}

class DeletePostSuccessState extends LayoutStates {}

class DeletePostErrorState extends LayoutStates {}

/// Share Post
class SharePostLoadingState extends LayoutStates {}

class SharePostSuccessState extends LayoutStates {}

class SharePostErrorState extends LayoutStates {}

/// Remove Share
class RemoveShareLoadingState extends LayoutStates {}

class RemoveShareSuccessState extends LayoutStates {}

class RemoveShareErrorState extends LayoutStates {}

/// Edit Post
class EditPostLoadingState extends LayoutStates {}

class EditPostSuccessState extends LayoutStates {}

class EditPostErrorState extends LayoutStates {}

/// Search Post
class SearchPostLoadingState extends LayoutStates {}

class SearchPostSuccessState extends LayoutStates {}

class SearchPostErrorState extends LayoutStates {}

/// Posts of owner
class OwnerPostsLoadingState extends LayoutStates {}

class OwnerPostsSuccessState extends LayoutStates {}

class OwnerPostsErrorState extends LayoutStates {}

/// Another User States
class GetAnotherUserDataLoadingState extends LayoutStates {}

class GetAnotherUserDataErrorState extends LayoutStates {}

class GetAnotherUserDataSuccessState extends LayoutStates {}
