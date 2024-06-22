import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/states.dart';
import 'package:flutter_code/layout/VolunHeroUserLayout/layout.dart';
import 'package:flutter_code/models/GetCommentModel.dart';
import 'package:flutter_code/models/GetPostByIdModel.dart';
import 'package:flutter_code/models/LoggedInUserModel.dart';
import 'package:flutter_code/modules/UserView/AnotherUser/anotherUser_page.dart';
import 'package:flutter_code/modules/UserView/UserProfilePage/Profile_Page.dart';
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
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: SvgPicture.asset('assets/images/arrowLeft.svg'),
                    color: HexColor("858888"),
                    onPressed: () =>
                        navigateToPage(context, const VolunHeroUserLayout()),
                  ),
                ),
                body: HomeLayoutCubit.get(context).getPostById?.post != null
                    ? buildDetailedPostItem(
                        HomeLayoutCubit.get(context).getPostById?.post,
                        UserLoginCubit.get(context).loggedInUserModel!.data.doc,
                        HomeLayoutCubit.get(context).comment,
                        context,
                      )
                    : const SizedBox(),
              );
            },
          );
        });
  }

  Widget buildDetailedPostItem(SpecificPost? specificPost,
      LoggedInUser loggedInUser, Comment? commentModel, context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var commentController = TextEditingController();

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
              padding: EdgeInsets.symmetric(vertical: screenHeight / 100),
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
                  padding: EdgeInsets.all(screenHeight / 300),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /// Profile Pic
                          CircleAvatar(
                            radius: 20.0,
                            backgroundImage: (specificPost
                                        .createdBy.profilePic !=
                                    null)
                                ? AssetImage(specificPost.createdBy.profilePic!)
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
                                      UserLoginCubit.get(context)
                                          .loggedInUser!
                                          .id) {
                                    navigateToPage(
                                        context, const ProfilePage());
                                  } else {
                                    HomeLayoutCubit.get(context)
                                        .getAnotherUserData(
                                      token: UserLoginCubit.get(context)
                                          .loginModel!
                                          .refresh_token,
                                      id: specificPost.createdBy.id,
                                    )
                                        .then((value) {
                                      UserLoginCubit.get(context)
                                          .getAnotherUserPosts(
                                        token: UserLoginCubit.get(context)
                                            .loginModel!
                                            .refresh_token,
                                        id: specificPost.createdBy.id,
                                        userName:
                                            specificPost.createdBy.userName,
                                      )
                                          .then((value) {
                                        UserLoginCubit.get(context)
                                                .anotherUser =
                                            HomeLayoutCubit.get(context)
                                                .anotherUser;
                                        navigateToPage(context,
                                            const AnotherUserProfile());
                                      });
                                    });
                                  }
                                },
                                child: Text(
                                  specificPost.createdBy.userName,
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
                                      fontSize: 10,
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
                              _showHomePageBottomSheet(context);
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
                            /// Post Likes
                            (specificPost.likesCount!) > 0
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
                            (specificPost.likesCount! > 0)
                                ? Text(
                                    '${specificPost.likesCount!}',
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 12,
                                      color: HexColor("575757"),
                                    ),
                                  )
                                : Container(),
                            const Spacer(),

                            /// Post Comments
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
                              postSubComponent(
                                "assets/images/like.svg",
                                "Like",
                                onTap: () {
                                  HomeLayoutCubit.get(context).likePost(
                                      postId: specificPost.id!,
                                      token: UserLoginCubit.get(context)
                                              .loginModel!
                                              .refresh_token ??
                                          "");
                                },
                              ),
                              const Spacer(),
                              postSubComponent(
                                  "assets/images/comment.svg", "Comment",
                                  onTap: () {}),
                              const Spacer(),
                              postSubComponent(
                                "assets/images/share.svg",
                                "Share",
                                onTap: () {
                                  HomeLayoutCubit.get(context).sharePost(
                                      postId: specificPost.id!,
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
            SizedBox(height: screenHeight / 40),
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
            SizedBox(height: screenHeight / 100),
            Padding(
              padding: EdgeInsetsDirectional.only(
                top: screenHeight / 80,
                bottom: screenHeight / 40, // Adjust spacing from the bottom
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
          bottom: screenHeight / 80,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth / 40),
            child: Container(
              height: screenHeight / 19,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40.0),
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
                    onTap: (){
                      HomeLayoutCubit.get(context).createComment(
                        content: commentController.text,
                        token: UserLoginCubit.get(context)
                            .loginModel!
                            .refresh_token ??
                            "",
                        postId: specificPost.id!,
                      );
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
        ),
      ],
    );
  }

  Widget buildCommentItem(Comment? commentModel, SpecificPost? specificPost, context) {
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
              backgroundImage: (commentModel.createdBy.profilePic != null)
                  ? AssetImage(commentModel.createdBy.profilePic!)
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
                          (commentModel.createdBy.id == specificPost.createdBy.id)
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
                              _showCommentBottomSheet(context);
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
                      postId: specificPost!.id!,
                      token: UserLoginCubit.get(context)
                          .loginModel!
                          .refresh_token ??
                          "");
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

  void _showHomePageBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        var screenHeight = MediaQuery.of(context).size.height;

        return SizedBox(
          height: screenHeight / 3,
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
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
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
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
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
                  // Logic to save the post
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
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
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
                  // Logic to save the post
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCommentBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        var screenHeight = MediaQuery.of(context).size.height;

        return SizedBox(
          height: screenHeight / 8,
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
                  // Logic to delete the post
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
