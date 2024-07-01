import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/states.dart';
import 'package:flutter_code/models/likesOnSpecificPost.dart';
import 'package:flutter_code/modules/GeneralView/DetailedPost/Detailed_Post.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class ReactionsPage extends StatelessWidget {
  const ReactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: SvgPicture.asset('assets/images/arrowLeft.svg'),
              color: HexColor("858888"),
              onPressed: () => navigateToPage(context, const DetailedPost()),
            ),
            title: const Text(
              'Reactions',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Column(
            children: [
              separator(),
              (state is! GetLikesOnPostLoadingState)
                  ? buildUsersLikesList(context)
                  : const Center(
                    child: LinearProgressIndicator(color: defaultColor),
                  ),
            ],
          ),
        );
      },
    );
  }

  Widget buildUsersLikesList(context) {
    var homeCubit = HomeLayoutCubit.get(context);

    if (homeCubit.userLikesModel != null) {
      if (homeCubit.userLikesModel!.users.isNotEmpty) {
        return Expanded(
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (homeCubit.userLikesModel != null) {
                    if (index < homeCubit.userLikesModel!.users.length) {
                      return buildUsersLikesOnPost(
                        homeCubit.userLikesModel!.users[index],
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
                itemCount: homeCubit.userLikesModel?.users.length ?? 0,
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

  Widget buildUsersLikesOnPost(LikedUser? likedUser, BuildContext context) {
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
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 27.0,
                backgroundImage: likedUser!.profilePic != null
                    ? NetworkImage(likedUser.profilePic!.secureUrl) as ImageProvider
                    : const AssetImage("assets/images/nullProfile.png"),
              ),
              SvgPicture.asset(
                "assets/images/NewLikeColor.svg",
                width: 20,
                height: 20,
              ),
            ],
          ),
          SizedBox(width: screenWidth / 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    likedUser.firstName,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: screenWidth / 120),
                  Text(
                    likedUser.lastName,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: screenWidth / 120),
                  Text(
                    '@${likedUser.userName}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 8.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                likedUser.specification,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 9.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
