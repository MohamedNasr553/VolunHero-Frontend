import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/layout/VolunHeroUserLayout/layout.dart';
import 'package:flutter_code/modules/UserView/UserEditProfile/editProfile_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  List<Map<String, dynamic>> posts = [];

  @override
  Widget build(BuildContext context) {
    String userName = "Mahmoud Nader";
    String userEmail = "mahnader222@gmail.com";
    String phoneNumber = "+201127264619";
    String university =
        "Faculty of Computers and Artificial intelligence - Cairo University";
    String city = "Cairo";

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var postController = TextEditingController();

    for (int i = 1; i <= 5; i++) {
      if (i % 2 == 0) {
        posts.add({
          'photo': 'assets/images/logo.png',
          // Dummy image filename
          'name': 'User $i Name',
          // Dummy description
          'text':
              "Do you know of a shelter that accepts clothing donation or household applications? Your recommendations are much appreciated! ",
          // Calculate time ago
          'image': 'assets/images/Rectangle 4160.png',
          'duration': '2h.',
          'mutual': "Anas Ahmed and 3 others",
          'comments': "$i comments"
        });
      } else {
        posts.add({
          'photo': 'assets/images/logo.png',
          // Dummy image filename
          'name': 'User $i Name',
          // Dummy description
          'text':
              "Do you know of a shelter that accepts clothing donation or household applications? Your recommendations are much appreciated! ",
          // Calculate time ago
          // 'image': 'assets/images/Rectangle 4160.png',
          'duration': '2h.',
          'mutual': "Anas Ahmed and 3 others",
          'comments': "$i comments"
        });
      }
      if (i == 3) {
        posts.add({
          'photo': 'assets/images/logo.png',
          // Dummy image filename
          'name': 'User $i Name',
          // Dummy description
          //'text': "Do you know of a shelter that accepts clothing donation or household applications? Your recommendations are much appreciated! ", // Calculate time ago
          'image': 'assets/images/Rectangle 4160.png',
          'duration': '2h.',
          'mutual': "Anas Ahmed and 3 others",
          'comments': "$i comments"
        });
      }
    }

    return BlocConsumer<UserLoginCubit,UserLoginStates>(
      listener: (context,state){},
      builder: (context,state){
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
                          const CircleAvatar(
                            radius: 45.0,
                            backgroundImage: AssetImage('assets/images/man_photo.png'),
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
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: [
                          Row(
                            children: [
                              Text(
                               UserLoginCubit.get(context).loggedInUser!.firstName,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black38.withOpacity(0.7),
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              SizedBox(width: screenWidth / 90),
                              Text(
                                UserLoginCubit.get(context).loggedInUser!.lastName,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black38.withOpacity(0.7),
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Poppins',
                                ),
                              ),
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
                          offset: const Offset(10.0, 10.0), // Right and bottom shadow
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
                          SizedBox(height: screenHeight/100,),
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
                                        "${(UserLoginCubit.get(context).loggedInUser!.followers.length >= 1)?UserLoginCubit.get(context).loggedInUser!.followers.length:0}",
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
                                        "${(UserLoginCubit.get(context).loggedInUser!.following.length >= 1)?UserLoginCubit.get(context).loggedInUser!.following.length:0}",
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
                          offset: const Offset(10.0, 10.0), // Right and bottom shadow
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
                                  navigateToPage(context, UserEditProfile());
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
                                        color: Colors.black.withOpacity(0.7),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      UserLoginCubit.get(context).loggedInUser!.specification,
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: defaultColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              )
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
                                  UserLoginCubit.get(context).loggedInUser!.phone,
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
                          offset: const Offset(10.0, 10.0), // Right and bottom shadow
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
                            padding: EdgeInsets.only(left: screenWidth / 20),
                            child: Row(
                              children: [
                                Container(
                                  width: screenWidth / 1.5,
                                  child: TextFormField(
                                    controller: postController,
                                    decoration: const InputDecoration(
                                      hintText: "What's on your mind ?",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                      ),
                                      border:
                                      InputBorder.none, // Hide the border line
                                    ),
                                    maxLines: null,
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
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => buildPostItem(index, context),
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ),
                  itemCount: posts.length,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPostItem(index, context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Padding(
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
              offset: const Offset(10.0, 10.0), // Right and bottom shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: AssetImage(posts[index]['photo']),
                  ),
                  SizedBox(
                    width: screenWidth / 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        posts[index]['name'],
                        style: const TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 0.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            posts[index]['duration'],
                            style: TextStyle(
                                color: HexColor("B8B9BA"), fontSize: 10),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          SvgPicture.asset(
                            'assets/images/earthIcon.svg',
                          ),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/images/postSettings.svg',
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/images/closePost.svg',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    posts[index]['text'] != null
                        ? Text(
                            posts[index]['text'],
                            maxLines: posts[index]['image'] != null ? 2 : 5,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: "Robot",
                              fontSize: 12,
                            ),
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    posts[index]['image'] != null
                        ? SizedBox(
                            height: screenHeight / 100,
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    posts[index]['image'] != null
                        ? Image.asset(
                            posts[index]['image'],
                          )
                        : Container(
                            height: 0.5,
                          )
                  ],
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.add_reaction),
                    SizedBox(
                      width: screenWidth / 100,
                    ),
                    Text(
                      posts[index]['mutual'],
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 12,
                          color: HexColor("575757")),
                    ),
                    const Spacer(),
                    Text(
                      posts[index]['comments'],
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 12,
                          color: HexColor("575757")),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                height: 1,
                color: Colors.grey[200],
              ),
              Center(
                child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        postSubComponent("assets/images/like.svg", "Like"),
                        const Spacer(),
                        postSubComponent(
                            "assets/images/comment.svg", "Comment"),
                        const Spacer(),
                        postSubComponent("assets/images/share.svg", "Share"),
                      ],
                    )),
              )
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
      child: Container(
        child: Row(
          children: [
            SvgPicture.asset(assetIcon),
            const SizedBox(
              width: 1,
            ),
            Text(
              action,
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Roboto",
                  color: HexColor("575757")),
            )
          ],
        ),
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
