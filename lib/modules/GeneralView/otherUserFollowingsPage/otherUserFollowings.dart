import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/states.dart';
import 'package:flutter_code/models/OtherUserFollowings.dart';
import 'package:flutter_code/models/getMyFollowing.dart';
import 'package:flutter_code/modules/UserView/AnotherUser/anotherUser_page.dart';
import 'package:flutter_code/modules/UserView/UserProfilePage/Profile_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class OtherUserFollowings extends StatelessWidget {
  const OtherUserFollowings({super.key});

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
                  onPressed: () => navigateToPage(context, const AnotherUserProfile()),
                ),
                title: Text(
                  HomeLayoutCubit.get(context).anotherUser!.userName,
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
                  (state is! GetMyFollowingLoadingState)
                      ? buildOtherUserFollowingList(context)
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

  Widget buildOtherUserFollowingList(context) {
    var userLoginCubit = UserLoginCubit.get(context);

    if (userLoginCubit.otherUserProfileFollowings != null) {
      if (userLoginCubit.otherUserProfileFollowings!.otherUserFollowingsList!.isNotEmpty) {
        return Expanded(
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (userLoginCubit.otherUserProfileFollowings != null) {
                    if (index < userLoginCubit.otherUserProfileFollowings!.otherUserFollowingsList!.length) {
                      return buildOtherUserFollowings(
                        userLoginCubit.otherUserProfileFollowings!.otherUserFollowingsList![index],
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
                itemCount: userLoginCubit.userProfileFollowings?.followingsList.length ?? 0,
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

  Widget buildOtherUserFollowings(OtherUserFollowingsModel? followings, BuildContext context) {
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
              if (followings.userId.id ==
                  UserLoginCubit.get(context).loggedInUser!.id) {
                navigateToPage(context, const ProfilePage());
              } else {
                HomeLayoutCubit.get(context)
                    .getAnotherUserData(
                    token: UserLoginCubit.get(context)
                        .loginModel!
                        .refresh_token,
                    id: followings.userId.id)
                    .then((value) {
                  UserLoginCubit.get(context).anotherUser =
                      HomeLayoutCubit.get(context).anotherUser;
                  navigateToPage(context, const AnotherUserProfile());
                });
              }
            },
            child: CircleAvatar(
              radius: 27.0,
              backgroundImage: followings!.userId.profilePic != null
                  ? NetworkImage(followings.userId.profilePic!.secureUrl) as ImageProvider
                  : const AssetImage("assets/images/nullProfile.png"),
            ),
          ),
          SizedBox(width: screenWidth / 30),
          InkWell(
            onTap: () {
              if (followings.userId.id ==
                  UserLoginCubit.get(context).loggedInUser!.id) {
                navigateToPage(context, const ProfilePage());
              } else {
                HomeLayoutCubit.get(context)
                    .getAnotherUserData(
                    token: UserLoginCubit.get(context)
                        .loginModel!
                        .refresh_token,
                    id: followings.userId.id)
                    .then((value) {
                  UserLoginCubit.get(context).anotherUser =
                      HomeLayoutCubit.get(context).anotherUser;
                  navigateToPage(
                      context, const AnotherUserProfile());
                });
              }
            },
            child: Text(
              followings.userId.userName,
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
