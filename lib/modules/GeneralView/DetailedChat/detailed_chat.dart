import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/modules/GeneralView/HomePage/Home_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_list_view/smooth_list_view.dart';

import '../../../bloc/Login_bloc/cubit.dart';
import '../../../bloc/Login_bloc/states.dart';
import '../../../models/ChatsModel.dart';
import '../Chats/chatPage.dart';

class DetailedChats extends StatefulWidget {
  DetailedChats({super.key});

  @override
  _DetailedChatsState createState() => _DetailedChatsState();
}

class _DetailedChatsState extends State<DetailedChats> {
  Chat? chat;

  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /// Logged in user chats
    UserLoginCubit.get(context)
        .getLoggedInChats(
        token: UserLoginCubit.get(context)
            .loginModel!
            .refresh_token);
  }
  @override
  Widget build(BuildContext context) {
    chat = UserLoginCubit.get(context).selectedChat;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<UserLoginCubit, UserLoginStates>(
        listener: (context, state) {
          if(state is CreateMessageSuccessState){
            UserLoginCubit.get(context).refreshChatPage(UserLoginCubit.get(context).selectedChat!.id);
          }
        },
        builder: (context, state) {
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
                            //  navigateToPage(context, ChatsPage());
                            UserLoginCubit.get(context)
                                .getLoggedInChats(
                                token: UserLoginCubit.get(context)
                                    .loginModel!
                                    .refresh_token)
                                .then((value) {
                              navigateToPage(context, const ChatsPage());
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_back_outlined,
                            size: 25,
                          ),
                          color: Colors.white,
                        ),
                        SizedBox(width: screenWidth / 30),
                        // User Profile
                        // IconButton(
                        //   onPressed: () {},
                        //   icon: CircleAvatar(
                        //     radius: 25,
                        //     backgroundColor: Colors.transparent,
                        //     child: ClipOval(
                        //         child: Image.asset("${UserLoginCubit.get(context).selectedChat!.members[1].userId.profilePic}" ?? "assets/images/nullProfile.png")),
                        //   ),
                        // ),
                        // Chat name
                        Container(
                          width: screenWidth / 2,
                          child:  Text(
                            (UserLoginCubit.get(context).selectedChat!.members[1].userId.id !=
                                UserLoginCubit.get(context).loggedInUser!.id)?UserLoginCubit.get(context).selectedChat!.members[1].userId.userName:
                            UserLoginCubit.get(context).selectedChat!.members[0].userId.userName,
                            style: const TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 25.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          visualDensity: VisualDensity.compact, // Reduce padding
                          onPressed: () {
                            UserLoginCubit.get(context).refreshChatPage(UserLoginCubit.get(context).selectedChat!.id);
                          },
                          icon:Icon(Icons.refresh),
                          iconSize: 35,
                          color: Colors.white,
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
                    child:( state is! GetLoggedInUserChatsLoadingState)?
                        SmoothListView.separated(
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
                      itemCount:  UserLoginCubit.get(context).selectedChat!.messages.length,
                      duration: const Duration(milliseconds: 1),
                    ):
                      Center(
                        child:  CircularProgressIndicator(color: defaultColor,),
                      )
                  )
                ),
              ),
              _buildInputField(),
            ],
          ),
        );});

  }

  Widget buildMessageItem(index, context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    DateTime? createdAt = UserLoginCubit.get(context).selectedChat!.messages[index].createdAt;
    String? durationText;
    DateTime createdTime = createdAt;
    DateTime timeNow = DateTime.now();
    Duration difference = timeNow.difference(createdTime);

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
    return ( UserLoginCubit.get(context).selectedChat!.messages[index].senderId != UserLoginCubit.get(context).loggedInUser!.id)
        ? Row(
            children: [

              SizedBox(
                width: screenWidth / 35,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("${durationText}",style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[700]
                      ),),
                      SizedBox(width: screenWidth/100,),
                      Text("${ UserLoginCubit.get(context).selectedChat!.messages[index].text}"),

                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    color: HexColor("c0e1e2"),
                    borderRadius: BorderRadius.circular(20)),
              ),

            ],
          )
        : Row(
            children: [
              const Spacer(),
              Container(
                width: screenWidth/2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("${ UserLoginCubit.get(context).selectedChat!.messages[index].text}",
                       maxLines: null,
                       style: TextStyle(
                         fontSize: 16,
                       ),
                      ),
                      SizedBox(width: screenWidth/100,),
                      Text("${durationText}",style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[700]
                      ),)
                    ],
                  ),
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
                onPressed: ()async {
             //     _handleSubmitted(_textController.text,UserLoginCubit.get(context).selectedChat!.id,UserLoginCubit.get(context).loggedInUser!.id,context);
                  print("ddddd\n");
                  print(chatMessage.text);
                  String text = chatMessage.text.toString();
                  String chatId = UserLoginCubit.get(context).selectedChat!.id;
                  String senderId = UserLoginCubit.get(context).loggedInUser!.id;
                  print(text);
                  print('\n');
                  print(chatId);
                  print('\n');
                  print(senderId);

                  if (text.trimLeft().trimRight().isNotEmpty) {

                    var x = await UserLoginCubit.get(context).sendMessage(
                        chatId: chatId,
                        senderId: senderId,
                        text: text,
                        token: UserLoginCubit.get(context).loginModel!.refresh_token.toString(),
                        chat: UserLoginCubit.get(context).selectedChat
                    ).then((value) {
                    UserLoginCubit.get(context).refreshChatPage(chatId);

                    });


                  }

                },
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

  void _handleSubmitted(String text,String chatId,String senderId,context) {
    // if (text.trimLeft().trimRight().isNotEmpty) {
    //   UserLoginCubit.get(context).sendMessage(
    //       chatId: chatId,
    //       senderId: senderId,
    //       text: text,
    //     token: UserLoginCubit.get(context).loginModel!.refresh_token.toString()
    //   ).then((value){
    //     UserLoginCubit.get(context).getLoggedInChats(token: UserLoginCubit.get(context).loginModel!.refresh_token)
    //         .then((value){
    //           List<Chat> userChats = UserLoginCubit.get(context).chats;
    //       for(int i=0;i<userChats.length;i++){
    //         if(userChats[i].id == chatId){
    //           UserLoginCubit.get(context).selectedChat  = userChats[i];
    //         }
    //       }
    //     });
    //   });
    //
    // }
  }
}
