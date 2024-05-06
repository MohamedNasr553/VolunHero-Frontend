import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/CreatePost_bloc/cubit.dart';
import 'package:flutter_code/bloc/CreatePost_bloc/states.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/layout/VolunHeroUserLayout/layout.dart';
import 'package:flutter_code/models/CreatePostModel.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/components/constants.dart';
import 'package:flutter_code/shared/styles/colors.dart';
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
      listener: (context, state){},
      builder: (context, state){
        var screenHeight = MediaQuery.of(context).size.height;
        var screenWidth = MediaQuery.of(context).size.width;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor("027E81"),
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
                    if (state is! CreatePostLoadingState){
                      List<Attachments>? attachments = [];
                      if (postAttachment != null) {
                        attachments.add(Attachments(
                          secure_url: postAttachment!.path,
                          public_id: 'unique_id',
                        ));
                      }
                      CreatePostCubit.get(context).createPost(
                        content: postContentController.text,
                        attachments: attachments,
                        token: userToken!,
                      );
                      // Change Bottom Nav Bar to Home Screen
                      HomeLayoutCubit.get(context).changeBottomNavBar(0);
                      navigateAndFinish(context, const VolunHeroUserLayout());
                    }
                    else if (state is! CreatePostErrorState) {
                      showToast(
                        text: "Something went wrong",
                        state: ToastStates.ERROR,
                      );
                    }
                    else{
                      const Center(
                        child: LinearProgressIndicator(
                          color: defaultColor,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fixedSize: Size(screenWidth / 5, screenHeight / 70),
                  ),
                  child: Text(
                    'Post',
                    style: TextStyle(
                        fontSize: 16.0,
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
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        children: [
                          SizedBox(height: screenHeight / 40),
                          // User Profile and Username
                          const Row(
                            children: [
                              CircleAvatar(
                                radius: 17.0,
                                backgroundImage:
                                AssetImage("assets/images/logo.png"),
                              ),
                              SizedBox(width: 5),
                              Text("Mohamed Nasr")
                            ],
                          ),
                          SizedBox(height: screenHeight / 80),
                          // Post Content
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth / 18),
                            child: TextFormField(
                              controller: postContentController,
                              decoration: const InputDecoration(
                                hintText: "What's on your mind ?",
                                hintStyle: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none, // Hide the border line
                              ),
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                              maxLines: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: (keyboardSize == 0.0)
                            ? (screenHeight / 3.63)
                            : (screenHeight - keyboardSize - 60 - 600)),
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
                            padding: EdgeInsetsDirectional.only(
                              top: screenHeight / 100,
                            ),
                            child: Container(
                              height: screenHeight / 250,
                              width: screenWidth / 7,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(screenWidth / 14),
                            child: Column(
                              children: [
                                // Photo / Video
                                InkWell(
                                  child: Row(
                                    children: [
                                      ImageIcon(
                                        const AssetImage(
                                          'assets/images/Img_box_duotone_line.png',
                                        ),
                                        size: 30,
                                        color: HexColor("027E81"),
                                      ),
                                      const SizedBox(width: 7),
                                      const Text(
                                        "Photo/video",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    _uploadPhoto();
                                  },
                                ),
                                SizedBox(height: screenHeight / 35),
                                // Emojis Keyboard
                                InkWell(
                                  child: Row(
                                    children: [
                                      ImageIcon(
                                        const AssetImage(
                                          'assets/images/happy.png',
                                        ),
                                        size: 30,
                                        color: HexColor("027E81"),
                                      ),
                                      const SizedBox(width: 7),
                                      const Text(
                                        "Feeling/activity",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    // Open the keyboard with emoji support
                                    SystemChannels.textInput.invokeMethod('TextInput.show');
                                  },
                                ),
                                SizedBox(height: screenHeight / 35),
                                // Drop Location
                                InkWell(
                                  child: Row(
                                    children: [
                                      ImageIcon(
                                        const AssetImage(
                                          'assets/images/Favorites_fill.png',
                                        ),
                                        size: 30,
                                        color: HexColor("027E81"),
                                      ),
                                      const SizedBox(width: 7),
                                      const Text(
                                        "Drop Location",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
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
      },
    );
  }

  Future<void> _uploadPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      // For example:
      // _handleImage(pickedFile);
    }
  }
}
