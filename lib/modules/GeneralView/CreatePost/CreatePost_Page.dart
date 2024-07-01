import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/CreatePost_bloc/cubit.dart';
import 'package:flutter_code/bloc/CreatePost_bloc/states.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/layout/VolunHeroUserLayout/layout.dart';
import 'package:flutter_code/models/LoggedInUserModel.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  var postContentController = TextEditingController();
  File? postAttachment;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSize = MediaQuery.of(context).viewInsets.bottom;

    return BlocConsumer<CreatePostCubit, CreatePostStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var screenHeight = MediaQuery.of(context).size.height;
        var screenWidth = MediaQuery.of(context).size.width;

        return BlocConsumer<UserLoginCubit, UserLoginStates>(
            listener: (context, states) {},
            builder: (context, states) {
              return BlocConsumer<CreatePostCubit, CreatePostStates>(
                  listener: (context, states) {},
                  builder: (context, states) {
                    final userLoginCubit = UserLoginCubit.get(context);

                    return Scaffold(
                      appBar: AppBar(
                        backgroundColor: HexColor("027E81"),
                        leading: IconButton(
                          onPressed: () {
                            HomeLayoutCubit.get(context).changeBottomNavBar(0);
                            navigateAndFinish(
                                context, const VolunHeroUserLayout());
                          },
                          icon: SvgPicture.asset(
                            'assets/images/closePost.svg',
                            color: Colors.white,
                          ),
                        ),
                        title: const Text(
                          'Create Post',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 18.0,
                          ),
                        ),
                        centerTitle: true,
                        actions: [
                          Padding(
                            padding: EdgeInsets.all(screenWidth / 50),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (state is! CreatePostLoadingState) {
                                  List<Map<String, dynamic>>
                                      attachmentsMapList = [];
                                  if (postAttachment != null) {
                                    // Display the attachment
                                    Image.file(postAttachment!);
                                    attachmentsMapList.add({
                                      'secure_url': postAttachment!.path,
                                      'public_id': 'unique_id',
                                    });
                                  }
                                  if (postContentController.text.isEmpty) {
                                    showToast(
                                      text: "Please enter your post content",
                                      state: ToastStates.ERROR,
                                    );
                                    return;
                                  }
                                  CreatePostCubit.get(context).createPost(
                                    content: postContentController.text,
                                    attachments: attachmentsMapList,
                                    token: UserLoginCubit.get(context)
                                            .loginModel!
                                            .refresh_token ??
                                        "",
                                  );
                                  HomeLayoutCubit.get(context).getAllPosts(
                                      token: UserLoginCubit.get(context)
                                              .loginModel!
                                              .refresh_token ??
                                          "");

                                  // Change Bottom Nav Bar to Home Screen
                                  HomeLayoutCubit.get(context)
                                      .changeBottomNavBar(0);
                                  navigateAndFinish(
                                      context, const VolunHeroUserLayout());
                                } else if (state is! CreatePostErrorState) {
                                  showToast(
                                    text: "Something went wrong",
                                    state: ToastStates.ERROR,
                                  );
                                } else {
                                  const Center(
                                    child: LinearProgressIndicator(
                                      color: defaultColor,
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                fixedSize:
                                    Size(screenWidth / 5, screenHeight / 90),
                              ),
                              child: Text(
                                'Post',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor("027E81"),
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      body: Builder(
                        builder: (BuildContext scaffoldContext) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                /// Name and Post Content
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: screenWidth / 55),
                                  child: Column(
                                    children: [
                                      SizedBox(height: screenHeight / 40),
                                      // User Profile and Username
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 20.0,
                                            backgroundImage: (() {
                                              final modifiedPost =
                                                  HomeLayoutCubit.get(context)
                                                      .modifiedPost;
                                              if (modifiedPost != null) {
                                                final createdBy =
                                                    modifiedPost.createdBy;
                                                if (createdBy != null &&
                                                    createdBy.profilePic !=
                                                        null) {
                                                  return NetworkImage(createdBy
                                                          .profilePic!
                                                          .secure_url)
                                                      as ImageProvider;
                                                }
                                              }
                                              return const AssetImage(
                                                  "assets/images/nullProfile.png");
                                            })(),
                                          ),
                                          SizedBox(width: screenWidth / 30),
                                          Row(
                                            children: [
                                              Text(
                                                userLoginCubit
                                                    .loggedInUser!.firstName,
                                                style: const TextStyle(
                                                  fontFamily: "Roboto",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(
                                                  width: screenWidth / 150),
                                              Text(
                                                userLoginCubit
                                                    .loggedInUser!.lastName,
                                                style: const TextStyle(
                                                  fontFamily: "Roboto",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: screenHeight / 80),
                                      // Post Content
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: screenWidth / 18),
                                        child: TextFormField(
                                          controller: postContentController,
                                          decoration: const InputDecoration(
                                            hintText: "What's on your mind ?",
                                            hintStyle: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.grey,
                                            ),
                                            border: InputBorder
                                                .none, // Hide the border line
                                          ),
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins',
                                          ),
                                          maxLines:
                                              (postAttachment != null) ? 3 : 8,
                                        ),
                                      ),
                                      // Display the attachment if available
                                      if (postAttachment != null)
                                        Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                start: screenWidth / 30,
                                                end: screenWidth / 30,
                                              ),
                                              child:
                                                  Image.file(postAttachment!),
                                            ),
                                            Positioned(
                                              top: screenWidth / 40,
                                              right: screenHeight / 30,
                                              child: Container(
                                                color: Colors.grey.shade700,
                                                width: screenWidth / 13,
                                                height: screenHeight / 28,
                                                child: IconButton(
                                                  icon: const Icon(Icons.close,
                                                      size: 16.0),
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    setState(() {
                                                      postAttachment = null;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                                (postAttachment != null)
                                    ? SizedBox(
                                        height: (keyboardSize == 0.0)
                                            ? (screenHeight / 4.9)
                                            : (screenHeight -
                                                keyboardSize -
                                                60 -
                                                600))
                                    : SizedBox(
                                        height: (keyboardSize == 0.0)
                                            ? (screenHeight / 3.63)
                                            : (screenHeight -
                                                keyboardSize -
                                                60 -
                                                600)),
                                (keyboardSize == 0.0)
                                    ? Container(
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFD9D9D9),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(56.0),
                                            topRight: Radius.circular(56.0),
                                          ),
                                        ),
                                        height: screenHeight / 4,
                                        width: screenWidth,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                top: screenHeight / 100,
                                              ),
                                              child: Container(
                                                height: screenHeight / 250,
                                                width: screenWidth / 7,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(
                                                  screenWidth / 14),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                      height:
                                                          screenHeight / 60),
                                                  // Photo / Video
                                                  InkWell(
                                                    child: Row(
                                                      children: [
                                                        ImageIcon(
                                                          const AssetImage(
                                                            'assets/images/Img_box_duotone_line.png',
                                                          ),
                                                          size: 30,
                                                          color: HexColor(
                                                              "027E81"),
                                                        ),
                                                        const SizedBox(
                                                            width: 7),
                                                        const Text(
                                                          "Photo/video",
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                "Roboto",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    onTap: () {
                                                      _uploadPhoto();
                                                    },
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          screenHeight / 25),
                                                  // Emojis Keyboard
                                                  InkWell(
                                                    child: Row(
                                                      children: [
                                                        ImageIcon(
                                                          const AssetImage(
                                                            'assets/images/happy.png',
                                                          ),
                                                          size: 30,
                                                          color: HexColor(
                                                              "027E81"),
                                                        ),
                                                        const SizedBox(
                                                            width: 7),
                                                        const Text(
                                                          "Feeling/activity",
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                "Roboto",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    onTap: () {
                                                      // Open the keyboard with emoji support
                                                      SystemChannels.textInput
                                                          .invokeMethod(
                                                              'TextInput.show');
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  });
            });
      },
    );
  }

  void _uploadPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        postAttachment = File(pickedFile.path);
      });
    }
  }
}
