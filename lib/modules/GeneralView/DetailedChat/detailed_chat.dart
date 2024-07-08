import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/models/ChatsModel.dart';
import 'package:flutter_code/modules/GeneralView/Chats/chatPage.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_list_view/smooth_list_view.dart';



class DetailedChats extends StatefulWidget {
  DetailedChats({super.key});

  @override
  _DetailedChatsState createState() => _DetailedChatsState();
}

class _DetailedChatsState extends State<DetailedChats> {
  Chat? chat;
  Map<int, bool> _selectedMessages = {};
  bool _showIcon = false;

  void _onTap(int index) {
    setState(() {
      _selectedMessages[index] = false;
      _showIcon = false;
    });
  }

  void _onLongPress(int index) {
    setState(() {
      _selectedMessages[index] = true;
      UserLoginCubit.get(context).messageToDelete = UserLoginCubit.get(context).selectedChat!.messages[index].id;
      _showIcon = true;
    });
  }

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
          backgroundColor: HexColor("039FA2"),
          body: Column(
            children: [
              Container(
                height: screenHeight / 6,
                child: Column(
                  children: [
                    SizedBox(height: screenHeight / 15),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            // navigateToPage(context, ChatsPage());
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
                          child: Text(
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
                        const Spacer(),
                        if (_showIcon)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: Icon(Icons.delete_rounded),
                              color: Colors.white,
                              iconSize: 30,
                              onPressed: () {
                                UserLoginCubit.get(context).deleteMessageByHTTP(
                                    token: UserLoginCubit.get(context)
                                        .loginModel!
                                        .refresh_token,
                                    messageID: UserLoginCubit.get(context).messageToDelete,
                                );
                              },
                            ),
                          ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed: () {
                            UserLoginCubit.get(context).refreshChatPage(UserLoginCubit.get(context).selectedChat!.id);
                          },
                          icon:const Icon(Icons.refresh),
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
                    borderRadius: const BorderRadius.only(
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
                      const Center(
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

  Widget buildMessageItem(int index, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    DateTime? createdAt = UserLoginCubit.get(context).selectedChat!.messages[index].createdAt;
    String? durationText;
    DateTime createdTime = createdAt!;
    DateTime timeNow = DateTime.now();
    Duration difference = timeNow.difference(createdTime);

    if (difference.inMinutes > 59) {
      durationText = '${difference.inHours}h ';
    } else if (difference.inMinutes < 1) {
      durationText = '${difference.inSeconds}s ';
    } else {
      durationText = '${difference.inMinutes.remainder(60)}m ';
    }
    if (difference.inHours >= 24) {
      durationText = '${difference.inDays}d ';
    }

    bool isSelected = _selectedMessages[index] ?? false;

    return (UserLoginCubit.get(context).selectedChat!.messages[index].isDeleted== false )? (UserLoginCubit.get(context).selectedChat!.messages[index].senderId != UserLoginCubit.get(context).loggedInUser!.id)
        ? Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: screenWidth / 35),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: HexColor("c0e1e2"),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      durationText,
                      style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                    ),
                    Text(
                      UserLoginCubit.get(context).selectedChat!.messages[index].text,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: screenWidth / 35),
      ],
    )
        : InkWell(
      onTap: () => _onTap(index),
      onLongPress: () => _onLongPress(index),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: screenWidth / 35),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    color: !isSelected ? Color(0xFF51bbbd) : (Colors.grey[400]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            UserLoginCubit.get(context).selectedChat!.messages[index].text,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            durationText,
                            style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth / 35),
            ],
          ),
        ],
      ),
    ):Container(child: null,);
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
                  String text = chatMessage.text.toString();
                  String chatId = UserLoginCubit.get(context).selectedChat!.id;
                  String senderId = UserLoginCubit.get(context).loggedInUser!.id;

                  if (text.trimLeft().trimRight().isNotEmpty) {

                    await UserLoginCubit.get(context).sendMessage(
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
