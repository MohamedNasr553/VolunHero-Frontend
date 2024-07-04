import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/bloc/Layout_bloc/cubit.dart';
import 'package:flutter_code/bloc/Layout_bloc/states.dart';
import 'package:flutter_code/bloc/savedPosts_bloc/cubit.dart';
import 'package:flutter_code/models/GetPostByIdModel.dart';
import 'package:flutter_code/models/LoggedInUserModel.dart';
import 'package:flutter_code/modules/GeneralView/AnotherUser/anotherUser_page.dart';
import 'package:flutter_code/modules/GeneralView/ProfilePage/Profile_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

class EditPost extends StatefulWidget {
  const EditPost({super.key});

  @override
  State<EditPost> createState() => _DetailedPostState();
}

class _DetailedPostState extends State<EditPost> {
  final CarouselController carouselController = CarouselController();
  var postContentController = TextEditingController();
  int _currentImageIndex = 0;
  File? postAttachment;
  List<File>? _attachments = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLoginCubit, UserLoginStates>(
        listener: (context, states) {},
        builder: (context, states) {
          return BlocConsumer<HomeLayoutCubit, LayoutStates>(
            listener: (context, states) {},
            builder: (context, states) {
              if (HomeLayoutCubit.get(context).editPostDetails?.content == null || HomeLayoutCubit.get(context).editPostDetails?.attachments == null) {
                postContentController.text = HomeLayoutCubit.get(context).getPostById?.post?.content ?? " ";
                if (HomeLayoutCubit.get(context).getPostById?.post?.attachments != null) {
                  _attachments!.addAll(HomeLayoutCubit.get(context).getPostById!.post!.attachments!.map((attachment) => File(attachment.secure_url)).toList());
                }
              } else {
                postContentController.text = HomeLayoutCubit.get(context).editPostDetails!.content;
                if (HomeLayoutCubit.get(context).editPostDetails!.attachments != null) {
                  _attachments!.addAll(HomeLayoutCubit.get(context).editPostDetails!.attachments!.map((attachment) => File(attachment.secure_url)).toList());
                }
              }
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: SvgPicture.asset('assets/images/arrowLeft.svg'),
                    color: HexColor("858888"),
                    onPressed: () =>
                        navigateToPage(context, const ProfilePage()),
                  ),
                ),
                body: HomeLayoutCubit.get(context).getPostById?.post != null
                    ? buildDetailedPostItem(
                        HomeLayoutCubit.get(context).getPostById?.post,
                        UserLoginCubit.get(context).loggedInUserModel!.data.doc,
                        context,
                      )
                    : const SizedBox(),
              );
            },
          );
        });
  }

  Widget buildDetailedPostItem(
      SpecificPost? specificPost, LoggedInUser loggedInUser, context) {
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

    return ListView(
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
                        backgroundImage: specificPost.createdBy.profilePic !=
                                null
                            ? NetworkImage(specificPost.createdBy.profilePic!
                                .secure_url) as ImageProvider
                            : const AssetImage("assets/images/nullProfile.png"),
                      ),
                      SizedBox(width: screenWidth / 50),
                      /// Username, Profile Pic and Duration
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
                                navigateToPage(context, const ProfilePage());
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
                                    userName: specificPost.createdBy.userName,
                                  )
                                      .then((value) {
                                    UserLoginCubit.get(context).anotherUser =
                                        HomeLayoutCubit.get(context)
                                            .anotherUser;
                                    navigateToPage(
                                        context, const AnotherUserProfile());
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
                              SvgPicture.asset('assets/images/earthIcon.svg'),
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
                        TextFormField(
                          controller: postContentController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            focusColor: defaultColor,
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontFamily: "Robot",
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: (postAttachment == null) ? 5 : 8,
                        ),
                        SizedBox(height: screenHeight / 100),

                        /// Post Attachments
                        if (specificPost.attachments!.isNotEmpty)
                          // check if there's more than one
                          if (specificPost.attachments!.length > 1)
                            CarouselSlider(
                              carouselController: carouselController,
                              items:
                                  specificPost.attachments!.map((attachment) {
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

                  /// Likes and Comments Count
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

                  /// Separator Line
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

                  /// Like, comment, share
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
                          ),
                          const Spacer(),
                          postSubComponent(
                            "assets/images/comment.svg",
                            "Comment",
                          ),
                          const Spacer(),
                          postSubComponent(
                            "assets/images/share.svg",
                            "Share",
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

        /// Save Changes $ Discard Buttons
        Padding(
          padding: EdgeInsetsDirectional.only(
            top: screenHeight / 30,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  navigateAndFinish(context, const ProfilePage());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0.5,
                        blurRadius: 0.5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: screenWidth / 15,
                      end: screenWidth / 15,
                      top: screenHeight / 100,
                      bottom: screenHeight / 100,
                    ),
                    child: const Center(
                      child: Text(
                        "Discard",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth / 10),
              GestureDetector(
                onTap: () {
                  saveChanges(specificPost);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0.5,
                        blurRadius: 0.5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: screenWidth / 15,
                      end: screenWidth / 15,
                      top: screenHeight / 100,
                      bottom: screenHeight / 100,
                    ),
                    child: const Center(
                      child: Text(
                        "Save Changes",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void saveChanges(SpecificPost? specificPost) {
    HomeLayoutCubit.get(context).editPost(
      content: postContentController.text,
      token: UserLoginCubit.get(context).loginModel!.refresh_token ?? "",
      postId: specificPost!.id!,
    );
    HomeLayoutCubit.get(context).getOwnerPosts(
        token: UserLoginCubit.get(context).loginModel!.refresh_token ?? "");
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: defaultColor,
      content: Text(
        'Post Updated',
        style: TextStyle(
          fontSize: 12.0,
        ),
      ),
    ));
    navigateAndFinish(context, const ProfilePage());
  }

  void _showHomePageBottomSheet(SpecificPost? specificPost, context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        var screenHeight = MediaQuery.of(context).size.height;

        return SizedBox(
          height: screenHeight / 6,
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
                  SavedPostsCubit.get(context).savePost(
                    token:
                        UserLoginCubit.get(context).loginModel!.refresh_token ??
                            "",
                    postId: specificPost!.id!,
                  );
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
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
