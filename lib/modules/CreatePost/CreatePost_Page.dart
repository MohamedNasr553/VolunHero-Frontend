import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class CreatePost extends StatefulWidget {
  CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  var _textEditingController = TextEditingController();
   

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final keyboardSize = MediaQuery.of(context).viewInsets.bottom;
    // If the bottom view inset is greater than 0, it means the keyboard is visible

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("027E81"),
        leading: IconButton(
          icon: Icon(Icons.close_rounded),
          onPressed: () {},
          color: Colors.white,
        ),
        title: Text(
          'Create Post',
          style: TextStyle(
              color: Colors.white, fontFamily: "Poppins", fontSize: 18.0),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                fixedSize: Size(86.0, 31.0),
              ),
              child: Text(
                'Post',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: HexColor("027E81"),
                    fontFamily: "Poppins"),
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
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight / 35,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 17.0,
                            backgroundImage:
                            AssetImage("assets/images/logo.png"),
                          ),
                          SizedBox(width: 5),
                          Text("Mohamed Nasr ")
                        ],
                      ),
                      SizedBox(height: screenHeight / 70),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: TextFormField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "What's on your mind ?",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: InputBorder.none, // Hide the border line
                          ),
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: (keyboardSize==0.0)?(screenHeight / 2.286):(screenHeight-keyboardSize-60-215)),
                (keyboardSize==0.0)?
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(56.0),
                      topRight: Radius.circular(56.0),
                    ),
                  ),
                  height: screenHeight / 3.2,
                  width: screenWidth,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 3,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            InkWell(
                              child: Row(
                                children: [
                                  ImageIcon(
                                    AssetImage(
                                        'assets/images/Img_box_duotone_line.png'),
                                    size: 30,
                                    color: HexColor("027E81"),
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    "Photo/video",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Roboto"),
                                  )
                                ],
                              ),
                              onTap: () {
                                showToast(
                                    text: "text",
                                    state: ToastStates.ERROR);
                              },
                            ),
                            SizedBox(
                                height: screenHeight / 35),
                            InkWell(
                              child: Row(
                                children: [
                                  ImageIcon(
                                    AssetImage(
                                        'assets/images/happy.png'),
                                    size: 30,
                                    color: HexColor("027E81"),
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    "Feeling/activity",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Roboto"),
                                  )
                                ],
                              ),
                              onTap: () {},
                            ),
                            SizedBox(
                                height: screenHeight / 35),
                            InkWell(
                              child: Row(
                                children: [
                                  ImageIcon(
                                    AssetImage(
                                        'assets/images/Favorites_fill.png'),
                                    size: 30,
                                    color: HexColor("027E81"),
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    "Drop Location",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Roboto"),
                                  )
                                ],
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:screenHeight/26.5 ,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 3,
                          width: 135,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                    ],
                  ),
                ):
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(56.0),
                      topRight: Radius.circular(56.0),
                    ),
                  ),
                  width: screenWidth,
                  height: 60,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 3,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                            AssetImage(
                                'assets/images/Img_box_duotone_line.png'),
                            size: 30,
                            color: HexColor("027E81"),
                          ),
                          SizedBox(width: screenWidth/6,),
                          ImageIcon(
                            AssetImage(
                                'assets/images/happy.png'),
                            size: 30,
                            color: HexColor("027E81"),
                          ),
                          SizedBox(width: screenWidth/6,),
                          ImageIcon(
                            AssetImage(
                                'assets/images/Favorites_fill.png'),
                            size: 30,
                            color: HexColor("027E81"),
                          ),

                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
