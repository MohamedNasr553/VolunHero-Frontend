import 'package:flutter/material.dart';
import 'package:flutter_code/modules/GeneralView/Chats/chatPage.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class DetailedChat extends StatelessWidget {
  const DetailedChat({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var chatMessage = TextEditingController();
    final keyboardSize = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: screenWidth,
                  height: screenHeight,
                  child: SvgPicture.asset(
                    "assets/images/Rectangle 4190.svg",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: screenHeight / 2),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight / 15.84,
                        left: screenWidth / 30,
                        right: screenWidth / 20,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              navigateAndFinish(context, const ChatsPage());
                            },
                            icon: const Icon(
                              Icons.arrow_back_outlined,
                              size: 25,
                            ),
                            color: Colors.white,
                          ),
                          SizedBox(width: screenWidth / 30),
                          // User Profile
                          IconButton(
                            onPressed: () {},
                            icon: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                  child: Image.asset(
                                      "assets/images/logo.png")),
                            ),
                          ),
                          SizedBox(width: screenWidth / 30),
                          // Chat name
                          Container(
                            width: screenWidth / 2,
                            child: const Text(
                              'Nasr',
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 25.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight / 40),
                    Container(
                      width: screenWidth,
                      height: screenHeight -
                          ((screenHeight / 35) + 36 + screenHeight / 13.5),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                        ),
                        color: HexColor("F3F3F3"),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: screenHeight / 1.1,
                    start: screenWidth / 50,
                  ),
                  // Chats Items
                  child: Row(
                    children: [
                      IconButton(
                        visualDensity: VisualDensity.compact, // Reduce padding
                        // Upload photo from device Gallery
                        onPressed: _uploadPhoto,
                        icon: Image.asset(
                          'assets/images/Img_box_duotone_line.png',
                          width: 25.0,
                          height: 25.0,
                        ),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact, // Reduce padding
                        // Open device camera to capture a photo
                        onPressed: (){},
                        icon: SvgPicture.asset(
                          'assets/images/Camera.svg',
                        ),
                      ),
                      Container(
                        width: screenWidth / 1.57,
                        height: screenHeight / 25,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 15.0,
                              spreadRadius: -5.0,
                              offset: const Offset(2.0, 2.0), // Right and bottom shadow
                            ),
                          ],
                        ),
                        child: defaultTextFormField(
                          validate: (value){
                            return null;
                          },
                          controller: chatMessage,
                          type: TextInputType.text,
                          hintText: '',
                          outlineBorderWidth: 0,
                          radius: 40.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: screenWidth / 500,
                        ),
                        child: IconButton(
                          visualDensity: VisualDensity.compact, // Reduce padding
                          onPressed: (){},
                          icon: SvgPicture.asset(
                            'assets/images/Send_Icon.svg',
                            width: 30.0,
                            height: 30.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
