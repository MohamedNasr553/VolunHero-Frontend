import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/layout/VolunHeroUserLayout/layout.dart';
import 'package:flutter_code/models/HomePagePostsModel.dart';
import 'package:flutter_code/models/LoggedInUserModel.dart';
import 'package:flutter_code/modules/GeneralView/CreatePost/CreatePost_Page.dart';
import 'package:flutter_code/modules/UserView/UserEditProfile/editProfile_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/components/constants.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

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
    UserLoginCubit.get(context).getLoggedInUserData(token:  UserLoginCubit.get(context).loginModel!.refresh_token ?? "");
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<UserLoginCubit, UserLoginStates>(
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
                navigateAndFinish(context, const VolunHeroUserLayout());
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Profile and Cover photo
                Stack(
                  children: [
                    // Cover Photo
                    Container(
                      height: screenHeight / 7.5,
                      width: double.infinity,
                      color: defaultColor,
                    ),
                    // Upload Cover Photo Icon

                    // Profile Photo
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: screenWidth / 25,
                        top: screenHeight / 13.5,
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          const CircleAvatar(
                            radius: 45.0,
                            backgroundImage:
                                AssetImage('assets/images/man_photo.png'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Username & UserEmail
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
                                    .anotherUser!
                                    .firstName,
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
                                    .anotherUser!
                                    .lastName,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black38.withOpacity(0.7),
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              SizedBox(width: screenWidth / 60),
                              (UserLoginCubit.get(context)
                                              .anotherUser!
                                              .specification ==
                                          'Medical' ||
                                      UserLoginCubit.get(context)
                                              .anotherUser!
                                              .specification ==
                                          'Educational')
                                  ? const Icon(Icons.verified,
                                      color: Colors.blue)
                                  : Container(),
                            ],
                          ),
                          const SizedBox(
                            height: 1.0,
                          ),
                          Text(
                            UserLoginCubit.get(context).anotherUser!.email,
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
                            UserLoginCubit.get(context).handleFollow(
                                token:  UserLoginCubit.get(context).loginModel!.refresh_token,
                                followId:  UserLoginCubit.get(context).anotherUser!.id
                            ).then((value) {
                              UserLoginCubit.get(context).getLoggedInUserData(token:  UserLoginCubit.get(context).loginModel!.refresh_token);
                              HomeLayoutCubit.get(context).getAnotherUserData(token:  UserLoginCubit.get(context).loginModel!.refresh_token, id:  UserLoginCubit.get(context).anotherUser!.id).then((value){
                                UserLoginCubit.get(context).anotherUser = HomeLayoutCubit.get(context).anotherUser;
                                UserLoginCubit.get(context).getAnotherUserFollowers();
                              });
                            });
                            showToast(text: UserLoginCubit.get(context).inFollowing(followId: UserLoginCubit.get(context).anotherUser!.id).toString(), state: ToastStates.SUCCESS);
                        },
                        child: (UserLoginCubit.get(context).inFollowing(followId: UserLoginCubit.get(context).anotherUser!.id ) == false)
                            ? Container(
                                decoration: BoxDecoration(
                                    color: defaultColor,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Center(
                                    child: (state is! FollowLoadingState)?(Text(
                                      "Follow",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )): Center(
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
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
                                    borderRadius: BorderRadius.circular(4)),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Center(
                                    child:(state is! FollowLoadingState)? (
                                        Text(
                                      "Following",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )): Center(
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                ),
                              ),
                      ))),
                      SizedBox(width: 2),
                      Expanded(
                          child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black38.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Center(
                              child: (Text(
                                "message",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
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
                          SizedBox(
                            height: screenHeight / 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "0",
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
                                        "${UserLoginCubit.get(context).anotherUser!.followers.length}",
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
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "${UserLoginCubit.get(context).anotherUser!.following.length}",
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
                          Row(
                            children: [
                              const Text(
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
                              SizedBox(
                                width: screenWidth / 30,
                              ),
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
                                            .anotherUser!
                                            .specification,
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
                                  "Lives in ${UserLoginCubit.get(context).anotherUser!.address}",
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 70,
                          ),
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
                                      .anotherUser!
                                      .phone,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Create post
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
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Posts",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: screenHeight / 100),
                          Container(
                            height: 1,
                            color: Colors.grey.shade300,
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "No Posts Yet",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // Posts
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
      itemCount: HomeLayoutCubit.get(context)
              .homePagePostsModel
              ?.modifiedPosts
              .length ??
          0,
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

  Widget buildPostsList(context) {
    var cubit = HomeLayoutCubit.get(context);

    if (cubit.homePagePostsModel != null) {
      if (cubit.homePagePostsModel!.modifiedPosts.isNotEmpty) {
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final homePagePostsModel = cubit.homePagePostsModel;
                  if (homePagePostsModel != null) {
                    if (index < homePagePostsModel.modifiedPosts.length) {
                      return buildPostItem(
                          homePagePostsModel.modifiedPosts[index], context);
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
                itemCount: cubit.homePagePostsModel!.modifiedPosts.length,
              ),
            ),
          ],
        );
      } else {
        return const Center(child: Text('No posts available'));
      }
    } else {
      return buildLoadingWidget(context);
    }
  }

  Widget buildPostItem(ModifiedPost? postDetails, BuildContext context) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: postDetails.createdBy.profilePic != null
                        ? AssetImage(postDetails.createdBy.profilePic!)
                        : null,
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
                    onPressed: () {},
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
                    if (postDetails.attachments.isNotEmpty)
                      // check if there's more than one
                      if (postDetails.attachments.length > 1)
                        CarouselSlider(
                          carouselController: carouselController,
                          items: postDetails.attachments.map((attachment) {
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
                              postDetails.attachments[0].secure_url),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          postDetails.attachments.asMap().entries.map((entry) {
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
                              'assets/images/Blue_Like.svg',
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
                    // postDetails.likesCount > 0
                    //     ? IconButton(
                    //   padding: EdgeInsets.zero,
                    //   onPressed: () {},
                    //   icon: SvgPicture.asset(
                    //     'assets/images/like.svg',
                    //   ),
                    // )
                    //     : Container(),
                    // (postDetails.likesCount > 0) ?
                    // Text(
                    //   '${postDetails.likesCount}',
                    //   style: TextStyle(
                    //     fontFamily: "Roboto",
                    //     fontSize: 12,
                    //     color: HexColor("575757"),
                    //   ),
                    // ): Container(),
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
                      postSubComponent("assets/images/like.svg", "Like"),
                      const Spacer(),
                      postSubComponent("assets/images/comment.svg", "Comment"),
                      const Spacer(),
                      postSubComponent("assets/images/share.svg", "Share"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget postSubComponent(String assetIcon, String action) {
    return InkWell(
      onTap: () {
        showToast(text: action, state: ToastStates.SUCCESS);
      },
      child: Row(
        children: [
          SvgPicture.asset(assetIcon),
          const SizedBox(
            width: 1,
          ),
          Text(
            action,
            style: TextStyle(
                fontSize: 12, fontFamily: "Roboto", color: HexColor("575757")),
          )
        ],
      ),
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
