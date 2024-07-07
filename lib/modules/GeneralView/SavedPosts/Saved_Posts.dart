import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/bloc/Layout_bloc/cubit.dart';
import 'package:flutter_code/bloc/Layout_bloc/states.dart';
import 'package:flutter_code/bloc/savedPosts_bloc/cubit.dart';
import 'package:flutter_code/bloc/savedPosts_bloc/states.dart';
import 'package:flutter_code/layout/VolunHeroLayout/layout.dart';
import 'package:flutter_code/models/AnotherUserModel.dart';
import 'package:flutter_code/models/HomePagePostsModel.dart';
import 'package:flutter_code/models/LoggedInUserModel.dart';
import 'package:flutter_code/models/getAllSavedPostsModel.dart';
import 'package:flutter_code/modules/GeneralView/DetailedPost/Detailed_Post.dart';
import 'package:flutter_code/modules/GeneralView/AnotherUser/anotherUser_page.dart';
import 'package:flutter_code/modules/GeneralView/ProfilePage/Profile_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stroke_text/stroke_text.dart';

class SavedPosts extends StatefulWidget {
  const SavedPosts({super.key});

  @override
  State<SavedPosts> createState() => _UserSavedPostsState();
}

class _UserSavedPostsState extends State<SavedPosts> {
  final CarouselController carouselController = CarouselController();
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    if (UserLoginCubit.get(context).loginModel!.refresh_token != null &&
        UserLoginCubit.get(context).loginModel!.refresh_token!.isNotEmpty) {
      SavedPostsCubit.get(context).getAllSavedPosts(
          token: UserLoginCubit.get(context).loginModel!.refresh_token ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLoginCubit, UserLoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<HomeLayoutCubit, LayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return BlocConsumer<SavedPostsCubit, SavedPostsStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return Scaffold(
                  backgroundColor: Colors.grey[200],
                  appBar: AppBar(
                    backgroundColor: Colors.grey[200],
                    leading: IconButton(
                      icon: SvgPicture.asset('assets/images/arrowLeft.svg'),
                      color: HexColor("858888"),
                      onPressed: () {
                        navigateAndFinish(context, const VolunHeroLayout());
                      },
                    ),
                    title: StrokeText(
                      text: "Saved Posts",
                      strokeColor: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                        color: HexColor("296E6F"),
                      ),
                    ),
                  ),
                  body: (state is! SavedPostsLoadingState)
                      ? buildSavePostList(context)
                      : const SizedBox(),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget buildSavePostList(context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final homeCubit = HomeLayoutCubit.get(context);
    final loginCubit = UserLoginCubit.get(context);
    final savedPostsCubit = SavedPostsCubit.get(context);

    // print("ListView Length: ${savedPostsCubit.getSavedPosts!.posts!.length}");
    // Checks if getDetailedSavedPost is NotEmpty
    if (savedPostsCubit.getSavedPosts!.posts != null &&
        savedPostsCubit.getSavedPosts!.posts!.isNotEmpty) {
      return SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              reverse: true,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                List<ModifiedPost> postsList =  homeCubit.homePagePostsModel!.modifiedPosts;
                ModifiedPost? modifiedPost;
                for(int i=0;i<postsList.length;i++){
                  if(postsList[i].id == savedPostsCubit.getSavedPosts!.posts![index].postId){
                    print("********************");
                    print(postsList[i]);
                    print("********************");
                    print(savedPostsCubit.getSavedPosts!.posts![index]);
                    modifiedPost = postsList[i];
                  }
                }
                return buildSavedPostItem(
                  modifiedPost,
                  // SavedPostsCubit.get(context).getSavedPosts,
                  savedPostsCubit.getSavedPosts!.posts![index],
                  // savedPostsCubit.getDetailedSavedPost,
                  loginCubit.loggedInUserData!.doc,
                  context,
                );
              },
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 16,
                ),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
              itemCount: savedPostsCubit.getSavedPosts!.posts!.length,
            ),
          ],
        ),
      );
    }
    // Handle no saved posts
    else {
      return Padding(
        padding: EdgeInsetsDirectional.only(
          top: screenHeight / 30,
          start: screenWidth / 20,
          end: screenWidth / 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Save posts for later",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24.0,
                color: Colors.black87,
                fontFamily: "Roboto",
              ),
            ),
            SizedBox(height: screenHeight / 150),
            const Text(
              "Don't let the good ones fly away! "
                  "Save Posts to easily find them again"
                  " in the future.",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 11.0,
                color: Colors.black38,
                fontFamily: "Poppins",
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget buildSavedPostItem(
    ModifiedPost? modifiedPost,
    GetDetailedSavedPost? getDetailedSavedPost,
    LoggedInUser loggedInUser,
    context,
  ) {
    if (modifiedPost == null || getDetailedSavedPost == null) {
      return const SizedBox();
    }
    // print("Post id el gy le save: ${modifiedPost.id}");
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // Handling Post Duration
    DateTime? createdAt = modifiedPost.createdAt;
    String? durationText;

    DateTime? createdTime = createdAt;
    DateTime timeNow = DateTime.now();
    Duration difference = timeNow.difference(createdTime);

    if (difference.inMinutes > 59) {
      durationText = '${difference.inHours}h .';
    } else if (difference.inMinutes < 1) {
      durationText = '${difference.inSeconds}s .';
    } else {
      durationText = '${difference.inMinutes.remainder(60)}m .';
    }
    // In Days
    if (difference.inHours >= 24) {
      durationText = '${difference.inDays}d .';
    }

    return Padding(
      padding: EdgeInsets.all(screenWidth / 50),
      child: GestureDetector(
        onTap: () {
          // print("Post ID le detailed post: ${getDetailedSavedPost.postId!}");
          final token = UserLoginCubit.get(context).loginModel?.refresh_token;
          if (token != null) {
            HomeLayoutCubit.get(context).getPostId(
              token: token,
              postId: getDetailedSavedPost.postId!,
            );
            if (modifiedPost.commentsCount > 0) {
              HomeLayoutCubit.get(context).getCommentById(
                token: token,
                postId: getDetailedSavedPost.postId!,
              );
            }
          }

          navigateToPage(context, const DetailedPost());
          // (HomeLayoutCubit.get(context).getPostById is GetPostByIdSuccessState)
          //     ? navigateToPage(context, const DetailedPost())
          //     : const SizedBox();
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 10.0,
                spreadRadius: -5.0,
                offset: const Offset(10.0, 10.0),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(screenWidth / 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        if (modifiedPost.createdBy.id ==
                            UserLoginCubit.get(context).loggedInUser!.id) {
                          navigateToPage(context, const ProfilePage());
                        } else {
                          UserLoginCubit.get(context).anotherUser = AnotherUser(
                            id: '',
                            firstName: '',
                            lastName: '',
                            userName: '',
                            slugUserName: '',
                            email: '',
                            phone: '',
                            role: '',
                            status: '',
                            images: [],
                            address: '',
                            gender: '',
                            locations: [],
                            specification: '',
                            attachments: [],
                            following: [],
                            followers: [],
                            updatedAt: '',
                          );
                          UserLoginCubit.get(context).IdOfSelected =
                              modifiedPost.createdBy.id;
                          HomeLayoutCubit.get(context)
                              .getAnotherUserDatabyHTTP(
                            id: UserLoginCubit.get(context).IdOfSelected ?? "",
                            token: UserLoginCubit.get(context)
                                .loginModel!
                                .refresh_token,
                          )
                              .then((_) {
                            UserLoginCubit.get(context).anotherUser =
                                HomeLayoutCubit.get(context).anotherUser;
                            UserLoginCubit.get(context).inFollowing(
                                followId:
                                UserLoginCubit.get(context).IdOfSelected);
                            navigateToPage(context, const AnotherUserProfile());
                          });
                        }
                      },
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.white,
                        backgroundImage: modifiedPost.createdBy.profilePic !=
                                null
                            ? NetworkImage(modifiedPost.createdBy.profilePic!
                                .secure_url) as ImageProvider
                            : const AssetImage("assets/images/nullProfile.png"),
                      ),
                    ),
                    SizedBox(width: screenWidth / 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            if (modifiedPost.createdBy.id ==
                                UserLoginCubit.get(context).loggedInUser!.id) {
                              navigateToPage(context, const ProfilePage());
                            } else {
                              UserLoginCubit.get(context).anotherUser = AnotherUser(
                                id: '',
                                firstName: '',
                                lastName: '',
                                userName: '',
                                slugUserName: '',
                                email: '',
                                phone: '',
                                role: '',
                                status: '',
                                images: [],
                                address: '',
                                gender: '',
                                locations: [],
                                specification: '',
                                attachments: [],
                                following: [],
                                followers: [],
                                updatedAt: '',
                              );
                              UserLoginCubit.get(context).IdOfSelected =
                                  modifiedPost.createdBy.id;
                              HomeLayoutCubit.get(context)
                                  .getAnotherUserDatabyHTTP(
                                id: UserLoginCubit.get(context).IdOfSelected ?? "",
                                token: UserLoginCubit.get(context)
                                    .loginModel!
                                    .refresh_token,
                              )
                                  .then((_) {
                                UserLoginCubit.get(context).anotherUser =
                                    HomeLayoutCubit.get(context).anotherUser;
                                UserLoginCubit.get(context).inFollowing(
                                    followId:
                                    UserLoginCubit.get(context).IdOfSelected);
                                navigateToPage(context, const AnotherUserProfile());
                              });
                            }
                          },
                          child: Text(
                            modifiedPost.createdBy.userName,
                            style: const TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 0.5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              durationText,
                              style: TextStyle(
                                color: HexColor("B8B9BA"),
                                fontSize: 10.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 2),
                            SvgPicture.asset('assets/images/earthIcon.svg'),
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => _showProfilePageBottomSheet(
                          getDetailedSavedPost, loggedInUser),
                      icon: SvgPicture.asset('assets/images/postSettings.svg'),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/images/closePost.svg'),
                    ),
                  ],
                ),
                const SizedBox(height: 1.0),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: screenHeight / 100,
                    start: screenWidth / 50,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Post Content
                      modifiedPost.content != null
                          ? Text(
                              modifiedPost.content,
                              maxLines:
                                  (modifiedPost.attachments) != null ? 5 : 10,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: "Robot",
                                fontSize: 13.0,
                              ),
                            )
                          : const SizedBox(height: 0),

                      SizedBox(height: screenHeight / 100),

                      /// Post Attachments
                      if (modifiedPost.attachments != null &&
                          modifiedPost.attachments!.isNotEmpty)
                        // check if there's more than one
                        if (modifiedPost.attachments!.length > 1)
                          CarouselSlider(
                            carouselController: carouselController,
                            items: modifiedPost.attachments!.map((attachment) {
                              return Image(
                                image: NetworkImage(attachment.secure_url),
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            }).toList(),
                            options: CarouselOptions(
                              height: 200,
                              viewportFraction: 1.0,
                              enableInfiniteScroll: true,
                              autoPlayCurve: Curves.easeIn,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentImageIndex = index;
                                });
                              },
                            ),
                          )
                        else
                          Image(
                            image: NetworkImage(
                                modifiedPost.attachments![0].secure_url),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: (modifiedPost.attachments ?? [])
                            .asMap()
                            .entries
                            .map((entry) {
                          return GestureDetector(
                            onTap: () =>
                                carouselController.animateToPage(entry.key),
                            child: Container(
                              width: 7.0,
                              height: 7.0,
                              margin: EdgeInsets.symmetric(
                                vertical: screenHeight / 90,
                                horizontal: screenWidth / 100,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentImageIndex == entry.key
                                    ? defaultColor
                                    : Colors.grey,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: screenHeight / 100,
                    start: screenWidth / 500,
                  ),
                  child: Row(
                    children: [
                      /// Post Likes Count
                      (modifiedPost.likesCount) > 0
                          ? IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                'assets/images/NewLikeColor.svg',
                                width: 22.0,
                                height: 22.0,
                              ),
                            )
                          : Container(),
                      (modifiedPost.likesCount > 0)
                          ? Text(
                              '${modifiedPost.likesCount}',
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 12,
                                color: HexColor("575757"),
                              ),
                            )
                          : Container(),
                      const Spacer(),

                      /// Post Comments Count
                      if (modifiedPost.commentsCount == 1)
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 50,
                            bottom: screenHeight / 50,
                          ),
                          child: Text(
                            '${modifiedPost.commentsCount} Comment',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          ),
                        )
                      else if (modifiedPost.likesCount > 0 &&
                          modifiedPost.commentsCount == 1)
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 50,
                          ),
                          child: Text(
                            '${modifiedPost.commentsCount} Comment',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          ),
                        )
                      else if (modifiedPost.likesCount > 0 &&
                          modifiedPost.commentsCount > 1)
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 50,
                          ),
                          child: Text(
                            '${modifiedPost.commentsCount} Comments',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          ),
                        )
                      else if (modifiedPost.commentsCount == 0)
                        Container()
                      else
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 50,
                            bottom: screenHeight / 50,
                          ),
                          child: Text(
                            '${modifiedPost.commentsCount} Comments',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          ),
                        ),

                      /// Post Share Count
                      if (modifiedPost.shareCount == 1)
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 23,
                            bottom: screenHeight / 50,
                          ),
                          child: Text(
                            '${modifiedPost.shareCount} share',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          ),
                        )
                      else if (modifiedPost.shareCount == 0)
                        Container()
                      else
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 23,
                            bottom: screenHeight / 50,
                          ),
                          child: Text(
                            '${modifiedPost.shareCount} Shares',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: screenWidth / 100,
                    end: screenWidth / 100,
                  ),
                  child: Container(
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: screenWidth / 30,
                      end: screenWidth / 30,
                      top: screenHeight / 200,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (getDetailedSavedPost.isLikedByMe == true)
                            ? postSubComponent(
                          "assets/images/NewLikeColor.svg",
                          "  Like",
                          color: HexColor("#2A57AA"),
                          context,
                          onTap: () {
                            HomeLayoutCubit.get(context).likePost(
                              postId: getDetailedSavedPost.id!,
                              token: UserLoginCubit.get(context)
                                  .loginModel!
                                  .refresh_token ??
                                  "",
                              context: context,
                            );
                          },
                        )
                            : postSubComponent(
                          "assets/images/like.svg",
                          "Like",
                          context,
                          onTap: () {
                            HomeLayoutCubit.get(context).likePost(
                                postId: getDetailedSavedPost.id!,
                                token: UserLoginCubit.get(context)
                                    .loginModel!
                                    .refresh_token ??
                                    "",
                                context: context);
                          },
                        ),
                        const Spacer(),
                        postSubComponent(
                          "assets/images/comment.svg",
                          "Comment",
                          context,
                        ),
                        const Spacer(),
                        postSubComponent(
                          "assets/images/share.svg",
                          "Share",
                          context,
                          onTap: () {
                            shareSubComponent(modifiedPost, context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showProfilePageBottomSheet(
      GetDetailedSavedPost? getDetailedSavedPost, LoggedInUser loggedInUser) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        var screenHeight = MediaQuery.of(context).size.height;
        var screenWidth = MediaQuery.of(context).size.width;

        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: screenHeight / 5.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// Remove Post
                  ListTile(
                    leading: const Icon(
                      Icons.delete_forever,
                      size: 25,
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Remove Post',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: screenHeight / 130),
                        const Text(
                          'Remove Post From Your Saved List.',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Logic to remove saved post
                      // print("Post id el hytms7 mn el save: ${getDetailedSavedPost!.postId!}");
                      SavedPostsCubit.get(context).removeSavedPost(
                        token: UserLoginCubit.get(context)
                                .loginModel!
                                .refresh_token ??
                            "",
                        postId: getDetailedSavedPost!.postId!,
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: defaultColor,
                        content: Text(
                          'Post removed',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ));
                    },
                  ),
                  /// Copy Post URL
                  ListTile(
                    leading: const Icon(
                      Icons.copy,
                      size: 25,
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Copy link',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: screenHeight / 130),
                        const Text(
                          'Copy post URL.',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Logic to Copy post link
                      Navigator.pop(context);
                      _copyUrl(
                        "https://volunhero.onrender.com/${getDetailedSavedPost!.id}",
                        context,
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(top: screenHeight / 200),
              child: Container(
                width: screenWidth / 10,
                height: 2.0,
                color: Colors.black54,
              ),
            ),
          ],
        );
      },
    );
  }

  void shareSubComponent(ModifiedPost? postDetails, context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: screenHeight / 5.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: screenWidth / 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        HomeLayoutCubit.get(context).sharePost(
                          token: UserLoginCubit.get(context)
                                  .loginModel!
                                  .refresh_token ??
                              "",
                          postId: postDetails!.id,
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: defaultColor,
                          content: Text(
                            'Post Shared',
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ));
                      },
                      child: Container(
                        width: double.infinity,
                        height: screenHeight / 20,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: screenWidth / 55),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: SvgPicture.asset(
                                  "assets/images/share.svg",
                                  width: 30.0,
                                  height: 30.0,
                                ),
                              ),
                              SizedBox(width: screenWidth / 60),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Share Now',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 1.0),
                                  Text(
                                    'Instantly bring this post to others\' feeds.',
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight / 55),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: screenWidth / 1.09,
                        height: screenHeight / 20,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(top: screenHeight / 200),
              child: Container(
                width: screenWidth / 10,
                height: 2.0,
                color: Colors.black54,
              ),
            ),
          ],
        );
      },
    );
  }

  void _copyUrl(String url, BuildContext context) {
    Clipboard.setData(ClipboardData(text: url));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: defaultColor,
        content: Text(
          'Post URL copied to clipboard',
          style: TextStyle(
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
