import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/states.dart';
import 'package:flutter_code/layout/VolunHeroUserLayout/layout.dart';
import 'package:flutter_code/models/HomePagePostsModel.dart';
import 'package:flutter_code/modules/GeneralView/DetailedChat/detailed_chat.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../../../bloc/savedPosts_bloc/cubit.dart';
import '../../../models/LoggedInUserModel.dart';
import '../../GeneralView/DetailedPost/Detailed_Post.dart';
import '../UserProfilePage/Profile_Page.dart';


class AnotherUserProfile extends StatefulWidget {
  const AnotherUserProfile({super.key});

  @override
  State<AnotherUserProfile> createState() => _AnotherUserProfileState();
}

class _AnotherUserProfileState extends State<AnotherUserProfile> {
  final CarouselController carouselController = CarouselController();
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    HomeLayoutCubit.get(context)
        .getAnotherUserData(
        token: UserLoginCubit.get(context)
            .loginModel!
            .refresh_token,
        id: UserLoginCubit.get(context).anotherUser!.id);

      UserLoginCubit.get(context)
          .getAnotherUserPosts(
          token: UserLoginCubit.get(context)
              .loginModel!
              .refresh_token,
          id: UserLoginCubit.get(context).anotherUser!.id,
          userName:UserLoginCubit.get(context).anotherUser!.userName)
          .then((value) {
        UserLoginCubit.get(context).anotherUser =
            HomeLayoutCubit.get(context).anotherUser;
      });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<UserLoginCubit, UserLoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return  Scaffold(
          appBar: AppBar(
            backgroundColor: defaultColor,
            leading: IconButton(
              icon: SvgPicture.asset(
                'assets/images/arrow_left_white.svg',
              ),
              onPressed: () {
                navigateAndFinish(context, const VolunHeroUserLayout());
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Profile Pic
                Stack(
                  children: [
                    Container(
                      height: screenHeight / 7.5,
                      width: double.infinity,
                      color: defaultColor,
                    ),
                    // Upload Cover Photo Icon
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: screenWidth / 1.14,
                        top: screenHeight / 12.5,
                      ),
                      child: IconButton(
                        // Upload Cover Photo from mobile Gallery
                        onPressed: _uploadPhoto,
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: Colors.grey[400],
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            size: 20.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    // Profile Photo
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: screenWidth / 25,
                        top: screenHeight / 13.5,
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 45.0,
                            backgroundImage: HomeLayoutCubit.get(context).modifiedPost?.createdBy.profilePic != null
                                ? NetworkImage(HomeLayoutCubit.get(context).modifiedPost!.createdBy.profilePic!.secure_url) as ImageProvider
                                : const AssetImage("assets/images/nullProfile.png"),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade400,
                              ),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                size: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Username & Email
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: screenWidth / 30,
                    top: screenHeight / 70,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                UserLoginCubit.get(context)
                                    .anotherUser
                                    ?.firstName ??
                                    " ",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black38.withOpacity(0.7),
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              SizedBox(width: screenWidth / 90),
                              Text(
                                UserLoginCubit.get(context)
                                        .anotherUser
                                        ?.lastName ??
                                    " ",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black38.withOpacity(0.7),
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              SizedBox(width: screenWidth / 60),
                              (UserLoginCubit.get(context)
                                              .anotherUser
                                              ?.specification ==
                                          'Medical' ||
                                      UserLoginCubit.get(context)
                                              .anotherUser
                                              ?.specification ==
                                          'Educational')
                                  ? const Icon(Icons.verified,
                                      color: Colors.blue)
                                  : Container(),
                            ],
                          ),
                          const SizedBox(height: 1.0),
                          Text(
                            UserLoginCubit.get(context).anotherUser?.email ??
                                " ",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight / 90),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: screenWidth / 30,
                    vertical: screenHeight / 70,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                UserLoginCubit.get(context)
                                    .handleFollow(
                                        token: UserLoginCubit.get(context)
                                            .loginModel!
                                            .refresh_token,
                                        followId: UserLoginCubit.get(context)
                                            .anotherUser!
                                            .id)
                                    .then((value) {
                                  UserLoginCubit.get(context)
                                      .getLoggedInUserData(
                                          token: UserLoginCubit.get(context)
                                              .loginModel!
                                              .refresh_token);
                                  HomeLayoutCubit.get(context)
                                      .getAnotherUserData(
                                          token: UserLoginCubit.get(context)
                                              .loginModel!
                                              .refresh_token,
                                          id: UserLoginCubit.get(context)
                                              .anotherUser!
                                              .id)
                                      .then((value) {
                                    UserLoginCubit.get(context).anotherUser =
                                        HomeLayoutCubit.get(context)
                                            .anotherUser;
                                    UserLoginCubit.get(context)
                                        .getAnotherUserFollowers();
                                  });
                                });
                              },
                              child: (UserLoginCubit.get(context).inFollowing(
                                          followId: UserLoginCubit.get(context)
                                                  .anotherUser
                                                  ?.id ??
                                              " ") ==
                                      false)
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: defaultColor,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Center(
                                          child: (state is! FollowLoadingState)
                                              ? (const Text(
                                                  "Follow",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ))
                                              : const Center(
                                                  child: SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                    CircularProgressIndicator(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Center(
                                            child:
                                                (state is! FollowLoadingState)
                                                    ? (const Text(
                                                        "Following",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ))
                                                    : const Center(
                                                        child: SizedBox(
                                                          width: 20,
                                                          height: 20,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      )),
                                      ),
                                    ))),
                      const SizedBox(width: 2),
                      Expanded(
                          child: InkWell(
                        onTap: () async {
                          bool newChat = true;
                          UserLoginCubit.get(context)
                              .getLoggedInChats(
                                  token: UserLoginCubit.get(context)
                                      .loginModel!
                                      .refresh_token)
                              .then((value) {
                            for (int i = 0;
                                i < UserLoginCubit.get(context).chats.length;
                                i++) {
                              // case 1
                              if (UserLoginCubit.get(context)
                                      .chats[i]
                                      .members[0]
                                      .userId
                                      .id ==
                                  UserLoginCubit.get(context)
                                      .loggedInUser!
                                      .id) {
                                if (UserLoginCubit.get(context)
                                        .chats[i]
                                        .members[1]
                                        .userId
                                        .id ==
                                    HomeLayoutCubit.get(context)
                                        .anotherUser!
                                        .id) {
                                  newChat = false;
                                  UserLoginCubit.get(context).selectedChat =
                                      UserLoginCubit.get(context).chats[i];
                                }
                              }
                              // case 2
                              if (UserLoginCubit.get(context)
                                      .chats[i]
                                      .members[1]
                                      .userId
                                      .id ==
                                  UserLoginCubit.get(context)
                                      .loggedInUser!
                                      .id) {
                                if (UserLoginCubit.get(context)
                                        .chats[i]
                                        .members[0]
                                        .userId
                                        .id ==
                                    HomeLayoutCubit.get(context)
                                        .anotherUser!
                                        .id) {
                                  newChat = false;
                                  UserLoginCubit.get(context).selectedChat =
                                      UserLoginCubit.get(context).chats[i];
                                }
                              }
                            }
                            if (newChat == true) {
                              print(
                                  HomeLayoutCubit.get(context).anotherUser!.id);
                              UserLoginCubit.get(context).createChat(
                                  secondId: HomeLayoutCubit.get(context)
                                      .anotherUser!
                                      .id
                                      .toString());
                            }
                          }).then((value) {
                            UserLoginCubit.get(context)
                                .getLoggedInChats(
                                    token: UserLoginCubit.get(context)
                                        .loginModel!
                                        .refresh_token)
                                .then((value) {
                              for (int i = 0;
                                  i < UserLoginCubit.get(context).chats.length;
                                  i++) {
                                // case 1
                                if (UserLoginCubit.get(context)
                                        .chats[i]
                                        .members[0]
                                        .userId
                                        .id ==
                                    UserLoginCubit.get(context)
                                        .loggedInUser!
                                        .id) {
                                  if (UserLoginCubit.get(context)
                                          .chats[i]
                                          .members[1]
                                          .userId
                                          .id ==
                                      HomeLayoutCubit.get(context)
                                          .anotherUser!
                                          .id) {
                                    UserLoginCubit.get(context).selectedChat =
                                        UserLoginCubit.get(context).chats[i];
                                  }
                                }
                                // case 2
                                if (UserLoginCubit.get(context)
                                        .chats[i]
                                        .members[1]
                                        .userId
                                        .id ==
                                    UserLoginCubit.get(context)
                                        .loggedInUser!
                                        .id) {
                                  if (UserLoginCubit.get(context)
                                          .chats[i]
                                          .members[0]
                                          .userId
                                          .id ==
                                      HomeLayoutCubit.get(context)
                                          .anotherUser!
                                          .id) {
                                    UserLoginCubit.get(context).selectedChat =
                                        UserLoginCubit.get(context).chats[i];
                                  }
                                }
                              }
                            }).then((value) {
                              navigateToPage(context, DetailedChats());
                            });
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black38.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Center(
                              child: ((state is! CreateChatLoadingState)
                                  ? const Text(
                                      "message",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : const Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                            ),
                          ),
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
                /// Posts, Following and Followers Count
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text(
                                "Account Info",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight / 100),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "${UserLoginCubit.get(context).anotherUserPostsResponse?.posts.length ?? " "}",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black.withOpacity(0.7),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Posts",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black.withOpacity(0.7),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "${UserLoginCubit.get(context).anotherUser?.following.length ?? 0}",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black.withOpacity(0.7),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Following",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black.withOpacity(0.7),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "${UserLoginCubit.get(context).anotherUser?.followers.length ?? 0}",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black.withOpacity(0.7),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Followers",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black.withOpacity(0.7),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // Personal Details
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 10.0,
                          spreadRadius: -5.0,
                          offset: const Offset(
                              10.0, 10.0), // Right and bottom shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text(
                                "Personal Details",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight / 80),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: screenWidth / 180,
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/Specification.svg',
                                ),
                              ),
                              SizedBox(width: screenWidth / 30),
                              SizedBox(
                                  width: screenWidth / 1.5,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Specification: ",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black.withOpacity(0.7),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        UserLoginCubit.get(context)
                                                .anotherUser
                                                ?.specification ??
                                            " ",
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          color: defaultColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                          SizedBox(height: screenHeight / 60),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined),
                              SizedBox(width: screenWidth / 30),
                              SizedBox(
                                width: screenWidth / 1.5,
                                child: Text(
                                  "Lives in ${UserLoginCubit.get(context).anotherUser?.address ?? " "}",
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: screenHeight / 70),
                          const Text(
                            "Contact Info",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: screenHeight / 80),
                          Row(
                            children: [
                              const Icon(Icons.phone),
                              SizedBox(width: screenWidth / 30),
                              SizedBox(
                                width: screenWidth / 1.5,
                                child: Text(
                                  UserLoginCubit.get(context)
                                          .anotherUser
                                          ?.phone ??
                                      "",
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Posts
                if (UserLoginCubit.get(context).anotherUserPostsResponse !=
                    null &&
                    UserLoginCubit.get(context).anotherUserPostsResponse!.posts.isEmpty)
                  Padding(
                    padding: EdgeInsets.all(screenWidth / 60),
                    child: Container(
                      height: screenHeight / 10,
                      width: screenWidth,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.post_add,
                            size: 28,
                            color: Colors.black54,
                          ),
                          SizedBox(height: screenHeight / 200),
                          const Text(
                            "No Posts Available",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Roboto",
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: screenHeight / 300),
                          const Text(
                            "Posts "
                                "and attachments will "
                                "show up here.",
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else buildAnotherUserPostsList(context)

              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildLoadingWidget(context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          period: const Duration(milliseconds: 1000),
          baseColor: Colors.grey,
          highlightColor: Colors.white30,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                    ),
                    SizedBox(
                      width: screenWidth / 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenHeight / 75,
                          width: screenWidth / 4,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: screenHeight / 75,
                          width: screenWidth / 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight / 100,
                ),
                Center(
                  child: SizedBox(
                    height: screenHeight / 4,
                    width: screenWidth,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildAnotherUserPostsList(context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var cubit = UserLoginCubit.get(context);

    if (cubit.anotherUserPostsResponse != null) {
      if (cubit.anotherUserPostsResponse!.posts.isNotEmpty) {
        return ListView.separated(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (cubit.anotherUserPostsResponse != null) {
              if (index < cubit.anotherUserPostsResponse!.posts.length) {
                CreatedBy createdBy = new CreatedBy(
                    id:cubit.anotherUserPostsResponse!.posts[index].createdBy.id,
                    userName: cubit.anotherUserPostsResponse!.posts[index].createdBy.userName,
                    role: cubit.anotherUserPostsResponse!.posts[index].createdBy.role);
                List<Attachment> attachments =[];

                for(int i=0;i<cubit.anotherUserPostsResponse!.posts[index].attachments.length;i++){
                   Attachment attachment = new Attachment(
                       secure_url: cubit.anotherUserPostsResponse!.posts[index].attachments[i].secureUrl,
                       public_id: cubit.anotherUserPostsResponse!.posts[index].attachments[i].publicId
                   );
                   attachments.add(attachment);
                }
                ModifiedPost? modifiedPost = new ModifiedPost(
                    id: cubit.anotherUserPostsResponse!.posts[index].id,
                    content: cubit.anotherUserPostsResponse!.posts[index].content,
                    specification: cubit.anotherUserPostsResponse!.posts[index].specification,
                    createdBy:createdBy,
                    likesCount: cubit.anotherUserPostsResponse!.posts[index].likesCount,
                    commentsCount: cubit.anotherUserPostsResponse!.posts[index].commentsCount,
                    shareCount: cubit.anotherUserPostsResponse!.posts[index].shareCount,
                    comments: [],
                    createdAt: cubit.anotherUserPostsResponse!.posts[index].createdAt,
                    updatedAt: cubit.anotherUserPostsResponse!.posts[index].updatedAt,
                    liked: false,
                    attachments: attachments,
                    v: cubit.anotherUserPostsResponse!.posts[index].v
                );
                print("sdsdsdsdsdsds");
                print(cubit.anotherUserPostsResponse!.posts[index]);
                print("sdsdsdsdsdsds");
                return buildPostItem(
                    modifiedPost,
                    LoggedInUser(
                        id: UserLoginCubit.get(context).loggedInUser!.id,
                        firstName: UserLoginCubit.get(context).loggedInUser!.firstName,
                        lastName: UserLoginCubit.get(context).loggedInUser!.lastName,
                        userName: UserLoginCubit.get(context).loggedInUser!.userName,
                        slugUserName: UserLoginCubit.get(context).loggedInUser!.slugUserName,
                        email: UserLoginCubit.get(context).loggedInUser!.email,
                        phone: UserLoginCubit.get(context).loggedInUser!.phone,
                        role: UserLoginCubit.get(context).loggedInUser!.role,
                        images: UserLoginCubit.get(context).loggedInUser!.images,
                        address: UserLoginCubit.get(context).loggedInUser!.address,
                        gender: UserLoginCubit.get(context).loggedInUser!.gender,
                        headquarters: UserLoginCubit.get(context).loggedInUser!.headquarters,
                        specification: UserLoginCubit.get(context).loggedInUser!.specification,
                        attachments: UserLoginCubit.get(context).loggedInUser!.attachments,
                        following: UserLoginCubit.get(context).loggedInUser!.following,
                        followers: UserLoginCubit.get(context).loggedInUser!.followers,
                        updatedAt: UserLoginCubit.get(context).loggedInUser!.updatedAt,
                        v: UserLoginCubit.get(context).loggedInUser!.v
                    ), context);
              }
            }
            return const Text("No Posts Available");
          },
          separatorBuilder: (context, index) => Padding(
            padding:
                const EdgeInsetsDirectional.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              color: Colors.white,
            ),
          ),
          itemCount: cubit.anotherUserPostsResponse!.posts.length,
        );
      } else {
        return Padding(
          padding: EdgeInsets.all(screenWidth / 60),
          child: Container(
            height: screenHeight / 10,
            width: screenWidth,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.post_add,
                  size: 28,
                  color: Colors.black54,
                ),
                SizedBox(height: screenHeight / 200),
                const Text(
                  "No Posts Available",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Roboto",
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: screenHeight / 300),
                const Text(
                  "Posts "
                      "and attachments will "
                      "show up here.",
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    } else {
      return buildLoadingWidget(context);
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
                          // HomeLayoutCubit.get(context)
                          //     .getAnotherUserData(
                          //         token: UserLoginCubit.get(context)
                          //             .loginModel!
                          //             .refresh_token,
                          //         id: postDetails.createdBy.id)
                          //     .then((value) {
                          //       print(postDetails.createdBy.id);
                          //   UserLoginCubit.get(context)
                          //       .getAnotherUserPosts(
                          //           token: UserLoginCubit.get(context)
                          //               .loginModel!
                          //               .refresh_token,
                          //           id: postDetails.createdBy.id,
                          //           userName: postDetails.createdBy.userName)
                          //       .then((value) {
                          //     UserLoginCubit.get(context).anotherUser =
                          //         HomeLayoutCubit.get(context).anotherUser;
                          //     navigateToPage(
                          //         context, const AnotherUserProfile());
                          //   });
                          // });
                          UserLoginCubit.get(context).anotherUser?.id = postDetails.createdBy.id;
                          UserLoginCubit.get(context).anotherUser?.userName = postDetails.createdBy.userName;
                          navigateToPage(
                              context,  AnotherUserProfile());
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
                            if (postDetails.createdBy.id ==
                                UserLoginCubit.get(context).loggedInUser!.id) {
                              navigateToPage(context, const ProfilePage());
                            } else {
                              HomeLayoutCubit.get(context)
                                  .getAnotherUserData(
                                  token: UserLoginCubit.get(context)
                                      .loginModel!
                                      .refresh_token,
                                  id: postDetails.createdBy.id)
                                  .then((value) {
                                UserLoginCubit.get(context).anotherUser =
                                    HomeLayoutCubit.get(context).anotherUser;
                                navigateToPage(
                                    context, const AnotherUserProfile());
                              });
                            }
                          },
                          child: Text(
                            postDetails.createdBy.userName,
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
                        // print("Modified to be saved: ");
                        // print(postDetails);
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
                          "assets/images/comment.svg",
                          "Comment",
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
                      // print("Modified to be saved: ");
                      // print(modifiedPost);
                      // Logic to save the post
                      SavedPostsCubit.get(context).savePost(
                        token:
                        UserLoginCubit.get(context).loginModel!.refresh_token ??
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
                      // Logic to Copy post link
                      Navigator.pop(context);
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
                            'Post already saved',
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

  void _showProfilePageBottomSheet(ModifiedPost? postDetails) {
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
                  // Logic to save the post
                },
              ),
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
                      'Delete Post',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenHeight / 130),
                    const Text(
                      'Delete this post from your profile.',
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
                  HomeLayoutCubit.get(context).deletePost(
                      token: UserLoginCubit.get(context)
                              .loginModel!
                              .refresh_token ??
                          "",
                      postId: postDetails!.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _uploadPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      // For example:
      // _handleImage(pickedFile);
    }
  }
}
