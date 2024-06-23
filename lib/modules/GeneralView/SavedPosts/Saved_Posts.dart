import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/states.dart';
import 'package:flutter_code/bloc/savedPosts_bloc/cubit.dart';
import 'package:flutter_code/bloc/savedPosts_bloc/states.dart';
import 'package:flutter_code/layout/VolunHeroUserLayout/layout.dart';
import 'package:flutter_code/models/LoggedInUserModel.dart';
import 'package:flutter_code/models/OwnerPostsModel.dart';
import 'package:flutter_code/models/getAllSavedPostsModel.dart';
import 'package:flutter_code/modules/GeneralView/DetailedPost/Detailed_Post.dart';
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
  Widget build(BuildContext context) {
    return BlocConsumer<UserLoginCubit, UserLoginStates>(
        listener: (context, states) {},
        builder: (context, states) {
          return BlocConsumer<HomeLayoutCubit, LayoutStates>(
            listener: (context, states) {},
            builder: (context, states) {
              return BlocConsumer<SavedPostsCubit, SavedPostsStates>(
                listener: (context, states) {},
                builder: (context, states) {
                  final homeCubit = HomeLayoutCubit.get(context);
                  final loginCubit = UserLoginCubit.get(context);
                  final savedPostsCubit = SavedPostsCubit.get(context);

                  return Scaffold(
                    backgroundColor: Colors.grey[200],
                    appBar: AppBar(
                      backgroundColor: Colors.grey[200],
                      leading: IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/arrowLeft.svg',
                        ),
                        color: HexColor("858888"),
                        onPressed: () {
                          navigateAndFinish(
                              context, const VolunHeroUserLayout());
                        },
                      ),
                      title: StrokeText(
                        text: "Saved Posts",
                        strokeColor: Colors.white,
                        textStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                            color: HexColor("296E6F")),
                      ),
                    ),
                    body: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final posts = savedPostsCubit.getSavedPostsResponse?.savedPosts;
                              if (posts != null && posts.isNotEmpty) {
                                final detailedPosts = posts.expand((savedPost) => savedPost.posts ?? []).toList();

                                if (index < detailedPosts.length) {
                                  final post = detailedPosts[index];
                                  return buildPostItem(
                                    homeCubit.ownerPostsModel!.newPosts[index],
                                    post,
                                    loginCubit.loggedInUserData!.doc,
                                    context,
                                  );
                                }
                              }
                              return const Center(
                                child: Text(
                                  "No Saved Posts",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Padding(
                              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                              child: Container(
                                width: double.infinity,
                                color: Colors.white,
                              ),
                            ),
                            itemCount: savedPostsCubit.getSavedPostsResponse?.savedPosts?.expand((savedPost) => savedPost.posts ?? []).length ?? 1,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        });
  }

  Widget buildPostItem(Posts? postDetails, GetDetailedSavedPost? getDetailedSavedPost,
      LoggedInUser loggedInUser, context) {
    if (postDetails == null || getDetailedSavedPost == null) {
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
                (postDetails!.createdBy.userName != loggedInUser.userName)
                    ? Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: screenWidth / 70,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.turn_right_outlined,
                              color: Colors.grey,
                              size: 18.0,
                            ),
                            SizedBox(width: screenWidth / 50),
                            const Text(
                              "reposted this",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(height: 1),
                SizedBox(height: screenHeight / 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: postDetails.createdBy.profilePic != null
                          ? AssetImage(postDetails.createdBy.profilePic!)
                          : const AssetImage('assets/images/nullProfile.png'),
                    ),
                    SizedBox(width: screenWidth / 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          postDetails.createdBy.userName,
                          style: const TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
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
                            SvgPicture.asset(
                              'assets/images/earthIcon.svg',
                            ),
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () =>
                          _showProfilePageBottomSheet(getDetailedSavedPost, loggedInUser),
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
                                  (postDetails.attachments) != null ? 6 : 10,
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
                                postDetails.attachments![0].secure_url),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: (postDetails.attachments ?? [])
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
                      /// Post Likes
                      (postDetails.likesCount) > 0
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

                      /// Post Comments
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
                        if (postDetails.likesCount > 0 &&
                            loggedInUser.id != postDetails.createdBy.id)
                          postSubComponent(
                            "assets/images/NewLikeColor.svg",
                            " Like",
                            color: HexColor("4267B2"),
                            onTap: () {
                              HomeLayoutCubit.get(context).likePost(
                                  postId: postDetails.id,
                                  token: UserLoginCubit.get(context)
                                          .loginModel!
                                          .refresh_token ??
                                      "");
                            },
                          )
                        else if (postDetails.likesCount > 0 &&
                            loggedInUser.id == postDetails.createdBy.id)
                          postSubComponent(
                            "assets/images/NewLikeColor.svg",
                            " Like",
                            color: HexColor("4267B2"),
                            onTap: () {
                              HomeLayoutCubit.get(context).likePost(
                                  postId: postDetails.id,
                                  token: UserLoginCubit.get(context)
                                          .loginModel!
                                          .refresh_token ??
                                      "");
                            },
                          )
                        else
                          postSubComponent(
                            "assets/images/like.svg",
                            "Like",
                            onTap: () {
                              HomeLayoutCubit.get(context).likePost(
                                  postId: postDetails.id,
                                  token: UserLoginCubit.get(context)
                                          .loginModel!
                                          .refresh_token ??
                                      "");
                            },
                          ),
                        const Spacer(),
                        postSubComponent(
                            "assets/images/comment.svg", "Comment"),
                        const Spacer(),
                        postSubComponent(
                          "assets/images/share.svg",
                          "Share",
                          onTap: () {
                            HomeLayoutCubit.get(context).sharePost(
                                postId: postDetails.id,
                                token: UserLoginCubit.get(context)
                                        .loginModel!
                                        .refresh_token ??
                                    "");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: defaultColor,
                                content: Text(
                                  'Post is shared',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            );
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

  Widget postSubComponent(String assetIcon, String action,
      {GestureTapCallback? onTap,
      Color color = const Color(0xFF575757),
      FontWeight fontWeight = FontWeight.w300}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            assetIcon,
            color: color,
          ),
          const SizedBox(width: 1),
          Text(
            action,
            style: TextStyle(
              fontSize: 12,
              fontFamily: "Roboto",
              color: color,
              fontWeight: fontWeight,
            ),
          )
        ],
      ),
    );
  }

  void _showProfilePageBottomSheet(
      GetDetailedSavedPost? getDetailedSavedPost, LoggedInUser loggedInUser) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        var screenHeight = MediaQuery.of(context).size.height;

        return SizedBox(
          height: screenHeight / 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /// Edit Post
              ListTile(
                leading: const Icon(
                  Icons.edit,
                  size: 25,
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Edit Post',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenHeight / 130),
                    const Text(
                      'Edit your post.',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // Logic to edit post
                  Navigator.pop(context);
                },
              ),
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
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
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
                  // HomeLayoutCubit.get(context).deletePost(
                  //     token: UserLoginCubit.get(context)
                  //         .loginModel!
                  //         .refresh_token ??
                  //         "",
                  //     postId: getSavedPost!.id);
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
            ],
          ),
        );
      },
    );
  }
}
