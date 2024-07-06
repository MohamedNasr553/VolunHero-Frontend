import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_code/bloc/DonationForm_bloc/cubit.dart';
import 'package:flutter_code/bloc/DonationForm_bloc/states.dart';
import 'package:flutter_code/models/GetAllDonationFormsModel.dart';
import 'package:http/http.dart' as http;
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
import 'package:flutter_code/models/LoggedInUserModel.dart';
import 'package:flutter_code/models/OwnerPostsModel.dart';
import 'package:flutter_code/modules/GeneralView/DetailedPost/Detailed_Post.dart';
import 'package:flutter_code/modules/GeneralView/EditPost/Edit_Post.dart';
import 'package:flutter_code/modules/GeneralView/FollowersPage/FollowersPage.dart';
import 'package:flutter_code/modules/GeneralView/FollowingsPage/FollowingsPage.dart';
import 'package:flutter_code/modules/GeneralView/AnotherUser/anotherUser_page.dart';
import 'package:flutter_code/modules/GeneralView/EditProfile/editProfile_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final CarouselController carouselController = CarouselController();
  int _currentImageIndex = 0;

  final _picker = ImagePicker();
  File? _profilePic;

  // bool showPosts = true;
  String pressedState = 'About';

  @override
  void initState() {
    super.initState();
    UserLoginCubit.get(context).getLoggedInUserData(
        token: UserLoginCubit.get(context).loginModel!.refresh_token ?? "");
    HomeLayoutCubit.get(context).getOwnerPosts(
        token: UserLoginCubit.get(context).loginModel!.refresh_token ?? "");
  }

  Future<void> uploadProfilePhoto() async {
    if (_profilePic == null) {
      print('No profile picture selected');
      return;
    }

    try {
      final request = http.MultipartRequest(
        'PATCH',
        Uri.parse('https://volunhero.onrender.com/api/users/updateProfilePic'),
      );

      final token = UserLoginCubit.get(context).loginModel!.refresh_token ?? "";
      request.headers['Authorization'] = 'Volunhero__$token';

      print('Profile Pic: ${_profilePic!.path}');
      request.files.add(
        await http.MultipartFile.fromPath(
          'profilePic',
          _profilePic!.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      final response = await request.send();
      final responseString = await response.stream.bytesToString();
      print('Response status: ${response.statusCode}');
      print('Response body: $responseString');

      if (response.statusCode == 200) {
        setState(() {
          // Update _profilePic with the new image file
          _profilePic = null; // Clear _profilePic after successful upload
        });

        // Show success message and navigate if needed
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: defaultColor,
          content: Text(
            'Profile picture added',
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
        ));
        navigateToPage(context, const ProfilePage());
      } else {
        print('Failed to upload photo');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Failed to upload photo',
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
        ));
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Unexpected error',
          style: TextStyle(
            fontSize: 12.0,
          ),
        ),
      ));
    }
  }

  Future<void> _pickProfilePic() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profilePic = File(pickedFile!.path);
    });
  }

  void _uploadPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _profilePic = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<UserLoginCubit, UserLoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
                                        backgroundColor: Colors.transparent,
                                        radius: 45.0,
                                        backgroundImage: (_profilePic != null)
                                            ? FileImage(_profilePic!)
                                            : (UserLoginCubit.get(context)
                                                        .loggedInUser
                                                        ?.profilePic
                                                        ?.secure_url !=
                                                    null)
                                                ? NetworkImage(
                                                        UserLoginCubit.get(
                                                                context)
                                                            .loggedInUser!
                                                            .profilePic!
                                                            .secure_url)
                                                    as ImageProvider
                                                : const AssetImage(
                                                    "assets/images/nullProfile.png"),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await _pickProfilePic();
                                          _uploadPhoto();
                                          await uploadProfilePhoto();
                                        },
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            // color: Colors.grey.shade300,
                                            color: defaultColor,
                                          ),
                                          child: const Icon(
                                            Icons.camera_alt_outlined,
                                            size: 21,
                                            color: Colors.white,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            UserLoginCubit.get(context)
                                                .loggedInUser!
                                                .firstName,
                                            style: TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.black38
                                                  .withOpacity(0.7),
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
                                              fontSize: 17.0,
                                              color: Colors.black38
                                                  .withOpacity(0.7),
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
                                                      'Educational' ||
                                                  UserLoginCubit.get(context)
                                                          .loggedInUser!
                                                          .role ==
                                                      "Organization")
                                              ? const Icon(Icons.verified,
                                                  color: Colors.blue)
                                              : Container(),
                                        ],
                                      ),
                                      const SizedBox(height: 1.0),
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(
                                          start: screenWidth / 90,
                                        ),
                                        child: Text(
                                          UserLoginCubit.get(context)
                                              .loggedInUser!
                                              .email,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontWeight: FontWeight.w700,
                                          ),
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
                                      offset: const Offset(10.0, 10.0),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                    HomeLayoutCubit.get(context)
                                                            .ownerPostsModel
                                                            ?.newPosts
                                                            .length
                                                            .toString() ??
                                                        "0",
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.black
                                                          .withOpacity(0.7),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Posts",
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black
                                                          .withOpacity(0.7),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  UserLoginCubit.get(context)
                                                      .getMyFollowers(
                                                    token: UserLoginCubit.get(
                                                                context)
                                                            .loginModel!
                                                            .refresh_token ??
                                                        "",
                                                  );
                                                  navigateToPage(context,
                                                      const FollowersPage());
                                                },
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "${(UserLoginCubit.get(context).loggedInUser!.followers.isNotEmpty) ? UserLoginCubit.get(context).loggedInUser!.followers.length : 0}",
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black
                                                            .withOpacity(0.7),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Followers",
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.black
                                                            .withOpacity(0.7),
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                      .getMyFollowings(
                                                    token: UserLoginCubit.get(
                                                                context)
                                                            .loginModel!
                                                            .refresh_token ??
                                                        "",
                                                  );
                                                  navigateToPage(context,
                                                      const FollowingsPage());
                                                },
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "${(UserLoginCubit.get(context).loggedInUser!.following.isNotEmpty) ? UserLoginCubit.get(context).loggedInUser!.following.length : 0}",
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black
                                                            .withOpacity(0.7),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Following",
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.black
                                                            .withOpacity(0.7),
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                    width: screenWidth / 11.5,
                                                    color: Colors.white,
                                                    child: Text(
                                                      "About",
                                                      style: TextStyle(
                                                        color: (pressedState ==
                                                                'About')
                                                            ? defaultColor
                                                            : Colors.black54,
                                                        fontFamily: "Poppins",
                                                        fontSize: 11.5,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  (pressedState == 'About')
                                                      ? Container(
                                                          width: screenWidth /
                                                              11.3,
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
                                                        color: (pressedState ==
                                                                'Posts')
                                                            ? defaultColor
                                                            : Colors.black54,
                                                        fontFamily: "Poppins",
                                                        fontSize: 11.5,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  (pressedState == 'Posts')
                                                      ? Container(
                                                          width: screenWidth /
                                                              12.5,
                                                          height: 2.7,
                                                          color: defaultColor,
                                                        )
                                                      : const SizedBox()
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: screenWidth / 15),
                                            (UserLoginCubit.get(context)
                                                        .loggedInUser
                                                        ?.role ==
                                                    "Organization")
                                                ? GestureDetector(
                                                    onTap: () {
                                                      DonationFormCubit.get(
                                                              context)
                                                          .getOrgDonationForms(
                                                        token: UserLoginCubit
                                                                    .get(
                                                                        context)
                                                                .loginModel!
                                                                .refresh_token ??
                                                            "",
                                                        orgId: UserLoginCubit.get(context).loggedInUser!.id,
                                                      );
                                                      setState(() {
                                                        // showPosts = true;
                                                        pressedState =
                                                            'Donation Forms';
                                                      });
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height:
                                                              screenHeight / 40,
                                                          width:
                                                              screenWidth / 4,
                                                          color: Colors.white,
                                                          child: Text(
                                                            'Donation Forms',
                                                            style: TextStyle(
                                                              color: (pressedState ==
                                                                      'Donation Forms')
                                                                  ? defaultColor
                                                                  : Colors
                                                                      .black54,
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontSize: 11.5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        (pressedState ==
                                                                'Donation Forms')
                                                            ? Container(
                                                                width:
                                                                    screenWidth /
                                                                        4.3,
                                                                height: 2.7,
                                                                color:
                                                                    defaultColor,
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
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                    navigateToPage(context,
                                                        UserEditProfile());
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                      border: Border.all(
                                                        color:
                                                            HexColor("027E81"),
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
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                                  padding: EdgeInsetsDirectional
                                                      .only(
                                                    start: screenWidth / 180,
                                                  ),
                                                  child: SvgPicture.asset(
                                                      'assets/images/Specification.svg'),
                                                ),
                                                SizedBox(
                                                    width: screenWidth / 30),
                                                SizedBox(
                                                  width: screenWidth / 1.5,
                                                  child: (UserLoginCubit.get(
                                                                  context)
                                                              .loggedInUser
                                                              ?.role ==
                                                          "Organization")
                                                      ? Row(
                                                          children: [
                                                            Text(
                                                              "Role: ",
                                                              style: TextStyle(
                                                                fontSize: 12.0,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.7),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              UserLoginCubit.get(
                                                                      context)
                                                                  .loggedInUser!
                                                                  .role,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12.0,
                                                                color:
                                                                    defaultColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Row(
                                                          children: [
                                                            Text(
                                                              "Specification: ",
                                                              style: TextStyle(
                                                                fontSize: 12.0,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.7),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              UserLoginCubit.get(
                                                                      context)
                                                                  .loggedInUser!
                                                                  .specification,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12.0,
                                                                color:
                                                                    defaultColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: screenHeight / 60),
                                            Row(
                                              children: [
                                                const Icon(
                                                    Icons.location_on_outlined),
                                                SizedBox(
                                                    width: screenWidth / 30),
                                                SizedBox(
                                                  width: screenWidth / 1.5,
                                                  child: (UserLoginCubit.get(
                                                                  context)
                                                              .loggedInUser
                                                              ?.role ==
                                                          "Organization")
                                                      ? Text(
                                                          "Location: ${UserLoginCubit.get(context).loggedInUser!.address}",
                                                        )
                                                      : Text(
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
                                                SizedBox(
                                                    width: screenWidth / 30),
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
                                  GestureDetector(
                                    onTap: () {
                                      UserLoginCubit.get(context)
                                                  .loggedInUser
                                                  ?.role ==
                                              "Organization"
                                          ? HomeLayoutCubit.get(context)
                                              .changeOrganizationBottomNavBar(
                                                  context, 2)
                                          : HomeLayoutCubit.get(context)
                                              .changeUserBottomNavBar(
                                                  context, 2);
                                      navigateAndFinish(
                                          context, const VolunHeroLayout());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              blurRadius: 10.0,
                                              spreadRadius: -5.0,
                                              offset: const Offset(10.0,
                                                  10.0), // Right and bottom shadow
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Your Posts",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              SizedBox(
                                                  height: screenHeight / 100),
                                              Container(
                                                height: 1,
                                                color: Colors.grey.shade300,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: screenWidth / 20),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: screenWidth / 1.5,
                                                      child: const Text(
                                                        "What's on your mind ?",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14.0,
                                                        ),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    IconButton(
                                                      onPressed: () {},
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
                                  ),
                                  // Posts
                                  if (HomeLayoutCubit.get(context)
                                              .ownerPostsModel !=
                                          null &&
                                      HomeLayoutCubit.get(context)
                                          .ownerPostsModel!
                                          .newPosts
                                          .isEmpty)
                                    Padding(
                                      padding: EdgeInsets.all(screenWidth / 60),
                                      child: Container(
                                        height: screenHeight / 10,
                                        width: screenWidth,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                            SizedBox(
                                                height: screenHeight / 200),
                                            const Text(
                                              "No Posts Available",
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Roboto",
                                                color: Colors.black87,
                                              ),
                                            ),
                                            SizedBox(
                                                height: screenHeight / 300),
                                            const Text(
                                              "Your Posts "
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
                                  else
                                    buildPostsList(context)
                                ],
                              )
                            else if (pressedState == 'Posts')
                              // Create post
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      UserLoginCubit.get(context)
                                                  .loggedInUser
                                                  ?.role ==
                                              "Organization"
                                          ? HomeLayoutCubit.get(context)
                                              .changeOrganizationBottomNavBar(
                                                  context, 2)
                                          : HomeLayoutCubit.get(context)
                                              .changeUserBottomNavBar(
                                                  context, 2);
                                      navigateAndFinish(
                                          context, const VolunHeroLayout());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              blurRadius: 10.0,
                                              spreadRadius: -5.0,
                                              offset: const Offset(10.0,
                                                  10.0), // Right and bottom shadow
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Your Posts",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              SizedBox(
                                                  height: screenHeight / 100),
                                              Container(
                                                height: 1,
                                                color: Colors.grey.shade300,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: screenWidth / 20),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: screenWidth / 1.5,
                                                      child: const Text(
                                                        "What's on your mind ?",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14.0,
                                                        ),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    IconButton(
                                                      onPressed: () {},
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
                                  ),
                                  // Posts
                                  if (HomeLayoutCubit.get(context)
                                              .ownerPostsModel !=
                                          null &&
                                      HomeLayoutCubit.get(context)
                                          .ownerPostsModel!
                                          .newPosts
                                          .isEmpty)
                                    Padding(
                                      padding: EdgeInsets.all(screenWidth / 60),
                                      child: Container(
                                        height: screenHeight / 10,
                                        width: screenWidth,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                            SizedBox(
                                                height: screenHeight / 200),
                                            const Text(
                                              "No Posts Available",
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Roboto",
                                                color: Colors.black87,
                                              ),
                                            ),
                                            SizedBox(
                                                height: screenHeight / 300),
                                            const Text(
                                              "Your Posts "
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
                                  else
                                    buildPostsList(context)
                                ],
                              )
                            else if (pressedState == 'Donation Forms')
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
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Widget buildPostsList(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var ownerPostsCubit = HomeLayoutCubit.get(context);
    var loginCubit = UserLoginCubit.get(context);

    if (ownerPostsCubit.ownerPostsModel == null) {
      return buildLoadingWidget(
          ownerPostsCubit.ownerPostsModel?.newPosts.length ?? 0, context);
    }

    return SizedBox(
      height: screenHeight,
      child: ListView.separated(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final ownerPostsModel = ownerPostsCubit.ownerPostsModel;
          if (ownerPostsModel != null) {
            if (index < ownerPostsModel.newPosts.length) {
              return buildPostItem(ownerPostsModel.newPosts[index],
                  loginCubit.loggedInUserData!.doc, context);
            }
          }
          return const SizedBox();
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
    );
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
                          HomeLayoutCubit.get(context)
                              .getAnotherUserData(
                                  token: UserLoginCubit.get(context)
                                      .loginModel!
                                      .refresh_token,
                                  id: postDetails.createdBy.id)
                              .then((value) {
                            UserLoginCubit.get(context)
                                .getAnotherUserPosts(
                                    token: UserLoginCubit.get(context)
                                        .loginModel!
                                        .refresh_token,
                                    id: postDetails.createdBy.id,
                                    userName: postDetails.createdBy.userName)
                                .then((value) {
                              UserLoginCubit.get(context).anotherUser =
                                  HomeLayoutCubit.get(context).anotherUser;
                              navigateToPage(
                                  context, const AnotherUserProfile());
                            });
                          });
                        }
                      },
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundImage: (postDetails.createdBy.profilePic !=
                                null)
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
                        (postDetails.sharedFrom == null)
                            ? _showProfilePageBottomSheet(
                                postDetails, loggedInUser)
                            : _showSharedPostProfilePageBottomSheet(
                                postDetails, loggedInUser);
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
                      /// Post Likes Count
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
                            "assets/images/comment.svg", "Comment", context,
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
                        }),
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

  Widget donationFormItem(
      DonationFormDetails? getOrgDonationFormsDetails, context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth / 2,
      height: screenHeight / 5,
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
          bottom: screenHeight / 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: screenWidth / 20,
                top: screenHeight / 50,
                end: screenWidth / 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
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
                    ],
                  ),
                  SizedBox(height: screenHeight / 50),
                  Text(
                    getOrgDonationFormsDetails.description,
                    style: const TextStyle(
                      fontSize: 11.0,
                      color: Colors.black45,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight / 40),
                  Row(
                    children: [
                      const Text(
                        "Donation Link: ",
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        getOrgDonationFormsDetails.donationLink,
                        style: const TextStyle(
                          fontSize: 11.0,
                          color: Colors.blue,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProfilePageBottomSheet(
      Posts? postDetails, LoggedInUser? loggedInUser) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        var screenHeight = MediaQuery.of(context).size.height;
        var screenWidth = MediaQuery.of(context).size.width;

        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: screenHeight / 3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// Save Post
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
                        postId: postDetails!.id,
                      );
                      Navigator.pop(context);
                    },
                  ),

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
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
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
                      final token =
                          UserLoginCubit.get(context).loginModel?.refresh_token;
                      final postId = postDetails!.id;
                      if (token != null) {
                        HomeLayoutCubit.get(context).getPostId(
                          token: token,
                          postId: postId,
                        );
                      }
                      navigateToPage(context, const EditPost());
                    },
                  ),

                  /// Copy Post URl
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
                        "https://volunhero.onrender.com/${postDetails!.id}",
                        context,
                      );
                    },
                  ),

                  /// Delete Post / Remove Share
                  ListTile(
                    leading: const Icon(
                      Icons.delete_forever,
                      size: 25,
                    ),
                    title: (postDetails!.sharedFrom == null)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Delete Post',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: screenHeight / 130),
                              const Text(
                                'Remove this post from your profile.',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Remove Share',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: screenHeight / 130),
                              const Text(
                                'Remove this post from your profile.',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                    onTap: () {
                      if (postDetails.sharedFrom == null) {
                        // Delete Post
                        HomeLayoutCubit.get(context).deletePost(
                          token: UserLoginCubit.get(context)
                                  .loginModel!
                                  .refresh_token ??
                              "",
                          postId: postDetails.id,
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: defaultColor,
                          content: Text(
                            'Post Deleted',
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ));
                      } else {
                        // Delete Share
                        HomeLayoutCubit.get(context).removeShare(
                          token: UserLoginCubit.get(context)
                                  .loginModel!
                                  .refresh_token ??
                              "",
                          postId: postDetails.id,
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: defaultColor,
                          content: Text(
                            'Removed',
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ));
                      }
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

  void _showSharedPostProfilePageBottomSheet(
      Posts? postDetails, LoggedInUser? loggedInUser) {
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
                  /// Save Post
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
                        postId: postDetails!.id,
                      );
                      Navigator.pop(context);
                    },
                  ),

                  /// Copy Post URl
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
                        "https://volunhero.onrender.com/${postDetails!.id}",
                        context,
                      );
                    },
                  ),

                  /// Delete Post / Remove Share
                  ListTile(
                    leading: const Icon(
                      Icons.delete_forever,
                      size: 25,
                    ),
                    title: (postDetails!.sharedFrom == null)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Delete Post',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: screenHeight / 130),
                              const Text(
                                'Remove this post from your profile.',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Remove Share',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: screenHeight / 130),
                              const Text(
                                'Remove this post from your profile.',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                    onTap: () {
                      if (postDetails.sharedFrom == null) {
                        // Delete Post
                        HomeLayoutCubit.get(context).deletePost(
                          token: UserLoginCubit.get(context)
                                  .loginModel!
                                  .refresh_token ??
                              "",
                          postId: postDetails.id,
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: defaultColor,
                          content: Text(
                            'Post Deleted',
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ));
                      } else {
                        // Delete Share
                        HomeLayoutCubit.get(context).removeShare(
                          token: UserLoginCubit.get(context)
                                  .loginModel!
                                  .refresh_token ??
                              "",
                          postId: postDetails.id,
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: defaultColor,
                          content: Text(
                            'Removed',
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ));
                      }
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

  Widget sharedByUserInfo(
      Posts? postDetails, LoggedInUser loggedInUser, BuildContext context) {
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
              backgroundColor: Colors.white,
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

  void shareSubComponent(Posts? postDetails, context) {
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
