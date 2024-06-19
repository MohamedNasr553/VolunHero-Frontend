import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/states.dart';
import 'package:flutter_code/layout/VolunHeroUserLayout/layout.dart';
import 'package:flutter_code/models/LoggedInUserModel.dart';
import 'package:flutter_code/models/OwnerPostsModel.dart';
import 'package:flutter_code/modules/GeneralView/CreatePost/CreatePost_Page.dart';
import 'package:flutter_code/modules/UserView/UserEditProfile/editProfile_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final CarouselController carouselController = CarouselController();
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    UserLoginCubit.get(context).getLoggedInUserData(
        token: UserLoginCubit.get(context).loginModel!.refresh_token ?? "");
    HomeLayoutCubit.get(context).getOwnerPosts(
        token: UserLoginCubit.get(context).loginModel!.refresh_token ?? "");
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var postController = TextEditingController();

    return BlocConsumer<HomeLayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<HomeLayoutCubit, LayoutStates>(
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
                                backgroundImage: (HomeLayoutCubit.get(context)
                                    .modifiedPost
                                    ?.createdBy
                                    ?.profilePic ==
                                    null)
                                    ? AssetImage(
                                    'assets/images/nullProfile.png')
                                    : AssetImage(
                                    'assets/images/${HomeLayoutCubit.get(context).modifiedPost?.createdBy?.profilePic}'),
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
                                        .loggedInUser!
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
                                        .loggedInUser!
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
                                                  .loggedInUser!
                                                  .specification ==
                                              'Medical' ||
                                          UserLoginCubit.get(context)
                                                  .loggedInUser!
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
                                UserLoginCubit.get(context).loggedInUser!.email,
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
                                      child: Column(
                                        children: [
                                          Text(
                                            "${(UserLoginCubit.get(context).loggedInUser!.followers.length >= 1) ? UserLoginCubit.get(context).loggedInUser!.followers.length : 0}",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Followers",
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
                                      child: Column(
                                        children: [
                                          Text(
                                            "${(UserLoginCubit.get(context).loggedInUser!.following.length >= 1) ? UserLoginCubit.get(context).loggedInUser!.following.length : 0}",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Following",
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
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      navigateToPage(
                                          context, UserEditProfile());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        border: Border.all(
                                          color: HexColor("027E81"),
                                        ),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                          left: 8.0,
                                          right: 8.0,
                                          bottom: 4.0,
                                          top: 4.0,
                                        ),
                                        child: Text(
                                          "Edit Profile",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Poppins",
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
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
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            UserLoginCubit.get(context)
                                                .loggedInUser!
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
                                      "Lives in ${UserLoginCubit.get(context).loggedInUser!.address}",
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
                                          .loggedInUser!
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
                                "Your Posts",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(height: screenHeight / 100),
                              Container(
                                height: 1,
                                color: Colors.grey.shade300,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: screenWidth / 20),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        navigateToPage(context, CreatePost());
                                      },
                                      child: Container(
                                        width: screenWidth / 1.5,
                                        child: TextFormField(
                                          controller: postController,
                                          decoration: const InputDecoration(
                                            hintText: "What's on your mind ?",
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                            ),
                                            border: InputBorder
                                                .none, // Hide the border line
                                          ),
                                          maxLines: null,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      // Upload photo from device Gallery
                                      onPressed: _uploadPhoto,
                                      icon: Image.asset(
                                        'assets/images/Img_box_duotone_line.png',
                                        width: 25.0,
                                        height: 25.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Posts
                    (state is! OwnerPostsLoadingState)
                        ? SizedBox(
                            height: screenHeight,
                            child: buildPostsList(context),
                          )
                        : buildLoadingWidget(context),
                  ],
                ),
              ),
            );
          },
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

  Widget buildPostsList(context) {
    var ownerPostsCubit = HomeLayoutCubit.get(context);
    var loginCubit = UserLoginCubit.get(context);

    if (ownerPostsCubit.ownerPostsModel != null) {
      if (ownerPostsCubit.ownerPostsModel!.newPosts.isNotEmpty) {
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final ownerPostsModel = ownerPostsCubit.ownerPostsModel;
                  if (ownerPostsModel != null) {
                    if (index < ownerPostsModel.newPosts.length) {
                      return buildPostItem(ownerPostsModel.newPosts[index],
                          loginCubit.loggedInUserData!.doc, context);
                    }
                  }
                  return const SizedBox(); // Return an empty SizedBox if no post is available
                },
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),
                itemCount: ownerPostsCubit.ownerPostsModel!.newPosts.length,
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

  Widget buildPostItem(Posts? postDetails, LoggedInUser loggedInUser, context) {
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
              (postDetails.createdBy.userName != loggedInUser.userName) ?
                  Padding(
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
                  ) : const SizedBox(height: 1),
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
                    onPressed: () => _showProfilePageBottomSheet(postDetails),
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
                      postSubComponent("assets/images/comment.svg", "Comment"),
                      const Spacer(),
                      postSubComponent("assets/images/share.svg", "Repost"),
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

  void _showProfilePageBottomSheet(Posts? postDetails) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        var screenHeight = MediaQuery.of(context).size.height;

        return Container(
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
