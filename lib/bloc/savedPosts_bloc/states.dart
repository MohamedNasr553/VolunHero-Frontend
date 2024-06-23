abstract class SavedPostsStates {}

class SavedPostsInitialState extends SavedPostsStates {}

class SavedPostsLoadingState extends SavedPostsStates{}

class SavedPostsSuccessState extends SavedPostsStates{}

class SavedPostsErrorState extends SavedPostsStates{}

class GetAllSavedPostsLoadingState extends SavedPostsStates{}

class GetAllSavedPostsSuccessState extends SavedPostsStates{}

class GetAllSavedPostsErrorState extends SavedPostsStates{}

class RemovePostLoadingState extends SavedPostsStates{}

class RemovePostSuccessState extends SavedPostsStates{}

class RemovePostErrorState extends SavedPostsStates{}
