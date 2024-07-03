import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/bloc/Layout_bloc/cubit.dart';
import 'package:flutter_code/bloc/Layout_bloc/states.dart';
import 'package:flutter_code/models/getMyFollowers.dart';
import 'package:flutter_code/modules/GeneralView//AnotherUser/anotherUser_page.dart';
import 'package:flutter_code/modules/GeneralView/ProfilePage/Profile_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class FollowersPage extends StatelessWidget {
  const FollowersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLoginCubit, UserLoginStates>(
      listener: (context, state){ },
      builder: (context, state){
        return BlocConsumer<HomeLayoutCubit, LayoutStates>(
          listener: (context, state) {},
          builder: (context, state){
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                  icon: SvgPicture.asset('assets/images/arrowLeft.svg'),
                  color: HexColor("858888"),
                  onPressed: () => navigateToPage(context, const ProfilePage()),
                ),
                title: Text(
                  UserLoginCubit.get(context).loggedInUser!.userName,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              body: Column(
                children: [
                  separator(),
                  (state is! GetMyFollowersLoadingState)
                      ? buildMyFollowersList(context)
                      : const Center(
                    child: LinearProgressIndicator(color: defaultColor),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMyFollowersList(context) {
    var userLoginCubit = UserLoginCubit.get(context);

    if (userLoginCubit.userProfileFollowers != null) {
      if (userLoginCubit.userProfileFollowers!.followersList.isNotEmpty) {
        return Expanded(
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (userLoginCubit.userProfileFollowers != null) {
                    if (index < userLoginCubit.userProfileFollowers!.followersList.length) {
                      return buildMyFollowers(
                        userLoginCubit.userProfileFollowers!.followersList[index],
                        context,
                      );
                    }
                  }
                  return null;
                },
                separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: MediaQuery.of(context).size.width / 4.8,
                  ),
                  child: separator(),
                ),
                itemCount: userLoginCubit.userProfileFollowers?.followersList.length ?? 0,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: MediaQuery.of(context).size.width / 4.8,
                ),
                child: separator(),
              ),
            ],
          ),
        );
      }
    }
    return const SizedBox();
  }

  Widget buildMyFollowers(Follower? followers, BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: screenWidth / 100,
        end: screenWidth / 100,
        top: screenHeight / 80,
        // bottom: screenHeight / 120
      ),
      child: Row(
        children: [
          SizedBox(width: screenWidth / 50),
          InkWell(
            onTap: (){
              if (followers.userId.id ==
                  UserLoginCubit.get(context).loggedInUser!.id) {
                navigateToPage(context, const ProfilePage());
              } else {
                HomeLayoutCubit.get(context)
                    .getAnotherUserData(
                    token: UserLoginCubit.get(context)
                        .loginModel!
                        .refresh_token,
                    id: followers.userId.id)
                    .then((value) {
                  UserLoginCubit.get(context).anotherUser =
                      HomeLayoutCubit.get(context).anotherUser;
                  navigateToPage(context, const AnotherUserProfile());
                });
              }
            },
            child: CircleAvatar(
              radius: 27.0,
              backgroundImage: followers!.userId.profilePic != null
                  ? NetworkImage(followers.userId.profilePic!.secureUrl) as ImageProvider
                  : const AssetImage("assets/images/nullProfile.png"),
            ),
          ),
          SizedBox(width: screenWidth / 30),
          InkWell(
            onTap: () {
              if (followers.userId.id ==
                  UserLoginCubit.get(context).loggedInUser!.id) {
                navigateToPage(context, const ProfilePage());
              } else {
                HomeLayoutCubit.get(context)
                    .getAnotherUserData(
                    token: UserLoginCubit.get(context)
                        .loginModel!
                        .refresh_token,
                    id: followers.userId.id)
                    .then((value) {
                  UserLoginCubit.get(context).anotherUser =
                      HomeLayoutCubit.get(context).anotherUser;
                  navigateToPage(
                      context, const AnotherUserProfile());
                });
              }
            },
            child: Text(
              followers.userId.userName,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
