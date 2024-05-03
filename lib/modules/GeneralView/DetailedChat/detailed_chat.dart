import 'package:flutter/material.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_list_view/smooth_list_view.dart';

import '../Chats/chatPage.dart';

class DetailedChats extends StatefulWidget {
  const DetailedChats({super.key});

  @override
  _DetailedChatsState createState() => _DetailedChatsState();
}

class _DetailedChatsState extends State<DetailedChats> {
  final List<String> _messages = [];

  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 10; i++) {
      _messages.add("This is a message");
    }
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: HexColor("027E81"),
      body: Column(
        children: [
          Container(
            height: screenHeight / 6,
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight / 15,
                ),
                Row(
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
                            child: Image.asset("assets/images/logo.png")),
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
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: HexColor("F3F3F3"),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45.0),
                  // Larger radius for top left corner
                  topRight: Radius.zero,
                  // No radius for top right corner
                  bottomLeft: Radius.zero,
                  // No radius for bottom left corner
                  bottomRight: Radius.zero, // No radius for bottom right corner
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SmoothListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildMessageItem(index, context),
                  separatorBuilder: (context, index) => Padding(
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 16),
                    child: Container(
                      height: screenHeight / 50,
                      width: double.infinity,
                      color: HexColor("F3F3F3"),
                    ),
                  ),
                  itemCount: _messages.length,
                  duration: const Duration(milliseconds: 50),
                ),
              ),
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget buildMessageItem(index, context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return (index % 2 == 0)
        ? Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                child: ClipOval(child: Image.asset("assets/images/logo.png")),
              ),
              SizedBox(
                width: screenWidth / 35,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_messages[index]),
                ),
                decoration: BoxDecoration(
                    color: HexColor("c0e1e2"),
                    borderRadius: BorderRadius.circular(20)),
              )
            ],
          )
        : Row(
            children: [
              const Spacer(),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_messages[index]),
                ),
                decoration: BoxDecoration(
                    color: HexColor("51bbbd"),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ],
          );
  }

  Widget _buildInputField() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    var chatMessage = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Container(
        color: HexColor("F3F3F3"),
        height: screenHeight / 18,
        child: Row(
          children: [
            IconButton(
              visualDensity: VisualDensity.compact, // Reduce padding
              onPressed: _uploadPhoto,
              icon: Image.asset(
                'assets/images/Img_box_duotone_line.png',
                width: 25.0,
                height: 25.0,
              ),
            ),
            IconButton(
              visualDensity: VisualDensity.compact, // Reduce padding
              onPressed: () {},
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: defaultTextFormField(
                  validate: (value) {
                    return null;
                  },
                  controller: chatMessage,
                  type: TextInputType.text,
                  hintText: '',
                  outlineBorderWidth: 0,
                  radius: 40.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: screenWidth / 500,
              ),
              child: IconButton(
                visualDensity: VisualDensity.compact, // Reduce padding
                onPressed: () {},
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

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(text);
        _textController.clear();
      });
    }
  }
}
