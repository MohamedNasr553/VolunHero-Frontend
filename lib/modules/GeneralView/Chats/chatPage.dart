import 'package:flutter/material.dart';
import 'package:flutter_code/layout/VolunHeroUserLayout/layout.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  List<Map<String, dynamic>> chats = [];
  bool _showWidget = false;

  @override
  void initState() {
    super.initState();
    // After 3 seconds, set the _showWidget to true
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showWidget = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    for (int i = 1; i <= 10; i++) {
      if (i % 2 == 0) {
        chats.add({
          'image': 'assets/images/logo.png',
          'name': "User $i",
          'newMessage': false,
          'lastMessage': "In this example, the top-left .",
          'time': "9:05 PM",
        });
      } else {
        chats.add({
          'image': 'assets/images/logo.png',
          'name': "User $i",
          'newMessage': true,
          'lastMessage': "In this example, the top-left .",
          'time': "9:05 PM",
          "newMessages": 3
        });
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: SvgPicture.asset(
              "assets/images/Rectangle 4190.svg",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: screenHeight / 2,
          ),
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
                        navigateAndFinish(context, const VolunHeroUserLayout());
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 28,
                      ),
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: screenWidth / 18,
                    ),
                    const Text(
                      "Chats",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        size: 28,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight / 40,
              ),
              Container(
                width: screenWidth,
                height: screenHeight -
                    ((screenHeight / 35) + 36 + screenHeight / 13.5),
                decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(40.0)),
                    color: HexColor("F3F3F3")),
                child: _showWidget
                    ? Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenWidth / 35),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    buildChatItem(index, context),
                                separatorBuilder: (context, index) => Padding(
                                  padding: EdgeInsetsDirectional.symmetric(
                                      horizontal: screenWidth / 35),
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.white,
                                  ),
                                ),
                                itemCount: chats.length,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: 10, // Number of posts
                        itemBuilder: (BuildContext context, int index) {
                          return Shimmer.fromColors(
                            period: const Duration(milliseconds: 1500),
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
                                        radius: 30,
                                      ),
                                      SizedBox(
                                        width: screenWidth / 40,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: screenHeight / 60,
                                            width: screenWidth / 4,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight / 50,
                                          ),
                                          SizedBox(
                                            height: screenHeight / 45,
                                            width: screenWidth / 2,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildChatItem(index, context) {
    var screenWidth = MediaQuery.of(context).size.width;

    Color hexColor = HexColor("0BA3A6");
    Color transparentColor = hexColor.withOpacity(0.5);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: chats[index]['newMessage'] ? transparentColor : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                child: Image.asset(chats[index]['image']),
              ),
              SizedBox(
                width: screenWidth / 50,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        chats[index]['name'],
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto",
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth / 2.2,
                      ),
                      Text(
                        chats[index]['time'],
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: "Roboto",
                          color: chats[index]['newMessage']
                              ? HexColor("0BA3B9")
                              : HexColor("888383"),
                          fontWeight: chats[index]['newMessage']
                              ? FontWeight.bold
                              : FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chats[index]['lastMessage'],
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: chats[index]['newMessage']
                              ? FontWeight.bold
                              : FontWeight.w400,
                          fontFamily: "Roboto",
                          color: HexColor("888383"),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth / 3.2,
                      ),
                      chats[index]['newMessage']
                          ? CircleAvatar(
                              radius: 10,
                              backgroundColor: HexColor("0BA3A6"),
                              child: const Center(
                                child: Text(
                                  "2",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox()
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
