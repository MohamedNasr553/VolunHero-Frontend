import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Layout_bloc/cubit.dart';
import 'package:flutter_code/bloc/Layout_bloc/states.dart';
import 'package:flutter_code/bloc/savedPosts_bloc/cubit.dart';
import 'package:flutter_code/bloc/savedPosts_bloc/states.dart';
import 'package:flutter_code/models/HomePagePostsModel.dart';
import 'package:flutter_code/models/LoggedInUserModel.dart';
import 'package:flutter_code/modules/GeneralView/Chats/chatPage.dart';
import 'package:flutter_code/modules/GeneralView/DetailedPost/Detailed_Post.dart';
import 'package:flutter_code/modules/GeneralView/SearchPosts/searchPosts.dart';
import 'package:flutter_code/modules/GeneralView/AnotherUser/anotherUser_page.dart';
import 'package:flutter_code/modules/GeneralView/Drawer/drawer.dart';
import 'package:flutter_code/modules/GeneralView/ProfilePage/Profile_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../models/AnotherUserModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController carouselController = CarouselController();
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    if (UserLoginCubit.get(context).loginModel!.refresh_token != null &&
        UserLoginCubit.get(context).loginModel!.refresh_token!.isNotEmpty) {
      HomeLayoutCubit.get(context).getAllPosts(
          token: UserLoginCubit.get(context).loginModel!.refresh_token ?? "");
      UserLoginCubit.get(context).getLoggedInUserData(
          token: UserLoginCubit.get(context).loginModel!.refresh_token);
      UserLoginCubit.get(context).getLoggedInChats(
          token: UserLoginCubit.get(context).loginModel!.refresh_token);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<HomeLayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<SavedPostsCubit, SavedPostsStates>(
          listener: (context, state) {
            if (state is SavedPostsSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: defaultColor,
                content: Text(
                  'Post saved',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ));
            } else if (state is SavedPostsErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: defaultColor,
                content: Text(
                  'Post already saved',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ));
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: Builder(builder: (context) {
                  return Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: screenWidth / 40,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: (UserLoginCubit.get(context).loggedInUser?.profilePic?.secure_url != null)
                            ? NetworkImage(UserLoginCubit.get(context).loggedInUser!.profilePic!.secure_url) as ImageProvider
                            : const AssetImage("assets/images/nullProfile.png"),
                      ),
                    ),
                  );
                }),
                actions: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: screenHeight / 300,
                    ),
                    child: GestureDetector(
                      onTap: () =>
                          navigateAndFinish(context, const SearchPostsPage()),
                      child: Container(
                        width: screenWidth / 1.48,
                        height: screenHeight / 25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 40,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.search,
                                size: 23.0,
                                color: Colors.grey,
                              ),
                              SizedBox(width: screenWidth / 50),
                              const Text(
                                'Search...',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: screenHeight / 300,
                      start: screenWidth / 80,
                      end: screenWidth / 60,
                    ),
                    child: IconButton(
                        onPressed: () {
                          //  navigateToPage(context, ChatsPage());
                          UserLoginCubit.get(context)
                              .getLoggedInChats(
                                  token: UserLoginCubit.get(context)
                                      .loginModel!
                                      .refresh_token)
                              .then((value) {
                            navigateToPage(context, const ChatsPage());
                          });
                        },
                        icon:
                            SvgPicture.asset("assets/images/messagesIcon.svg")),
                  ),
                ],
              ),
              drawer: const UserSidePage(),
              body: (state is! HomePagePostsLoadingState)
                  ? buildPostsList(context)
                  : buildLoadingWidget(
                      HomeLayoutCubit.get(context)
                              .homePagePostsModel
                              ?.modifiedPosts
                              .length ??
                          0,
                      context,
                    ),
            );
          },
        );
      },
    );
  }

  Widget buildPostsList(context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var homeCubit = HomeLayoutCubit.get(context);
    var loggedInUserCubit = UserLoginCubit.get(context);

    if (homeCubit.homePagePostsModel != null) {
      if (homeCubit.homePagePostsModel!.modifiedPosts.isNotEmpty) {
        return Column(
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      reverse: true,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final homePagePostsModel = homeCubit.homePagePostsModel;
                        if (homePagePostsModel != null) {
                          if (index < homePagePostsModel.modifiedPosts.length) {
                            return buildPostItem(
                              homePagePostsModel.modifiedPosts[index],
                              loggedInUserCubit.loggedInUserData!.doc,
                              context,
                            );
                          }
                        }
                        return null;
                      },
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 16),
                        child: Container(
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      ),
                      itemCount:
                          homeCubit.homePagePostsModel!.modifiedPosts.length,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      } else {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.post_add,
                size: 60,
                color: Colors.black54,
              ),
              SizedBox(height: screenHeight / 100),
              const Text(
                "No posts available right now",
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Roboto",
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: screenHeight / 200),
              const Text(
                "Posts "
                "and attachments will "
                "show up here.",
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Roboto",
                  color: Colors.black38,
                ),
              ),
            ],
          ),
        );
      }
    } else {
      return buildLoadingWidget(
          HomeLayoutCubit.get(context)
                  .homePagePostsModel
                  ?.modifiedPosts
                  .length ??
              0,
          context);
    }
  }

  Widget buildPostItem(ModifiedPost? postDetails, LoggedInUser loggedInUser,
      BuildContext context) {
    if (postDetails == null) {
      return const SizedBox();
    }
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // Handling Post Duration
    DateTime? createdAt = postDetails.createdAt;
    String? durationText;

    DateTime createdTime = createdAt;
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
          final token = UserLoginCubit.get(context).loginModel?.refresh_token;
          final postId = postDetails.id;
          if (token != null) {
            HomeLayoutCubit.get(context).getPostId(
              token: token,
              postId: postId,
            );
            if (postDetails.commentsCount > 0) {
              HomeLayoutCubit.get(context).getCommentById(
                token: token,
                postId: postId,
              );
            }
          }

          navigateToPage(context, const DetailedPost());
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
                offset: const Offset(10.0, 10.0), // Right and bottom shadow
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(screenWidth / 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (postDetails.sharedFrom != null)
                    ? Column(
                        children: [
                          SizedBox(height: screenHeight / 120),
                          sharedByUserInfo(postDetails, loggedInUser, context),
                        ],
                      )
                    : const SizedBox(),
                SizedBox(height: screenHeight / 120),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        if (postDetails.createdBy.id ==
                            UserLoginCubit.get(context).loggedInUser!.id) {
                          navigateToPage(context, const ProfilePage());
                        } else {
                         UserLoginCubit.get(context).anotherUser =  AnotherUser(
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
                         UserLoginCubit.get(context).IdOfSelected = postDetails.createdBy.id;
                         HomeLayoutCubit.get(context).getAnotherUserDatabyHTTP(
                           id:   UserLoginCubit.get(context).IdOfSelected ?? "",
                           token:  UserLoginCubit.get(context).loginModel!.refresh_token ,
                         ).then((_){
                           print(UserLoginCubit.get(context).IdOfSelected);
                           UserLoginCubit.get(context).anotherUser =
                               HomeLayoutCubit.get(context).anotherUser;
                               UserLoginCubit.get(context).inFollowing(followId: UserLoginCubit.get(context).IdOfSelected);
                         navigateToPage(context, const AnotherUserProfile());
                         });
                         print("3amel0 : ${UserLoginCubit.get(context).IdOfSelected}");
                        }
                      },
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundImage: postDetails.createdBy.profilePic !=
                                null
                            ? NetworkImage(postDetails.createdBy.profilePic!
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
                            // if (postDetails.createdBy.id ==
                            //     UserLoginCubit.get(context).loggedInUser!.id) {
                            //   navigateToPage(context, const ProfilePage());
                            // } else {
                            //   HomeLayoutCubit.get(context)
                            //       .getAnotherUserData(
                            //           token: UserLoginCubit.get(context)
                            //               .loginModel!
                            //               .refresh_token,
                            //           id: postDetails.createdBy.id)
                            //       .then((value) {
                            //     UserLoginCubit.get(context).anotherUser =
                            //         HomeLayoutCubit.get(context).anotherUser;
                            //     navigateToPage(
                            //         context, const AnotherUserProfile());
                            //   });
                            // }
                          },
                          child: Text(
                            postDetails.createdBy.userName,
                            style: const TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
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
                                fontSize: 9.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 2),
                            SvgPicture.asset(
                              'assets/images/earthIcon.svg',
                            ),
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        _showHomePageBottomSheet(postDetails);
                      },
                      icon: SvgPicture.asset(
                        'assets/images/postSettings.svg',
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/images/closePost.svg',
                      ),
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
                      postDetails.content != null
                          ? Text(
                              postDetails.content,
                              maxLines:
                                  (postDetails.attachments) != null ? 5 : 10,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: "Robot",
                                fontSize: 13.0,
                              ),
                            )
                          : const SizedBox(height: 0),

                      SizedBox(height: screenHeight / 100),

                      /// Post Attachments
                      if (postDetails.attachments != null &&
                          postDetails.attachments!.isNotEmpty)
                        // check if there's more than one
                        if (postDetails.attachments!.length > 1)
                          CarouselSlider(
                            carouselController: carouselController,
                            items: postDetails.attachments!.map((attachment) {
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
                              postDetails.attachments![0].secure_url,
                            ),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                      if (postDetails.attachments != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: postDetails.attachments!
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
                      (postDetails.likesCount > 0)
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

                      (postDetails.likesCount > 0)
                          ? Text(
                        '${postDetails.likesCount}',
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 12,
                          color: HexColor("575757"),
                        ),
                      )
                          : Container(),
                      const Spacer(),

                      /// Post Comments Count
                      if (postDetails.commentsCount == 1)
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 50,
                            bottom: screenHeight / 50,
                          ),
                          child: Text(
                            '${postDetails.commentsCount} Comment',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          ),
                        )
                      else if (postDetails.likesCount > 0 &&
                          postDetails.commentsCount == 1)
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 50,
                          ),
                          child: Text(
                            '${postDetails.commentsCount} Comment',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          ),
                        )
                      else if (postDetails.likesCount > 0 &&
                          postDetails.commentsCount > 1)
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 50,
                          ),
                          child: Text(
                            '${postDetails.commentsCount} Comments',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          ),
                        )
                      else if (postDetails.commentsCount == 0)
                        Container()
                      else
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 50,
                            bottom: screenHeight / 50,
                          ),
                          child: Text(
                            '${postDetails.commentsCount} Comments',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          ),
                        ),
                      /// Post Share Count
                      if (postDetails.shareCount == 1)
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 23,
                            bottom: screenHeight / 50,
                          ),
                          child: Text(
                            '${postDetails.shareCount} share',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          ),
                        )
                      else if (postDetails.shareCount == 0)
                        Container()
                      else
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 23,
                            bottom: screenHeight / 50,
                          ),
                          child: Text(
                            '${postDetails.shareCount} Shares',
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
                        (postDetails.isLikedByMe == true)
                            ? postSubComponent(
                                "assets/images/NewLikeColor.svg",
                                "  Like",
                                color: HexColor("#2A57AA"),
                                context,
                                onTap: () {
                                  HomeLayoutCubit.get(context).likePost(
                                      postId: postDetails.id,
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
                                    postId: postDetails.id,
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
                          onTap: () {
                            final token = UserLoginCubit.get(context)
                                .loginModel
                                ?.refresh_token;
                            final postId = postDetails.id;
                            if (token != null) {
                              HomeLayoutCubit.get(context).getPostId(
                                token: token,
                                postId: postId,
                              );
                              if (postDetails.commentsCount > 0) {
                                HomeLayoutCubit.get(context).getCommentById(
                                  token: token,
                                  postId: postId,
                                );
                              }
                            }
                            navigateToPage(context, const DetailedPost());
                          },
                        ),
                        const Spacer(),
                        postSubComponent(
                          "assets/images/share.svg",
                          "Share",
                          context,
                          onTap: () {
                            shareSubComponent(postDetails, context);
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

  void _showHomePageBottomSheet(ModifiedPost? modifiedPost) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        var screenWidth = MediaQuery.of(context).size.width;
        var screenHeight = MediaQuery.of(context).size.height;

        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: screenHeight / 4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.save,
                      size: 25,
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Save Post',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: screenHeight / 130),
                        const Text(
                          'Add this to your saved items.',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // print("Modified to be saved: ");
                      // print(modifiedPost);
                      // Logic to save the post
                      SavedPostsCubit.get(context).savePost(
                        token: UserLoginCubit.get(context)
                                .loginModel!
                                .refresh_token ??
                            "",
                        postId: modifiedPost!.id,
                      );
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.close,
                      size: 25,
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hide Post',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: screenHeight / 130),
                        const Text(
                          'See fewer posts like this.',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Logic to hide post
                      Navigator.pop(context);
                    },
                  ),
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
                        "https://volunhero.onrender.com/${modifiedPost!.id}",
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

  Widget sharedByUserInfo(ModifiedPost? postDetails, LoggedInUser loggedInUser,
      BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        if (postDetails.sharedBy!.id ==
            UserLoginCubit.get(context).loggedInUser!.id) {
          navigateToPage(context, const ProfilePage());
        } else {
          // HomeLayoutCubit.get(context)
          //     .getAnotherUserData(
          //         token: UserLoginCubit.get(context).loginModel!.refresh_token,
          //         id: postDetails.sharedBy!.id)
          //     .then((value) {
          //   UserLoginCubit.get(context)
          //       .getAnotherUserPosts(
          //           token:
          //               UserLoginCubit.get(context).loginModel!.refresh_token,
          //           id: postDetails.sharedBy!.id,
          //           userName: postDetails.sharedBy!.userName)
          //       .then((value) {
          //     UserLoginCubit.get(context).anotherUser =
          //         HomeLayoutCubit.get(context).anotherUser;
          //     navigateToPage(context, const AnotherUserProfile());
          //   });
          // });
        }
      },
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: screenWidth / 40,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                "assets/images/share.svg",
                width: 18.0,
                height: 18.0,
              ),
            ),
            SizedBox(width: screenWidth / 80),
            CircleAvatar(
              radius: 10.0,
              backgroundImage: postDetails!.sharedBy!.profilePic != null
                  ? NetworkImage(postDetails.sharedBy!.profilePic!.secure_url)
                      as ImageProvider
                  : const AssetImage("assets/images/nullProfile.png"),
            ),
            SizedBox(width: screenWidth / 80),
            Text(
              (postDetails.sharedBy!.userName == loggedInUser.userName)
                  ? 'You'
                  : postDetails.sharedBy!.userName,
              style: const TextStyle(
                fontFamily: "Roboto",
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
            SizedBox(width: screenWidth / 150),
            const Text(
              'shared this',
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
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
