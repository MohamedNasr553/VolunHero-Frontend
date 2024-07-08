import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_code/models/CreatePostModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/CreatePost_bloc/cubit.dart';
import 'package:flutter_code/bloc/CreatePost_bloc/states.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/bloc/Layout_bloc/cubit.dart';
import 'package:flutter_code/layout/VolunHeroLayout/layout.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  var postContentController = TextEditingController();
  File? postAttachment;
  final _picker = ImagePicker();
  List<File>? _attachments = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> createPost() async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://volunhero.onrender.com/api/post'),
    );

    final token = UserLoginCubit.get(context).loginModel!.refresh_token ?? "";
    request.headers['Authorization'] = 'Volunhero__$token';

    request.fields['content'] = postContentController.text;

    if (_attachments != null && _attachments!.isNotEmpty) {
      for (var attachment in _attachments!) {
        print('Attachment: ${attachment.path}');
        String fileName = attachment.path.split('/').last;
        String contentType = attachment.path.toLowerCase().endsWith('.jpg')
            ? 'image/jpeg'
            : 'image/jpeg';
        request.files.add(
          await http.MultipartFile.fromPath(
            'attachments',
            attachment.path,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }
    } else {
      print('No attachments to upload.');
    }

    try {
      final response = await request.send();

      final responseString = await response.stream.bytesToString();
      print('Response status: ${response.statusCode}');
      print('Response body: $responseString');

      if (response.statusCode == 201) {
        print('Post Created Successfully');
        navigateToPage(context, const VolunHeroLayout());
        (UserLoginCubit.get(context).loggedInUser!.role == "Organization")
            ? HomeLayoutCubit.get(context)
                .changeOrganizationBottomNavBar(context, 0)
            : HomeLayoutCubit.get(context).changeUserBottomNavBar(context, 0);
      } else {
        final responseData = jsonDecode(responseString);
        final createPostModel = CreatePostsResponse.fromJson(responseData);
        print('Failed to create post');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            createPostModel.message ?? 'Unexpected error',
            style: const TextStyle(
              fontSize: 12.0,
            ),
          ),
        ));
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _uploadPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _attachments ??= [];
        _attachments!.add(File(pickedFile.path));
        postAttachment = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickAttachments() async {
    final pickedFiles = await _picker.pickMultiImage();
    setState(() {
      _attachments = pickedFiles.map((file) => File(file.path)).toList();
    });
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
                            UserLoginCubit.get(context).loggedInUser?.role ==
                                    "Organization"
                                ? HomeLayoutCubit.get(context)
                                    .changeOrganizationBottomNavBar(context, 0)
                                : HomeLayoutCubit.get(context)
                                    .changeUserBottomNavBar(context, 0);
                            navigateAndFinish(context, const VolunHeroLayout());
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
                                // if (state is! CreatePostLoadingState) {
                                List<Map<String, dynamic>> attachmentsMapList =
                                    [];
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
                                // CreatePostCubit.get(context).createPost(
                                //   content: postContentController.text,
                                //   attachments: attachmentsMapList,
                                //   token: UserLoginCubit.get(context)
                                //           .loginModel!
                                //           .refresh_token ??
                                //       "",
                                // );
                                createPost();
                                HomeLayoutCubit.get(context).getAllPosts(
                                    token: UserLoginCubit.get(context)
                                            .loginModel!
                                            .refresh_token ??
                                        "");

                                // Change Bottom Nav Bar to Home Screen
                                UserLoginCubit.get(context)
                                            .loggedInUser
                                            ?.role ==
                                        "Organization"
                                    ? HomeLayoutCubit.get(context)
                                        .changeOrganizationBottomNavBar(
                                            context, 0)
                                    : HomeLayoutCubit.get(context)
                                        .changeUserBottomNavBar(context, 0);
                                navigateAndFinish(
                                    context, const VolunHeroLayout());
                                // } else if (state is! CreatePostErrorState) {
                                //   showToast(
                                //     text: "Something went wrong",
                                //     state: ToastStates.ERROR,
                                //   );
                                // } else {
                                //   const Center(
                                //     child: LinearProgressIndicator(
                                //       color: defaultColor,
                                //     ),
                                //   );
                                // }
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
                                      EdgeInsets.only(left: screenWidth / 40),
                                  child: Column(
                                    children: [
                                      SizedBox(height: screenHeight / 25),
                                      // User Profile and Username
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 20.0,
                                            backgroundImage: (UserLoginCubit
                                                            .get(context)
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
                                          SizedBox(width: screenWidth / 60),
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
                                          left: screenWidth / 18,
                                          right: screenWidth / 18,
                                        ),
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
                                                      for (int i = 0;
                                                          i <
                                                              _attachments!
                                                                  .length;
                                                          i++) {
                                                        if (_attachments![i]
                                                                .path ==
                                                            postAttachment!
                                                                .path) {
                                                          _attachments!.remove(
                                                              _attachments![i]);
                                                          break;
                                                        }
                                                      }
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
                                                        SizedBox(
                                                            width: screenWidth /
                                                                60),
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
                                                      _pickAttachments();
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
                                                        SizedBox(
                                                            width: screenWidth /
                                                                60),
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
}
