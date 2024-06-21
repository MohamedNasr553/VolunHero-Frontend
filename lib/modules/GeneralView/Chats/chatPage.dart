import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/layout/VolunHeroUserLayout/layout.dart';
import 'package:flutter_code/modules/GeneralView/DetailedChat/detailed_chat.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/ChatsModel.dart';
 
class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {

  bool _showWidget = false;

  List<Chat> chats=[];

  @override
  void initState() {
    super.initState();
    // After 3 seconds, set the _showWidget to true
    Future.delayed(const Duration(seconds: 2), () {

    });
  }
  String parseCreatedAt(String createdAt) {
    DateTime dateTime = DateTime.parse(createdAt);
    DateTime now = DateTime.now();

    if (dateTime.day == now.day && dateTime.month == now.month && dateTime.year == now.year) {
      // If the message was created today, return only the time
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      // Otherwise, return the date in the format like WhatsApp
      return '${dateTime.day.toString().padLeft(2, '0')} ${_getMonthName(dateTime.month)}';
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'JAN';
      case 2:
        return 'FEB';
      case 3:
        return 'MAR';
      case 4:
        return 'APR';
      case 5:
        return 'MAY';
      case 6:
        return 'JUN';
      case 7:
        return 'JUL';
      case 8:
        return 'AUG';
      case 9:
        return 'SEP';
      case 10:
        return 'OCT';
      case 11:
        return 'NOV';
      case 12:
        return 'DEC';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    chats = UserLoginCubit.get(context).chats;

    return BlocConsumer<UserLoginCubit,UserLoginStates>(
      listener: (BuildContext context,  state) { },
      builder: (BuildContext context,  state) {
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
                    child: (true)
                        ? Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: screenWidth / 35),
                      child: Column(
                        children: [
                          Expanded(
                            child: (chats.length>0)?ListView.separated(
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
                              itemCount:chats.length,
                            ):Center(child: Text(
                                "No Chats Yet",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey
                              ),
                            )
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
      },

    );

  }

  Widget buildChatItem(index, context) {
    var screenWidth = MediaQuery.of(context).size.width;

    Color hexColor = HexColor("0BA3A6");
    Color transparentColor = hexColor.withOpacity(0.5);

    return InkWell(
      onTap: (){
        UserLoginCubit.get(context).getLoggedInChats(token:UserLoginCubit.get(context).loginModel!.refresh_token).then((value) {
          UserLoginCubit.get(context).selectedChat = chats[index];
          print( UserLoginCubit.get(context).selectedChat);
          navigateAndFinish(context, DetailedChats());
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: (true) ? transparentColor : Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  child: Image.asset("${chats[index].members[1].userId.profilePic?? "assets/images/nullProfile.png"}"),
                ),
                SizedBox(
                  width: screenWidth / 50,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          (UserLoginCubit.get(context).loggedInUser!.id!=chats[index].members[1].userId.id)?
                          "${chats[index].members[1].userId.userName}":"${chats[index].members[0].userId.userName}",
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: screenWidth/4,height: 1,),
                        Text(
                         getFormatedTime( chats[index].messages[chats[index].messages.length-1].createdAt).toString(),
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: "Roboto",
                            color:(chats!.length==1)
                                ? HexColor("0BA3B9")
                                : HexColor("888383"),
                            fontWeight: (chats!.length==1)
                                ? FontWeight.bold
                                : FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    Row(
 //                     mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        Text(
                           ( chats[index].messages[chats[index].messages.length-1].text ),
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: (chats!.length==1)
                                ? FontWeight.bold
                                : FontWeight.w400,
                            fontFamily: "Roboto",
                            color: HexColor("888383"),
                          ),
                        ),
                        SizedBox(width: screenWidth/5,height: 1,),
                         const SizedBox()
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  String? getFormatedTime(DateTime? CreatedAt){
    DateTime? createdAt = CreatedAt;
    String? durationText;
    DateTime? createdTime = createdAt;
    DateTime timeNow = DateTime.now();
    Duration difference = timeNow.difference(createdTime!);

    if (difference.inMinutes > 59) {
      durationText = '${difference.inHours}h ';
    } else if (difference.inMinutes < 1) {
      durationText = '${difference.inSeconds}s ';
    } else {
      durationText = '${difference.inMinutes.remainder(60)}m ';
    }
    // In Days
    if (difference.inHours >= 24) {
      durationText = '${difference.inDays}d ';
    }
    return durationText;
  }
}


