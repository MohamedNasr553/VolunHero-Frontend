import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/layout/VolunHeroLayout/layout.dart';
import 'package:flutter_code/modules/GeneralView/DetailedChat/detailed_chat.dart';
import 'package:flutter_code/modules/GeneralView/SearchChat/search_chat.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../models/ChatsModel.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  List<Chat> chats = [];

  @override
  void initState() {
    super.initState();

    /// Logged in user chats
    UserLoginCubit.get(context)
        .getLoggedInChats(
            token: UserLoginCubit.get(context).loginModel!.refresh_token)
        .then((onValue) {
      chats = UserLoginCubit.get(context).chats;
    });
  }

  String parseCreatedAt(String createdAt) {
    DateTime dateTime = DateTime.parse(createdAt);
    DateTime now = DateTime.now();

    if (dateTime.day == now.day &&
        dateTime.month == now.month &&
        dateTime.year == now.year) {
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

    return BlocConsumer<UserLoginCubit, UserLoginStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
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
              SizedBox(height: screenHeight / 2),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight / 11.64,
                      left: screenWidth / 30,
                      right: screenWidth / 20,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            navigateAndFinish(
                                context, const VolunHeroLayout());
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 28,
                          ),
                          color: Colors.white,
                        ),
                        SizedBox(width: screenWidth / 18),
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
                          onPressed: () {
                            navigateToPage(context, const SearchChatPage());
                          },
                          icon: const Icon(
                            Icons.search,
                            size: 28,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight / 40),
                  Container(
                    width: screenWidth,
                    height: screenHeight -
                        ((screenHeight / 30) + 36 + screenHeight / 10.85),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40.0)),
                        color: HexColor("F3F3F3")),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth / 35),
                      child: Column(
                        children: [
                          Expanded(
                            child: (state is! GetLoggedInUserChatsLoadingState)
                                ? (chats.isNotEmpty)
                                    ? ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            buildChatItem(index, context),
                                        separatorBuilder: (context, index) =>
                                            Padding(
                                          padding:
                                              EdgeInsetsDirectional.symmetric(
                                            horizontal: screenWidth / 35,
                                            vertical: screenHeight / 80,
                                          ),
                                          child: Container(
                                            width: double.infinity,
                                            color: Colors.white,
                                          ),
                                        ),
                                        itemCount: chats.length,
                                      )
                                    : (Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.chat_outlined,
                                    size: 50,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(height: screenHeight / 100),
                                  const Text(
                                    "No chats yet",
                                    style: TextStyle(
                                      fontSize: 23.0,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Roboto",
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight / 200),
                                  const Text(
                                    "Connect "
                                        "with people to "
                                        "volunteer.",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Roboto",
                                      color: Colors.black38,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                                : const Center(
                                    child: CircularProgressIndicator(
                                    color: defaultColor,
                                  )),
                          ),
                        ],
                      ),
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
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    Color hexColor = HexColor("0BA3A6");
    Color transparentColor = hexColor.withOpacity(0.5);

    return InkWell(
      onLongPress: () {
        _showChatBottomSheet(chats[index].id, context);
      },
      onTap: () {
        UserLoginCubit.get(context)
            .getLoggedInChats(
                token: UserLoginCubit.get(context).loginModel!.refresh_token)
            .then((value) {
          UserLoginCubit.get(context).selectedChat = chats[index];
          navigateAndFinish(context, DetailedChats());
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: (true) ? transparentColor : Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth / 30),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.white,
                backgroundImage: chats[index].members[1].userId.profilePic?.secureUrl !=
                    null
                    ? NetworkImage(chats[index].members[1].userId.profilePic!.secureUrl) as ImageProvider
                    : const AssetImage("assets/images/nullProfile.png"),
              ),
              SizedBox(width: screenWidth / 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            (UserLoginCubit.get(context).loggedInUser!.id !=
                                    chats[index].members[1].userId.id)
                                ? chats[index].members[1].userId.userName
                                : chats[index].members[0].userId.userName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Roboto",
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            end: screenWidth / 35,
                          ),
                          child: Text(
                            (chats[index].messages.isNotEmpty)
                                ? getFormatedTime(chats[index]
                                        .messages[
                                            chats[index].messages.length - 1]
                                        .createdAt)
                                    .toString()
                                : "",
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: "Roboto",
                              color: (chats.length == 1)
                                  ? HexColor("0BA3B9")
                                  : HexColor("888383"),
                              fontWeight: (chats.length == 1)
                                  ? FontWeight.bold
                                  : FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: screenHeight / 300),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        end: screenWidth / 12,
                      ),
                      child: Text(
                        (chats[index].messages.isEmpty)
                            ? "Tap to message"
                            : chats[index]
                                .messages[chats[index].messages.length - 1]
                                .text,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: (chats.length == 1)
                              ? FontWeight.bold
                              : FontWeight.w400,
                          fontFamily: "Roboto",
                          color: HexColor("888383"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showChatBottomSheet(chatID, context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        var screenWidth = MediaQuery.of(context).size.width;
        var screenHeight = MediaQuery.of(context).size.height;

        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: screenHeight / 8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.delete_rounded,
                      size: 25,
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Delete Selected Chat',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: screenHeight / 130),
                        const Text(
                          'Once you delete this chat all messages will be deleted',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      UserLoginCubit.get(context)
                          .deleteChat(
                              token: UserLoginCubit.get(context)
                                  .loginModel!
                                  .refresh_token,
                              chatID: chatID)
                          .then((_) {
                        UserLoginCubit.get(context)
                            .getLoggedInChats(
                                token: UserLoginCubit.get(context)
                                    .loginModel!
                                    .refresh_token)
                            .then((onValue) {
                          chats = UserLoginCubit.get(context).chats;
                        });
                      });
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

  String? getFormatedTime(DateTime? CreatedAt) {
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
