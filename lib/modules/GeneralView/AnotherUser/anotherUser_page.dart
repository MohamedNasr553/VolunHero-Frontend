import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/DonationForm_bloc/cubit.dart';
import 'package:flutter_code/bloc/DonationForm_bloc/states.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/bloc/Layout_bloc/cubit.dart';
import 'package:flutter_code/bloc/savedPosts_bloc/cubit.dart';
import 'package:flutter_code/layout/VolunHeroLayout/layout.dart';
import 'package:flutter_code/models/AnotherUserPostsModel.dart';
import 'package:flutter_code/models/GetAllDonationFormsModel.dart';
import 'package:flutter_code/models/LoggedInUserModel.dart';
import 'package:flutter_code/modules/GeneralView/Chats/chatPage.dart';
import 'package:flutter_code/modules/GeneralView/DetailedPost/Detailed_Post.dart';
import 'package:flutter_code/modules/GeneralView/OthersFollowersPage/OtherFollowers.dart';
import 'package:flutter_code/modules/GeneralView/OthersFollowingsPage/OtherFollowings.dart';
import 'package:flutter_code/modules/GeneralView/ProfilePage/Profile_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class AnotherUserProfile extends StatefulWidget {
  const AnotherUserProfile({super.key});

  @override
  State<AnotherUserProfile> createState() => _AnotherUserProfileState();
}

class _AnotherUserProfileState extends State<AnotherUserProfile> {
  final CarouselController carouselController = CarouselController();
  int _currentImageIndex = 0;
  String pressedState = 'About';

  @override
  void initState() {
    super.initState();

    //Another User Data
    UserLoginCubit.get(context)
        .getAnotherUserDatabyHTTP(
      id: UserLoginCubit.get(context).idOfSelected ?? "",
      token: UserLoginCubit.get(context).loginModel!.refresh_token,
    )
        .then((_) {
      print(UserLoginCubit.get(context).idOfSelected);
    });

    UserLoginCubit.get(context).getAnotherUserPosts(
      token: UserLoginCubit.get(context).loginModel!.refresh_token,
      userName: UserLoginCubit.get(context).anotherUser?.slugUserName ?? "",
      id: UserLoginCubit.get(context).anotherUser!.id,
    );

    (UserLoginCubit.get(context).loggedInUser!.role == "Organization")
        ? DonationFormCubit.get(context).getOrgDonationForms(
            token: UserLoginCubit.get(context).loginModel?.refresh_token ?? "",
            orgId: UserLoginCubit.get(context).loggedInUser!.id,
          )
        : UserLoginCubit.get(context).flag = UserLoginCubit.get(context)
            .inFollowing(followId: UserLoginCubit.get(context).idOfSelected);

    /// Logged in user chats
    UserLoginCubit.get(context).getLoggedInChats(
        token: UserLoginCubit.get(context).loginModel!.refresh_token);

    UserLoginCubit.get(context)
        .inFollowing(followId: UserLoginCubit.get(context).idOfSelected);
    UserLoginCubit.get(context).isLoggedInUserFollowingAnotherUser();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<UserLoginCubit, UserLoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeLayoutCubit.get(context).followersCount =
            UserLoginCubit.get(context).anotherUser?.followers.length ?? 0;
        HomeLayoutCubit.get(context).followingCount =
            HomeLayoutCubit.get(context).anotherUser?.following.length ?? 0;
        return BlocConsumer<DonationFormCubit, DonationFormStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: defaultColor,
                leading: IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/arrow_left_white.svg',
                  ),
                  onPressed: () {
                    navigateAndFinish(context, const VolunHeroLayout());
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
                                backgroundColor: Colors.white,
                                backgroundImage: (UserLoginCubit.get(context)
                                            .anotherUser
                                            ?.profilePic
                                            ?.secureUrl !=
                                        null)
                                    ? NetworkImage(UserLoginCubit.get(context)
                                        .anotherUser!
                                        .profilePic!
                                        .secureUrl) as ImageProvider
                                    : const AssetImage(
                                        "assets/images/nullProfile.png"),
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
                                              'Educational' ||
                                          UserLoginCubit.get(context)
                                                  .anotherUser
                                                  ?.role ==
                                              'Organization')
                                      ? const Icon(Icons.verified,
                                          color: Colors.blue)
                                      : Container(),
                                ],
                              ),
                              const SizedBox(height: 1.0),
                              Text(
                                UserLoginCubit.get(context)
                                        .anotherUser
                                        ?.email ??
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
                                    .then((onValue) {});
                              },
                              child: (UserLoginCubit.get(context)
                                          .isLoggedInUserFollowingAnotherUser() ==
                                      false)
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: defaultColor,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Center(
                                          child: (Text(
                                            "Follow",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Center(
                                          child: (true)
                                              ? (Text(
                                                  "Following",
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
                                    ),
                            ),
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                UserLoginCubit.get(context)
                                    .createChat(
                                  secondId: UserLoginCubit.get(context)
                                      .anotherUser!
                                      .id,
                                )
                                    .then((_) {
                                  /// Logged in user chats
                                  UserLoginCubit.get(context)
                                      .getLoggedInChats(
                                          token: UserLoginCubit.get(context)
                                              .loginModel!
                                              .refresh_token)
                                      .then((onValue) {
                                    navigateToPage(context, const ChatsPage());
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
                              const Text(
                                "Account Info",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
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
                                            "${UserLoginCubit.get(context).anotherUserPostsResponse?.posts.length ?? "0"}",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Posts",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          UserLoginCubit.get(context)
                                              .getOtherUserFollowers(
                                            token: UserLoginCubit.get(context)
                                                .loginModel!
                                                .refresh_token,
                                            slugUsername:
                                                UserLoginCubit.get(context)
                                                    .anotherUser!
                                                    .slugUserName,
                                            id: UserLoginCubit.get(context)
                                                .anotherUser!
                                                .id,
                                          );
                                          navigateToPage(context,
                                              const OtherUserFollowers());
                                        },
                                        child: Column(
                                          children: [
                                            Text(
                                              "${UserLoginCubit.get(context).anotherUser?.followers.length ?? 0}",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Followers",
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          UserLoginCubit.get(context)
                                              .getOtherUserFollowings(
                                            token: UserLoginCubit.get(context)
                                                .loginModel!
                                                .refresh_token,
                                            slugUsername:
                                                UserLoginCubit.get(context)
                                                    .anotherUser!
                                                    .slugUserName,
                                            id: UserLoginCubit.get(context)
                                                .anotherUser!
                                                .id,
                                          );
                                          navigateToPage(context,
                                              const OtherUserFollowings());
                                        },
                                        child: Column(
                                          children: [
                                            Text(
                                              "${UserLoginCubit.get(context).anotherUser!.following.length}",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Following",
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screenHeight / 60),
                              Container(
                                height: 0.7,
                                color: Colors.grey.shade600,
                              ),
                              SizedBox(height: screenHeight / 60),
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: screenWidth / 80,
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          // showPosts = true;
                                          pressedState = 'About';
                                          UserLoginCubit.get(context)
                                              .getAnotherUserPosts(
                                            token: UserLoginCubit.get(context)
                                                    .loginModel!
                                                    .refresh_token ??
                                                "",
                                            userName:
                                                UserLoginCubit.get(context)
                                                        .anotherUser
                                                        ?.slugUserName ??
                                                    "",
                                            id: UserLoginCubit.get(context)
                                                .anotherUser!
                                                .id,
                                          );
                                        });
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: screenHeight / 40,
                                            width: screenWidth / 9,
                                            color: Colors.white,
                                            child: Text(
                                              "About",
                                              style: TextStyle(
                                                color: (pressedState == 'About')
                                                    ? defaultColor
                                                    : Colors.black54,
                                                fontFamily: "Poppins",
                                                fontSize: 11.5,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          (pressedState == 'About')
                                              ? Container(
                                                  width: screenWidth / 10,
                                                  height: 2.7,
                                                  color: defaultColor,
                                                )
                                              : const SizedBox()
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: screenWidth / 15),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          // showPosts = true;
                                          pressedState = 'Posts';
                                          UserLoginCubit.get(context)
                                              .getAnotherUserPosts(
                                            token: UserLoginCubit.get(context)
                                                    .loginModel!
                                                    .refresh_token ??
                                                "",
                                            userName:
                                                UserLoginCubit.get(context)
                                                        .anotherUser
                                                        ?.slugUserName ??
                                                    "",
                                            id: UserLoginCubit.get(context)
                                                .anotherUser!
                                                .id,
                                          );
                                        });
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: screenHeight / 40,
                                            width: screenWidth / 12,
                                            color: Colors.white,
                                            child: Text(
                                              "Posts",
                                              style: TextStyle(
                                                color: (pressedState == 'Posts')
                                                    ? defaultColor
                                                    : Colors.black54,
                                                fontFamily: "Poppins",
                                                fontSize: 11.5,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          (pressedState == 'Posts')
                                              ? Container(
                                                  width: screenWidth / 12.5,
                                                  height: 2.7,
                                                  color: defaultColor,
                                                )
                                              : const SizedBox()
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: screenWidth / 15),
                                    (UserLoginCubit.get(context)
                                                .anotherUser
                                                ?.role ==
                                            "Organization")
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                // showPosts = true;
                                                pressedState = 'Donation Forms';
                                              });
                                              DonationFormCubit.get(context)
                                                  .getOrgDonationForms(
                                                token:
                                                    UserLoginCubit.get(context)
                                                            .loginModel!
                                                            .refresh_token ??
                                                        "",
                                                orgId:
                                                    UserLoginCubit.get(context)
                                                        .anotherUser!
                                                        .id,
                                              );
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: screenHeight / 40,
                                                  width: screenWidth / 4,
                                                  color: Colors.white,
                                                  child: Text(
                                                    'Donation Forms',
                                                    style: TextStyle(
                                                      color: (pressedState ==
                                                              'Donation Forms')
                                                          ? defaultColor
                                                          : Colors.black54,
                                                      fontFamily: "Poppins",
                                                      fontSize: 11.5,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                (pressedState ==
                                                        'Donation Forms')
                                                    ? Container(
                                                        width:
                                                            screenWidth / 4.3,
                                                        height: 2.7,
                                                        color: defaultColor,
                                                      )
                                                    : const SizedBox()
                                              ],
                                            ),
                                          )
                                        : const SizedBox()
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (pressedState == 'About')
                      Column(
                        children: [
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
                                            child: (UserLoginCubit.get(context)
                                                        .anotherUser
                                                        ?.role ==
                                                    "User")
                                                ? Row(
                                                    children: [
                                                      Text(
                                                        "Specification: ",
                                                        style: TextStyle(
                                                          fontSize: 12.0,
                                                          color: Colors.black
                                                              .withOpacity(0.7),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        UserLoginCubit.get(
                                                                    context)
                                                                .anotherUser
                                                                ?.specification ??
                                                            " ",
                                                        style: const TextStyle(
                                                          fontSize: 12.0,
                                                          color: defaultColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Row(
                                                    children: [
                                                      Text(
                                                        "Role: ",
                                                        style: TextStyle(
                                                          fontSize: 12.0,
                                                          color: Colors.black
                                                              .withOpacity(0.7),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        UserLoginCubit.get(
                                                                    context)
                                                                .anotherUser
                                                                ?.role ??
                                                            " ",
                                                        style: const TextStyle(
                                                          fontSize: 12.0,
                                                          color: defaultColor,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                          if (UserLoginCubit.get(context)
                                      .anotherUserPostsResponse !=
                                  null &&
                              UserLoginCubit.get(context)
                                  .anotherUserPostsResponse!
                                  .posts
                                  .isEmpty)
                            Padding(
                              padding: EdgeInsets.all(screenWidth / 60),
                              child: (state is GetAnotherUserPostsSuccessState)
                                  ? Container(
                                      height: screenHeight / 10,
                                      width: screenWidth,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(14.0),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                    )
                                  : const CircularProgressIndicator(
                                      color: defaultColor,
                                    ),
                            )
                          else
                            buildAnotherUserPostsList(context)
                        ],
                      )
                    else if (pressedState == 'Posts')
                      Column(
                        children: [
                          // Posts
                          if (UserLoginCubit.get(context)
                                      .anotherUserPostsResponse !=
                                  null &&
                              UserLoginCubit.get(context)
                                  .anotherUserPostsResponse!
                                  .posts
                                  .isEmpty)
                            Padding(
                              padding: EdgeInsets.all(screenWidth / 60),
                              child: (state is GetAnotherUserPostsSuccessState)
                                  ? Container(
                                      height: screenHeight / 10,
                                      width: screenWidth,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(14.0),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                    )
                                  : const CircularProgressIndicator(
                                      color: defaultColor,
                                    ),
                            )
                          else
                            buildAnotherUserPostsList(context)
                        ],
                      )
                    else if (pressedState == 'Donation Forms')
                      Column(
                        children: [
                          if (DonationFormCubit.get(context)
                                      .getOrgDonationFormsResponse !=
                                  null &&
                              DonationFormCubit.get(context)
                                  .getOrgDonationFormsResponse!
                                  .donationForms
                                  .isEmpty)
                            Padding(
                              padding: EdgeInsets.all(screenWidth / 60),
                              child: (state is GetOrgDonationFormSuccessState)
                                  ? Container(
                                      height: screenHeight / 10,
                                      width: screenWidth,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(14.0),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.newspaper_sharp,
                                            size: 28,
                                            color: Colors.black54,
                                          ),
                                          SizedBox(height: screenHeight / 200),
                                          const Text(
                                            "No Donation Forms available",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Roboto",
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(height: screenHeight / 300),
                                          const Text(
                                            "Donation Forms "
                                            "will "
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
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(
                                        color: defaultColor,
                                      ),
                                    ),
                            )
                          else
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                top: screenHeight / 60,
                                start: screenWidth / 40,
                                end: screenWidth / 40,
                              ),
                              child: ListView.separated(
                                reverse: true,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) =>
                                    donationFormItem(
                                  DonationFormCubit.get(context)
                                      .getOrgDonationFormsResponse
                                      ?.donationForms[index],
                                  context,
                                ),
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: screenHeight / 50),
                                itemCount: DonationFormCubit.get(context)
                                        .getOrgDonationFormsResponse
                                        ?.donationForms
                                        .length ??
                                    0,
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
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
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (cubit.anotherUserPostsResponse != null) {
              if (index < cubit.anotherUserPostsResponse!.posts.length) {
                CreatedBy createdBy = CreatedBy(
                  id: cubit.anotherUserPostsResponse!.posts[index].createdBy.id,
                  userName: cubit.anotherUserPostsResponse!.posts[index]
                      .createdBy.userName,
                  role: cubit
                      .anotherUserPostsResponse!.posts[index].createdBy.role,
                );

                List<AnotherUserAttachment> attachments = [];

                for (int i = 0;
                    i <
                        cubit.anotherUserPostsResponse!.posts[index].attachments
                            .length;
                    i++) {
                  AnotherUserAttachment attachment = AnotherUserAttachment(
                      secureUrl: cubit.anotherUserPostsResponse!.posts[index]
                          .attachments[i].secureUrl,
                      publicId: cubit.anotherUserPostsResponse!.posts[index]
                          .attachments[i].publicId);
                  attachments.add(attachment);
                }
                PostWrapper postWrapper = PostWrapper(
                  id: cubit.anotherUserPostsResponse!.posts[index].id,
                  content: cubit.anotherUserPostsResponse!.posts[index].content,
                  specification: cubit
                      .anotherUserPostsResponse!.posts[index].specification,
                  createdBy: createdBy,
                  likesCount:
                      cubit.anotherUserPostsResponse!.posts[index].likesCount,
                  commentsCount: cubit
                      .anotherUserPostsResponse!.posts[index].commentsCount,
                  shareCount:
                      cubit.anotherUserPostsResponse!.posts[index].shareCount,
                  comments: [],
                  createdAt:
                      cubit.anotherUserPostsResponse!.posts[index].createdAt,
                  updatedAt:
                      cubit.anotherUserPostsResponse!.posts[index].updatedAt,
                  attachments: attachments,
                  v: cubit.anotherUserPostsResponse!.posts[index].v,
                  isLikedByMe: false,
                );
                return buildPostItem(
                    UserLoginCubit.get(context)
                        .anotherUserPostsResponse!
                        .posts[index],
                    LoggedInUser(
                        id: UserLoginCubit.get(context).loggedInUser!.id,
                        firstName:
                            UserLoginCubit.get(context).loggedInUser!.firstName,
                        lastName:
                            UserLoginCubit.get(context).loggedInUser!.lastName,
                        userName:
                            UserLoginCubit.get(context).loggedInUser!.userName,
                        slugUserName: UserLoginCubit.get(context)
                            .loggedInUser!
                            .slugUserName,
                        email: UserLoginCubit.get(context).loggedInUser!.email,
                        phone: UserLoginCubit.get(context).loggedInUser!.phone,
                        role: UserLoginCubit.get(context).loggedInUser!.role,
                        status:
                            UserLoginCubit.get(context).loggedInUser!.status,
                        images:
                            UserLoginCubit.get(context).loggedInUser!.images,
                        address:
                            UserLoginCubit.get(context).loggedInUser!.address,
                        gender:
                            UserLoginCubit.get(context).loggedInUser!.gender,
                        headquarters: UserLoginCubit.get(context)
                            .loggedInUser!
                            .headquarters,
                        specification: UserLoginCubit.get(context)
                            .loggedInUser!
                            .specification,
                        attachments: UserLoginCubit.get(context)
                            .loggedInUser!
                            .attachments,
                        following:
                            UserLoginCubit.get(context).loggedInUser!.following,
                        followers:
                            UserLoginCubit.get(context).loggedInUser!.followers,
                        updatedAt:
                            UserLoginCubit.get(context).loggedInUser!.updatedAt,
                        v: UserLoginCubit.get(context).loggedInUser!.v),
                    context);
              }
            }
            return const Text("No Posts Available");
          },
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
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
      return buildLoadingWidget(
          cubit.anotherUserPostsResponse?.posts.length ?? 0, context);
    }
  }

  Widget buildPostItem(PostWrapper? postWrapper, LoggedInUser loggedInUser,
      BuildContext context) {
    if (postWrapper == null) {
      return const SizedBox();
    }
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // Handling Post Duration
    DateTime? createdAt = postWrapper.createdAt;
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
          final postId = postWrapper.id;
          if (token != null) {
            HomeLayoutCubit.get(context).getPostId(
              token: token,
              postId: postId,
            );
            if (postWrapper.commentsCount > 0) {
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
                (postWrapper.sharedFrom != null)
                    ? Column(
                        children: [
                          SizedBox(height: screenHeight / 120),
                          sharedByUserInfo(postWrapper, loggedInUser, context),
                        ],
                      )
                    : const SizedBox(),
                SizedBox(height: screenHeight / 120),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        if (postWrapper.createdBy.id ==
                            UserLoginCubit.get(context).loggedInUser!.id) {
                          navigateToPage(context, const ProfilePage());
                        } else {
                          HomeLayoutCubit.get(context)
                              .getAnotherUserData(
                                  token: UserLoginCubit.get(context)
                                      .loginModel!
                                      .refresh_token,
                                  id: postWrapper.createdBy.id)
                              .then((value) {
                            print(postWrapper.createdBy.id);
                            UserLoginCubit.get(context)
                                .getAnotherUserPosts(
                                    token: UserLoginCubit.get(context)
                                        .loginModel!
                                        .refresh_token,
                                    id: postWrapper.createdBy.id,
                                    userName: postWrapper.createdBy.userName)
                                .then((value) {
                              UserLoginCubit.get(context).anotherUser =
                                  HomeLayoutCubit.get(context).anotherUser;
                              navigateToPage(
                                  context, const AnotherUserProfile());
                            });
                          });
                          UserLoginCubit.get(context).anotherUser?.id =
                              postWrapper.createdBy.id;
                          UserLoginCubit.get(context).anotherUser?.userName =
                              postWrapper.createdBy.userName;
                          navigateToPage(context, const AnotherUserProfile());
                        }
                      },
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.white,
                        backgroundImage: (postWrapper
                                    .createdBy.profilePic?.secureUrl !=
                                null)
                            ? NetworkImage(
                                    postWrapper.createdBy.profilePic!.secureUrl)
                                as ImageProvider
                            : const AssetImage("assets/images/nullProfile.png"),
                      ),
                    ),
                    SizedBox(width: screenWidth / 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            if (postWrapper.createdBy.id ==
                                UserLoginCubit.get(context).loggedInUser!.id) {
                              navigateToPage(context, const ProfilePage());
                            } else {
                              HomeLayoutCubit.get(context)
                                  .getAnotherUserData(
                                      token: UserLoginCubit.get(context)
                                          .loginModel!
                                          .refresh_token,
                                      id: postWrapper.createdBy.id)
                                  .then((value) {
                                UserLoginCubit.get(context).anotherUser =
                                    HomeLayoutCubit.get(context).anotherUser;
                                navigateToPage(
                                    context, const AnotherUserProfile());
                              });
                            }
                          },
                          child: Text(
                            postWrapper.createdBy.userName,
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
                        _showHomePageBottomSheet(postWrapper);
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
                      postWrapper.content != null
                          ? Text(
                              postWrapper.content,
                              maxLines:
                                  (postWrapper.attachments) != null ? 6 : 10,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: "Robot",
                                fontSize: 13.0,
                              ),
                            )
                          : const SizedBox(height: 0),

                      SizedBox(height: screenHeight / 100),

                      /// Post Attachments
                      if (postWrapper.attachments != null &&
                          postWrapper.attachments.isNotEmpty)
                        // check if there's more than one
                        if (postWrapper.attachments.length > 1)
                          CarouselSlider(
                            carouselController: carouselController,
                            items: postWrapper.attachments.map((attachment) {
                              return Image(
                                image: NetworkImage(attachment.secureUrl),
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
                              postWrapper.attachments[0].secureUrl,
                            ),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                      if (postWrapper.attachments != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: postWrapper.attachments
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
                      (postWrapper.likesCount) > 0
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
                      (postWrapper.likesCount > 0)
                          ? Text(
                              '${postWrapper.likesCount}',
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 12,
                                color: HexColor("575757"),
                              ),
                            )
                          : Container(),
                      const Spacer(),

                      /// Post Comments
                      if (postWrapper.commentsCount == 1)
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 50,
                            bottom: screenHeight / 50,
                          ),
                          child: Text(
                            '${postWrapper.commentsCount} Comment',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          ),
                        )
                      else if (postWrapper.likesCount > 0 &&
                          postWrapper.commentsCount == 1)
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 50,
                          ),
                          child: Text(
                            '${postWrapper.commentsCount} Comment',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          ),
                        )
                      else if (postWrapper.likesCount > 0 &&
                          postWrapper.commentsCount > 1)
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 50,
                          ),
                          child: Text(
                            '${postWrapper.commentsCount} Comments',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          ),
                        )
                      else if (postWrapper.commentsCount == 0)
                        Container()
                      else
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 50,
                            bottom: screenHeight / 50,
                          ),
                          child: Text(
                            '${postWrapper.commentsCount} Comments',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          ),
                        ),

                      /// Post Share Count
                      if (postWrapper.shareCount == 1)
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 23,
                            bottom: screenHeight / 50,
                          ),
                          child: Text(
                            '${postWrapper.shareCount} share',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          ),
                        )
                      else if (postWrapper.shareCount == 0)
                        Container()
                      else
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 23,
                            bottom: screenHeight / 50,
                          ),
                          child: Text(
                            '${postWrapper.shareCount} Shares',
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
                        (postWrapper.isLikedByMe == true)
                            ? postSubComponent(
                                "assets/images/NewLikeColor.svg",
                                "  Like",
                                color: HexColor("#2A57AA"),
                                context,
                                onTap: () {
                                  HomeLayoutCubit.get(context).likePost(
                                    postId: postWrapper.id,
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
                                      postId: postWrapper.id,
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
                            final postId = postWrapper.id;
                            if (token != null) {
                              HomeLayoutCubit.get(context).getPostId(
                                token: token,
                                postId: postId,
                              );
                              if (postWrapper.commentsCount > 0) {
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
                            shareSubComponent(postWrapper, context);
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

  Widget donationFormItem(
      DonationFormDetails? getOrgDonationFormsDetails, context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight / 4,
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
        padding: EdgeInsetsDirectional.only(
          start: screenWidth / 20,
          top: screenHeight / 50,
          end: screenWidth / 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getOrgDonationFormsDetails!.title,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight / 200),
            Row(
              children: [
                const Text(
                  'End Date:  ',
                  style: TextStyle(
                    fontSize: 9.0,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  DateFormat('dd-MM-yyyy')
                      .format(getOrgDonationFormsDetails.endDate),
                  style: const TextStyle(
                    fontSize: 9.0,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight / 50),
            Expanded(
              child: Text(
                getOrgDonationFormsDetails.description,
                style: const TextStyle(
                  fontSize: 11.0,
                  color: Colors.black45,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: screenHeight / 40),
            SizedBox(
              height: screenHeight / 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Donation Link: ",
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight / 150),
                  Expanded(
                    child: Text(
                      getOrgDonationFormsDetails.donationLink,
                      style: const TextStyle(
                        fontSize: 11.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2, // Adjust as needed
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHomePageBottomSheet(PostWrapper? postWrapper) {
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
                        postId: postWrapper!.id,
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
                        "https://volunhero.onrender.com/${postWrapper!.id}",
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

  Widget sharedByUserInfo(PostWrapper? postWrapper, LoggedInUser loggedInUser,
      BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        if (postWrapper.sharedBy!.id ==
            UserLoginCubit.get(context).loggedInUser!.id) {
          navigateToPage(context, const ProfilePage());
        } else {
          HomeLayoutCubit.get(context)
              .getAnotherUserData(
                  token: UserLoginCubit.get(context).loginModel!.refresh_token,
                  id: postWrapper.sharedBy!.id)
              .then((value) {
            UserLoginCubit.get(context)
                .getAnotherUserPosts(
                    token:
                        UserLoginCubit.get(context).loginModel!.refresh_token,
                    id: postWrapper.sharedBy!.id,
                    userName: postWrapper.sharedBy!.userName)
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
              backgroundColor: Colors.white,
              backgroundImage: postWrapper!.sharedBy!.profilePic != null
                  ? NetworkImage(postWrapper.sharedBy!.profilePic!.secureUrl)
                      as ImageProvider
                  : const AssetImage("assets/images/nullProfile.png"),
            ),
            SizedBox(width: screenWidth / 80),
            Text(
              (postWrapper.sharedBy!.userName == loggedInUser.userName)
                  ? 'You'
                  : postWrapper.sharedBy!.userName,
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

  void shareSubComponent(PostWrapper? postWrapper, context) {
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
                          postId: postWrapper!.id,
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
