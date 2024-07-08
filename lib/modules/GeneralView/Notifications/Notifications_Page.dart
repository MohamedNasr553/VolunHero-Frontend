import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Layout_bloc/cubit.dart';
import 'package:flutter_code/bloc/Layout_bloc/states.dart';
import 'package:flutter_code/models/AnotherUserModel.dart';
import 'package:flutter_code/modules/GeneralView/AnotherUser/anotherUser_page.dart';
import 'package:flutter_code/modules/GeneralView/Settings/settingsPage.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stroke_text/stroke_text.dart';

import '../../../bloc/Login_bloc/cubit.dart';
import '../../../bloc/Login_bloc/states.dart';
import '../DetailedPost/Detailed_Post.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    if (UserLoginCubit.get(context).loginModel!.refresh_token != null &&
        UserLoginCubit.get(context).loginModel!.refresh_token!.isNotEmpty) {
      UserLoginCubit.get(context).getLoggedInUserNotifications(
          UserLoginCubit.get(context).loginModel?.refresh_token ?? "");
    }
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
                title: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StrokeText(
                      text: "Notifications",
                      textStyle: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      strokeWidth: 0.3,
                      strokeColor: Colors.black,
                    ),
                  ],
                ),
                actions: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: screenWidth / 35),
                    child: IconButton(
                      onPressed: () {
                        navigateToPage(context, const SettingsPage());
                      },
                      iconSize: 28.0,
                      icon: const Icon(Icons.settings_outlined),
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<UserLoginCubit, UserLoginStates>(
                      builder: (context, state) {
                        if (state is GetLoggedInUserNotificationLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: defaultColor,
                            ),
                          );
                        } else if (state
                            is GetLoggedInUserNotificationSuccessState) {
                          final notifications = UserLoginCubit.get(context)
                              .notificationsModel
                              ?.notifications;
                          if (notifications == null || notifications.isEmpty) {
                            return const Center(
                              child: Text('No notifications available'),
                            );
                          }
                          return Padding(
                            padding: EdgeInsetsDirectional.only(
                              top: screenHeight / 60,
                            ),
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  buildNotificationItem(index, context),
                              separatorBuilder: (context, index) => Container(
                                width: double.infinity,
                                height: 0.1,
                                color: Colors.white,
                              ),
                              itemCount: notifications.length,
                            ),
                          );
                        } else if (state
                            is GetLoggedInUserNotificationErrorState) {
                          return const Center(
                            child: Text('Failed to load notifications'),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: defaultColor,
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildNotificationItem(int index, BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    DateTime? createdAt =
        UserLoginCubit.get(context).notificationsModel!.notifications[index].createdAt;
    String? durationText;

    DateTime createdTime = createdAt!;
    DateTime timeNow = DateTime.now();
    Duration difference = timeNow.difference(createdTime);

    if (difference.inMinutes > 59) {
      durationText = '${difference.inHours}h .';
    } else if (difference.inMinutes < 1) {
      durationText = '${difference.inSeconds}s .';
    } else {
      durationText = '${difference.inMinutes.remainder(60)}m .';
    }

    if (difference.inHours >= 24) {
      durationText = '${difference.inDays}d .';
    }

    String? profilePicUrl =
        UserLoginCubit.get(context).notificationsModel!.notifications[index].sender?.profilePic.secureUrl ?? " ";

    return InkWell(
      onTap: () {
        UserLoginCubit.get(context).markNotification(
            UserLoginCubit.get(context).loginModel?.refresh_token,
            UserLoginCubit.get(context)
                .notificationsModel!
                .notifications[index]
                .id);
        if (UserLoginCubit.get(context)
            .notificationsModel!
            .notifications[index]
            .type ==
            "like" ||
            UserLoginCubit.get(context)
                .notificationsModel!
                .notifications[index]
                .type ==
                "comment") {
          final token = UserLoginCubit.get(context).loginModel?.refresh_token;
          final postId = UserLoginCubit.get(context)
              .notificationsModel!
              .notifications[index]
              .relatedEntity;
          if (token != null) {
            HomeLayoutCubit.get(context).getPostId(
              token: token,
              postId: postId,
            );
            if (UserLoginCubit.get(context)
                .notificationsModel!
                .notifications[index]
                .type ==
                "comment") {
              HomeLayoutCubit.get(context).getCommentById(
                token: token,
                postId: postId,
              );
            }
          }
          navigateToPage(context, const DetailedPost());
        }
        else{
          UserLoginCubit.get(context).anotherUser = AnotherUser(
            id: '',
            firstName: '',
            lastName: '',
            userName: '',
            slugUserName: '',
            email: '',
            phone: '',
            role: '',
            status: '',
            images: [],
            address: '',
            gender: '',
            locations: [],
            specification: '',
            attachments: [],
            following: [],
            followers: [],
            updatedAt: '',
          );
          UserLoginCubit.get(context).idOfSelected =
          UserLoginCubit.get(context)
              .notificationsModel!
              .notifications[index].relatedEntity ;
          UserLoginCubit.get(context)
              .getAnotherUserData(
            id: UserLoginCubit.get(context).idOfSelected ?? "",
            token: UserLoginCubit.get(context)
                .loginModel!
                .refresh_token,
          )
              .then((_) {
            // UserLoginCubit.get(context).anotherUser =
            //     HomeLayoutCubit.get(context).anotherUser;
            UserLoginCubit.get(context).inFollowing(
                followId:
                UserLoginCubit.get(context).idOfSelected);
            navigateToPage(context, const AnotherUserProfile());
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth / 30,
          vertical: screenHeight / 120,
        ),
        child: Container(
          height: screenHeight / 11,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (UserLoginCubit.get(context).notificationsModel!.notifications[index].read == true)
                ? Colors.white
                : HexColor("0BA3A6").withOpacity(0.2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10.0,
                spreadRadius: -5.0,
                offset: const Offset(15.0, 5.0),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: screenWidth / 40,
              end: screenWidth / 50,
            ),
            child: Row(
              children: [
                if (UserLoginCubit.get(context).notificationsModel!.notifications[index].type == "like")
                  _buildNotificationAvatar(profilePicUrl, 'assets/images/NewLikeColor.svg'),
                if (UserLoginCubit.get(context).notificationsModel!.notifications[index].type == "comment")
                  _buildNotificationAvatar(profilePicUrl, Icons.comment),
                if (UserLoginCubit.get(context).notificationsModel!.notifications[index].type == "friend_request")
                  _buildNotificationAvatar(profilePicUrl, Icons.person),
                SizedBox(width: screenWidth / 18),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: screenHeight / 150,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight / 60),
                        Text(
                          UserLoginCubit.get(context).notificationsModel!.notifications[index].content,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                          ),
                        ),
                        SizedBox(height: screenHeight / 200),
                        Text(
                          durationText!,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 9.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationAvatar(String? profilePicUrl, dynamic icon) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 32.0,
          backgroundColor: Colors.white,
          backgroundImage: profilePicUrl != null
              ? NetworkImage(profilePicUrl) as ImageProvider
              : const AssetImage("assets/images/nullProfile.png"),
        ),
        // Adjusted handling for different icon types
        if (icon is String)
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              icon,
              width: 22.0,
              height: 22.0,
            ),
          ),
        if (icon is IconData)
          Icon(
            icon,
            color: Colors.black87,
          ),
      ],
    );
  }

}
