import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/states.dart';
import 'package:flutter_code/layout/VolunHeroUserLayout/layout.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../models/ChatsModel.dart';
import '../DetailedChat/detailed_chat.dart';

class SearchChatPage extends StatefulWidget {
  const SearchChatPage({super.key});

  @override
  State<SearchChatPage> createState() => _SearchChatPageState();
}

class _SearchChatPageState extends State<SearchChatPage> {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // get all chats first
    UserLoginCubit.get(context)
        .getLoggedInChats(
        token: UserLoginCubit
            .get(context)
            .loginModel!
            .refresh_token).then((onValue) {
      // chats = UserLoginCubit.get(context).chats;
    });
  }


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<UserLoginCubit, UserLoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<HomeLayoutCubit, LayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: screenHeight / 70,
                        end: screenWidth / 25,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: screenWidth / 1.33,
                            height: screenHeight / 23,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: searchController,
                              validator: (value) {
                                return null;
                              },
                              onChanged: (value) {
                                UserLoginCubit.get(context).getChatsBySearch(value);
                              },
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                  size: 23,
                                ),
                                hintText: 'Search',
                                hintStyle: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: screenHeight / 90,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: screenHeight / 70,
                      end: screenWidth / 20,
                    ),
                    child: InkWell(
                      onTap: () => navigateAndFinish(context, const VolunHeroUserLayout()),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  SizedBox(height: screenHeight / 80),
                  (searchController.text.isEmpty && state is! GetSearchChatLoadingState)
                      ? Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: screenHeight / 130,
                      start: screenWidth / 22,
                    ),
                    child: const Center(
                      child: Text(
                        'Try searching for people, volunteers and organizations',
                        style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: Colors.grey),
                      ),
                    ),
                  )
                      : const SizedBox(),

                  SizedBox(height: screenHeight / 30),
                  Expanded(
                    child: StreamBuilder<List<Chat>>(
                      stream: UserLoginCubit.get(context).filteredChatsStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: defaultColor,));
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Padding(
                            padding: EdgeInsetsDirectional.only(
                              top: screenHeight / 30,
                              start: screenWidth / 20,
                              end: screenWidth / 15,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "No Results for ${searchController.text}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24.0,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: screenHeight / 150),
                                const Text(
                                  "Communicate with People and Volunteer",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10.0,
                                    color: Colors.black38,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.separated(
                          physics:
                          const BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>
                              buildChatItem(index, context) ,
                          separatorBuilder: (context, index) =>
                              Padding(
                                padding:
                                EdgeInsetsDirectional.symmetric(
                                    horizontal:
                                    screenWidth / 35),
                                child: Container(
                                  width: double.infinity,
                                  color: Colors.white,
                                ),
                              ),
                          itemCount: snapshot.data!.length,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildChatItem(index, context) {
    Color hexColor = HexColor("0BA3A6");
    Color transparentColor = hexColor.withOpacity(0.5);

    return InkWell(
      onTap: () {
        UserLoginCubit.get(context)
            .getLoggedInChats(
            token: UserLoginCubit.get(context).loginModel!.refresh_token)
            .then((value) {
          UserLoginCubit.get(context).selectedChat = UserLoginCubit.get(context).filteredChats[index];
          print(UserLoginCubit.get(context).selectedChat);
          navigateAndFinish(context, DetailedChats());
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
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
                  backgroundImage: AssetImage(
                      "${UserLoginCubit.get(context).filteredChats[index].members[1].userId.profilePic ?? "assets/images/nullProfile.png"}"),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              (UserLoginCubit.get(context).loggedInUser!.id !=
                                  UserLoginCubit.get(context).filteredChats[index].members[1].userId.id)
                                  ? "${UserLoginCubit.get(context).filteredChats[index].members[1].userId.userName}"
                                  : "${UserLoginCubit.get(context).filteredChats[index].members[0].userId.userName}",
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
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            (UserLoginCubit.get(context).filteredChats[index].messages.isNotEmpty)
                                ? getFormatedTime(UserLoginCubit.get(context).filteredChats[index]
                                .messages[UserLoginCubit.get(context).filteredChats[index].messages.length - 1]
                                .createdAt)
                                .toString()
                                : "",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: "Roboto",
                              color: (UserLoginCubit.get(context).filteredChats.length == 1)
                                  ? HexColor("0BA3B9")
                                  : HexColor("888383"),
                              fontWeight: (UserLoginCubit.get(context).filteredChats.length == 1)
                                  ? FontWeight.bold
                                  : FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        (UserLoginCubit.get(context).filteredChats[index].messages.isEmpty)
                            ? "Tap to message"
                            : UserLoginCubit.get(context).filteredChats[index]
                            .messages[UserLoginCubit.get(context).filteredChats[index].messages.length - 1]
                            .text,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: (UserLoginCubit.get(context).filteredChats.length == 1)
                              ? FontWeight.bold
                              : FontWeight.w400,
                          fontFamily: "Roboto",
                          color: HexColor("888383"),
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