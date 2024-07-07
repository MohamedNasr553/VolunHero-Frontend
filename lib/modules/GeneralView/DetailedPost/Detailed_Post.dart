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
import 'package:flutter_code/models/GetCommentModel.dart';
import 'package:flutter_code/models/GetPostByIdModel.dart';
import 'package:flutter_code/models/LoggedInUserModel.dart';
import 'package:flutter_code/modules/GeneralView/ReactionsPage/reactionsPage.dart';
import 'package:flutter_code/modules/GeneralView/AnotherUser/anotherUser_page.dart';
import 'package:flutter_code/modules/GeneralView/ProfilePage/Profile_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

class DetailedPost extends StatefulWidget {
  const DetailedPost({super.key});

  @override
  State<DetailedPost> createState() => _DetailedPostState();
}

class _DetailedPostState extends State<DetailedPost> {
  final commentController = TextEditingController();
  final CarouselController carouselController = CarouselController();
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    final user = HomeLayoutCubit.get(context).addComment;
    if (user != null) {
      commentController.text = user.content!;
    }
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLoginCubit, UserLoginStates>(
        listener: (context, states) {},
        builder: (context, states) {
          return BlocConsumer<HomeLayoutCubit, LayoutStates>(
            listener: (context, states) {},
            builder: (context, states) {
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
                        'Post Shared',
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
                      leading: IconButton(
                        icon: SvgPicture.asset('assets/images/arrowLeft.svg'),
                        color: HexColor("858888"),
                        onPressed: () =>
                            navigateToPage(context, const VolunHeroLayout()),
                      ),
                    ),
                    body: HomeLayoutCubit.get(context).getPostById?.post != null
                        ? buildDetailedPostItem(
                            HomeLayoutCubit.get(context).getPostById?.post,
                            UserLoginCubit.get(context)
                                .loggedInUserModel!
                                .data
                                .doc,
                            HomeLayoutCubit.get(context).comment,
                            context,
                          )
                        : const SizedBox(),
                  );
                },
              );
            },
          );
        });
  }

  Widget buildDetailedPostItem(SpecificPost? specificPost,
      LoggedInUser loggedInUser, Comment? commentModel, context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // Handling Post Duration
    DateTime? createdAt = specificPost!.createdAt;
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

    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth / 35),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight / 300),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 10.0,
                      spreadRadius: -5.0,
                      offset: const Offset(10.0, 10.0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenHeight / 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (specificPost.sharedFrom != null)
                          ? Column(
                              children: [
                                SizedBox(height: screenHeight / 120),
                                sharedByUserInfo(
                                    specificPost, loggedInUser, context),
                              ],
                            )
                          : const SizedBox(),
                      SizedBox(height: screenHeight / 120),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /// Profile Pic
                          CircleAvatar(
                            radius: 20.0,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                specificPost.createdBy.profilePic != null
                                    ? NetworkImage(specificPost
                                        .createdBy
                                        .profilePic!
                                        .secure_url) as ImageProvider
                                    : const AssetImage(
                                        "assets/images/nullProfile.png"),
                          ),
                          SizedBox(width: screenWidth / 50),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Username
                              InkWell(
                                onTap: () {
                                  if (specificPost.createdBy.id ==
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
                                    UserLoginCubit.get(context).idOfSelected =
                                        specificPost.createdBy.id;
                                    HomeLayoutCubit.get(context)
                                        .getAnotherUserDatabyHTTP(
                                      id: UserLoginCubit.get(context).idOfSelected ?? "",
                                      token: UserLoginCubit.get(context)
                                          .loginModel!
                                          .refresh_token,
                                    )
                                        .then((_) {
                                      UserLoginCubit.get(context).anotherUser =
                                          HomeLayoutCubit.get(context).anotherUser;
                                      UserLoginCubit.get(context).inFollowing(
                                          followId:
                                          UserLoginCubit.get(context).idOfSelected);
                                      navigateToPage(context, const AnotherUserProfile());
                                    });
                                  }
                                },
                                child: Text(
                                  specificPost.createdBy.userName,
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
                                      fontSize: 9,
                                    ),
                                  ),
                                  SizedBox(width: screenWidth / 70),
                                  SvgPicture.asset(
                                      'assets/images/earthIcon.svg'),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),

                          /// Post Settings
                          IconButton(
                            onPressed: () {
                              _showHomePageBottomSheet(specificPost, context);
                            },
                            icon: SvgPicture.asset(
                              'assets/images/postSettings.svg',
                            ),
                          ),

                          /// Hide Post
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              'assets/images/closePost.svg',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 1),
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
                            Text(
                              specificPost.content!,
                              maxLines:
                                  (specificPost.attachments!) != null ? 6 : 10,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: "Robot",
                                fontSize: 13.0,
                              ),
                            ),
                            SizedBox(height: screenHeight / 100),

                            /// Post Attachments
                            if (specificPost.attachments!.isNotEmpty)
                              // check if there's more than one
                              if (specificPost.attachments!.length > 1)
                                CarouselSlider(
                                  carouselController: carouselController,
                                  items: specificPost.attachments!
                                      .map((attachment) {
                                    return Image(
                                      image:
                                          NetworkImage(attachment.secure_url),
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
                                    specificPost.attachments![0].secure_url,
                                  ),
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: specificPost.attachments!
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                return GestureDetector(
                                  onTap: () => carouselController
                                      .animateToPage(entry.key),
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
                            GestureDetector(
                              onTap: () {
                                HomeLayoutCubit.get(context).getLikesOnPost(
                                  token: UserLoginCubit.get(context)
                                          .loginModel!
                                          .refresh_token ??
                                      "",
                                  postId: specificPost.id!,
                                );
                                navigateToPage(context, const ReactionsPage());
                              },
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(
                                  bottom: screenHeight / 70,
                                ),
                                child: Container(
                                  color: Colors.white,
                                  height: screenHeight / 30,
                                  width: screenWidth / 6,
                                  child: Row(
                                    children: [
                                      SizedBox(width: screenWidth / 50),
                                      (specificPost.likesCount! > 0)
                                          ? SvgPicture.asset(
                                              'assets/images/NewLikeColor.svg',
                                              width: 22.0,
                                              height: 22.0,
                                            )
                                          : Container(),
                                      SizedBox(width: screenWidth / 40),
                                      (specificPost.likesCount! > 0)
                                          ? Text(
                                              '${specificPost.likesCount}',
                                              style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontSize: 12,
                                                color: HexColor("575757"),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),

                            /// Post Comments Count
                            if (specificPost.commentsCount == 1)
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: screenWidth / 50,
                                  end: screenWidth / 50,
                                  bottom: screenHeight / 50,
                                ),
                                child: Text(
                                  '${specificPost.commentsCount} Comment',
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 12,
                                    color: HexColor("575757"),
                                  ),
                                ),
                              )
                            else if (specificPost.likesCount! > 0 &&
                                specificPost.commentsCount == 1)
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: screenWidth / 50,
                                  end: screenWidth / 50,
                                ),
                                child: Text(
                                  '${specificPost.commentsCount} Comment',
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 12,
                                    color: HexColor("575757"),
                                  ),
                                ),
                              )
                            else if (specificPost.likesCount! > 0 &&
                                specificPost.commentsCount! > 1)
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: screenWidth / 50,
                                  end: screenWidth / 50,
                                ),
                                child: Text(
                                  '${specificPost.commentsCount} Comments',
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 12,
                                    color: HexColor("575757"),
                                  ),
                                ),
                              )
                            else if (specificPost.commentsCount == 0)
                              Container()
                            else
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: screenWidth / 50,
                                  end: screenWidth / 50,
                                  bottom: screenHeight / 50,
                                ),
                                child: Text(
                                  '${specificPost.commentsCount} Comments',
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 12,
                                    color: HexColor("575757"),
                                  ),
                                ),
                              ),

                            /// Post Share Count
                            if (specificPost.shareCount == 1)
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: screenWidth / 50,
                                  end: screenWidth / 23,
                                  bottom: screenHeight / 300,
                                ),
                                child: Text(
                                  '${specificPost.shareCount} share',
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 12,
                                    color: HexColor("575757"),
                                  ),
                                ),
                              )
                            else if (specificPost.shareCount == 0)
                              Container()
                            else
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: screenWidth / 50,
                                  end: screenWidth / 23,
                                  bottom: screenHeight / 300,
                                ),
                                child: Text(
                                  '${specificPost.shareCount} Shares',
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
                              (specificPost.isLikedByMe == true)
                                  ? postSubComponent(
                                      "assets/images/NewLikeColor.svg",
                                      "  Like",
                                      color: HexColor("#2A57AA"),
                                      context,
                                      onTap: () {
                                        HomeLayoutCubit.get(context).likePost(
                                          postId: specificPost.id!,
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
                                            postId: specificPost.id!,
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
                                  shareSubComponent(specificPost, context);
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
            SizedBox(height: screenHeight / 60),
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
            SizedBox(height: screenHeight / 100),
            Padding(
              padding: EdgeInsetsDirectional.only(
                top: screenHeight / 80,
                bottom: screenHeight / 40,
              ),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var comments = HomeLayoutCubit.get(context)
                      .getCommentsResponse
                      ?.comments;
                  if (comments == null || comments.isEmpty) {
                    return Container();
                  }
                  return buildCommentItem(
                      comments[index], specificPost, context);
                },
                separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                      vertical: screenHeight / 80),
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),
                itemCount: HomeLayoutCubit.get(context)
                        .getCommentsResponse
                        ?.comments
                        .length ??
                    0,
              ),
            ),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: screenHeight / 15,
            width: screenWidth,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            padding: EdgeInsetsDirectional.only(
              start: screenWidth / 30,
              end: screenWidth / 30,
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(start: screenWidth / 60),
                  child: TextField(
                    controller: commentController,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Write a comment...',
                      hintStyle: TextStyle(fontSize: 12.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    HomeLayoutCubit.get(context).createComment(
                      content: commentController.text,
                      token: UserLoginCubit.get(context)
                              .loginModel!
                              .refresh_token ??
                          "",
                      postId: specificPost.id!,
                    );
                    navigateToPage(context, const DetailedPost());
                  },
                  child: const Icon(
                    Icons.send,
                    size: 20,
                    color: defaultColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCommentItem(
      Comment? commentModel, SpecificPost? specificPost, context) {
    if (commentModel == null) {
      return Container();
    }

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    // Handling Post Duration
    DateTime? createdAt = commentModel.createdAt;
    String? durationText;

    DateTime createdTime = createdAt;
    DateTime timeNow = DateTime.now();
    Duration difference = timeNow.difference(createdTime);

    if (difference.inMinutes > 59) {
      durationText = '${difference.inHours}h';
    } else if (difference.inMinutes < 1) {
      durationText = '${difference.inSeconds}s';
    } else {
      durationText = '${difference.inMinutes.remainder(60)}m';
    }
    // In Days
    if (difference.inHours >= 24) {
      durationText = '${difference.inDays}d';
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Profile Pic
            CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.white,
              backgroundImage: commentModel.createdBy.profilePic != null
                  ? NetworkImage(commentModel.createdBy.profilePic!.secure_url)
                      as ImageProvider
                  : const AssetImage("assets/images/nullProfile.png"),
            ),
            SizedBox(width: screenWidth / 40),
            Expanded(
              child: Container(
                height: screenHeight / 14.5,
                decoration: BoxDecoration(
                  color: Colors.white70.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5.0,
                      spreadRadius: -2.0,
                      offset: const Offset(1.0, 1.0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: screenWidth / 25,
                    top: screenHeight / 120,
                    bottom: screenHeight / 120,
                    end: screenWidth / 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Comment UserName, Author Text
                      Row(
                        children: [
                          Text(
                            commentModel.createdBy.userName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto",
                            ),
                          ),
                          (commentModel.createdBy.id ==
                                  specificPost!.createdBy.id)
                              ? const Spacer()
                              : const Spacer(),
                          (commentModel.createdBy.id ==
                                  specificPost.createdBy.id)
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: defaultColor.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      start: screenWidth / 60,
                                      end: screenWidth / 60,
                                      top: screenHeight / 500,
                                      bottom: screenHeight / 500,
                                    ),
                                    child: const Text(
                                      "Author",
                                      style: TextStyle(
                                        fontSize: 9.5,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          SizedBox(width: screenWidth / 30),
                          GestureDetector(
                            onTap: () {
                              _showCommentBottomSheet(commentModel, context);
                            },
                            child: Container(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              child: const Icon(
                                Icons.more_horiz,
                                size: 15.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight / 300),

                      /// Comment Content
                      Text(
                        commentModel.content,
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: "Roboto",
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight / 200),
        Padding(
          padding: EdgeInsetsDirectional.only(
            start: screenWidth / 7,
            top: screenHeight / 200,
          ),
          child: Row(
            children: [
              // CreatedAt
              Text(
                durationText,
                style: const TextStyle(
                  fontSize: 11,
                  fontFamily: "Roboto",
                ),
              ),
              SizedBox(width: screenWidth / 13),
              // Like
              InkWell(
                onTap: () {
                  HomeLayoutCubit.get(context).likePost(
                      postId: specificPost.id!,
                      token: UserLoginCubit.get(context)
                              .loginModel!
                              .refresh_token ??
                          "",
                      context: context);
                },
                child: const Text(
                  "Like",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showHomePageBottomSheet(SpecificPost? specificPost, context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        var screenHeight = MediaQuery.of(context).size.height;
        var screenWidth = MediaQuery.of(context).size.width;

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
                      // Logic to save the post
                      SavedPostsCubit.get(context).savePost(
                        token: UserLoginCubit.get(context)
                                .loginModel!
                                .refresh_token ??
                            "",
                        postId: specificPost!.id!,
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
                    onTap: () {},
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
                      _copyUrl(
                        "https://volunhero.onrender.com/${specificPost!.id}",
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

  void _showCommentBottomSheet(Comment? comment, context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        var screenHeight = MediaQuery.of(context).size.height;
        var screenWidth = MediaQuery.of(context).size.width;

        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: screenHeight / 9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.delete,
                      size: 25,
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: screenHeight / 130),
                        const Text(
                          'Delete Comment',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Logic to delete Comment
                      HomeLayoutCubit.get(context).deleteComment(
                        token: UserLoginCubit.get(context)
                                .loginModel!
                                .refresh_token ??
                            "",
                        postId: comment!.postId,
                        commentId: comment.id,
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: defaultColor,
                        content: Text(
                          'Comment Deleted',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ));
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

  Widget sharedByUserInfo(SpecificPost? postDetails, LoggedInUser loggedInUser,
      BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        if (postDetails.sharedBy!.id ==
            UserLoginCubit.get(context).loggedInUser!.id) {
          navigateToPage(context, const ProfilePage());
        } else {
          HomeLayoutCubit.get(context)
              .getAnotherUserData(
                  token: UserLoginCubit.get(context).loginModel!.refresh_token,
                  id: postDetails.sharedBy!.id)
              .then((value) {
            UserLoginCubit.get(context)
                .getAnotherUserPosts(
                    token:
                        UserLoginCubit.get(context).loginModel!.refresh_token,
                    id: postDetails.sharedBy!.id,
                    userName: postDetails.sharedBy!.userName)
                .then((value) {
              UserLoginCubit.get(context).anotherUser =
                  HomeLayoutCubit.get(context).anotherUser;
              navigateToPage(context, const AnotherUserProfile());
            });
          });
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

  void shareSubComponent(SpecificPost? postDetails, context) {
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
                          postId: postDetails!.id!,
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
