import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/states.dart';
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
  NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (UserLoginCubit.get(context).loginModel!.refresh_token != null &&
        UserLoginCubit.get(context).loginModel!.refresh_token!.isNotEmpty) {
          UserLoginCubit.get(context).getLoggedInUserNotifications(UserLoginCubit.get(context).loginModel!.refresh_token);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        fontSize: 30.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      strokeWidth: 0.2,
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
                      iconSize: 30.0,
                      icon: const Icon(
                        Icons.settings_outlined,
                      ),
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
                          return Center(
                            child: CircularProgressIndicator(color: defaultColor,),
                          );
                        } else if (state is GetLoggedInUserNotificationSuccessState) {
                          final notifications = UserLoginCubit.get(context).notificationsModel?.notifications;
                          if (notifications == null || notifications.isEmpty) {
                            return Center(
                              child: Text('No notifications available'),
                            );
                          }
                          return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildNotificationItem(index, context),
                            separatorBuilder: (context, index) => Padding(
                              padding: const EdgeInsetsDirectional.only(start: 10.0),
                              child: Container(
                                width: double.infinity,
                                height: 0.1,
                                color: Colors.white,
                              ),
                            ),
                            itemCount: notifications.length,
                          );
                        } else if (state is GetLoggedInUserNotificationErrorState) {
                          return Center(
                            child: Text('Failed to load notifications'),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(color: defaultColor,),
                          );
                        }
                      },
                    ),
                  )
                ],
              ));
        }
    );
    }
    );
  }

  Widget buildNotificationItem(index, context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
// Handling Post Duration
    DateTime? createdAt = UserLoginCubit.get(context).notificationsModel!.notifications[index].createdAt;
    String? durationText;

    DateTime createdTime = createdAt;
    DateTime timeNow = DateTime.now();
    Duration difference = timeNow.difference(createdTime);

    if (difference.inMinutes > 59) {
      durationText = '${difference.inHours}h .';
    } else if (difference.inMinutes < 1) {
      durationText = '${difference.inSeconds}s .';
    } else {
      durationText = '${difference.inMinutes.remainder(60)}m .';
    }
    // In Days
    if (difference.inHours >= 24) {
      durationText = '${difference.inDays}d .';
    }
    return InkWell(
      onTap: (){
        UserLoginCubit.get(context).markNotification(
            UserLoginCubit.get(context).loginModel?.refresh_token,
            UserLoginCubit.get(context).notificationsModel!.notifications[index].id
        );
        if(UserLoginCubit.get(context).notificationsModel!.notifications[index].type=="like" ||
        UserLoginCubit.get(context).notificationsModel!.notifications[index].type=="comment"
        ){
          final token = UserLoginCubit.get(context).loginModel?.refresh_token;
          final postId = UserLoginCubit.get(context).notificationsModel!.notifications[index].relatedEntity;
          if(token!=null){
            HomeLayoutCubit.get(context).getPostId(
              token: token,
              postId: postId,
            );
            if (UserLoginCubit.get(context).notificationsModel!.notifications[index].type=="comment") {
              HomeLayoutCubit.get(context).getCommentById(
                token: token,
                postId: postId,
              );
            }
          }

          navigateToPage(context, const DetailedPost());
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth / 30, vertical: screenHeight / 120),
        child: Container(
          height: screenHeight / 10,
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
                offset: const Offset(15.0, 5.0), // Right and bottom shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                if(UserLoginCubit.get(context).notificationsModel!.notifications[index].type=="like")IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/images/NewLikeColor.svg',
                    width: 22.0,
                    height: 22.0,
                  ),
                ),
                if(UserLoginCubit.get(context).notificationsModel!.notifications[index].type=="comment")IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/images/comment.svg',
                    width: 30.0,
                    height: 30.0,
                  ),
                ),

                SizedBox(
                  width: screenWidth / 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight / 70,
                    ),
                    Text(
                      "${UserLoginCubit.get(context).notificationsModel!.notifications[index].content}",
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    Text(
                      "${durationText}",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
