import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Layout_bloc/cubit.dart';
import 'package:flutter_code/bloc/Layout_bloc/states.dart';
import 'package:flutter_code/bloc/savedPosts_bloc/cubit.dart';
import 'package:flutter_code/layout/VolunHeroLayout/layout.dart';
import 'package:flutter_code/modules/GeneralView/SavedPosts/Saved_Posts.dart';
import 'package:flutter_code/modules/GeneralView/Settings/settingsPage.dart';
import 'package:flutter_code/modules/GeneralView/ProfilePage/Profile_Page.dart';
import 'package:flutter_code/modules/OrganizationView/AllDonationFormPage/AllForms.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_list_view/smooth_list_view.dart';

import '../../../bloc/Login_bloc/cubit.dart';
import '../../../bloc/Login_bloc/states.dart';
import '../../GeneralView/Login/Login_Page.dart';

class UserSidePage extends StatelessWidget {
  const UserSidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   UserLoginCubit.get(context).getLoggedInUserData(token: userToken ?? "");
    // });

    return BlocConsumer<HomeLayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);

        return BlocConsumer<UserLoginCubit, UserLoginStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Drawer(
              backgroundColor: Colors.white,
              child: SmoothListView(
                duration: const Duration(milliseconds: 200),
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Row(
                      children: [
                        Text(
                          UserLoginCubit.get(context).loggedInUser?.firstName ??
                              "First",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(width: screenWidth / 150),
                        Text(
                          UserLoginCubit.get(context).loggedInUser?.lastName ??
                              "Last",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    accountEmail: Text(
                      UserLoginCubit.get(context).loggedInUser?.email ??
                          "@username@gmail",
                      style: const TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    currentAccountPicture: CircleAvatar(
                      child: ClipOval(
                          child: (HomeLayoutCubit.get(context)
                                      .modifiedPost
                                      ?.createdBy
                                      .profilePic ==
                                  null)
                              ? Image.asset(
                                  'assets/images/nullProfile.png',
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                )
                              : Image(
                                  width: 90,
                                  height: 90,
                                  image: NetworkImage(
                                      UserLoginCubit.get(context)
                                              .loggedInUser
                                              ?.profilePic
                                              ?.secure_url ??
                                          'default_image_url'),
                                )),
                    ),
                    decoration: const BoxDecoration(
                      color: defaultColor,
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      alignment: Alignment.centerLeft,
                      width: screenWidth / 14,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          "assets/images/User_circle.svg",
                          width: 30.0,
                          height: 30.0,
                        ),
                      ),
                    ),
                    title: const Text(
                      'Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Roboto',
                        fontSize: 15.0,
                      ),
                    ),
                    onTap: () {
                      // navigateAndFinish(context, const AnotherUserProfile());
                      navigateAndFinish(context, const ProfilePage());
                    },
                  ),
                  (UserLoginCubit.get(context).loggedInUser?.role == "Organization") ?
                  ListTile(
                    leading: Container(
                      alignment: Alignment.centerLeft,
                      width: screenWidth / 14,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/images/File_dock.svg',
                          width: 30.0,
                          height: 30.0,
                        ),
                      ),
                    ),
                    title: const Text(
                      'Donation Forms',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Roboto',
                        fontSize: 15.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      navigateToPage(context, const AllDonationForms());
                    },
                  ):
                    ListTile(
                    leading: Container(
                      alignment: Alignment.centerLeft,
                      width: screenWidth / 14,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/images/View_alt_fill.svg',
                          width: 30.0,
                          height: 30.0,
                        ),
                      ),
                    ),
                    title: const Text(
                      'RoadBlocks',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Roboto',
                        fontSize: 15.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.save,
                      size: 30.0,
                    ),
                    title: const Text(
                      'Saved Posts',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Roboto',
                        fontSize: 15.0,
                      ),
                    ),
                    onTap: () {
                      SavedPostsCubit.get(context).getAllSavedPosts(
                        token: UserLoginCubit.get(context)
                                .loginModel!
                                .refresh_token ??
                            "",
                      );
                      navigateAndFinish(context, const SavedPosts());
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.phone,
                      size: 30.0,
                    ),
                    title: const Text(
                      'Video Call',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Roboto',
                        fontSize: 15.0,
                      ),
                    ),
                    onTap: () {
                      UserLoginCubit.get(context).loggedInUser?.role == "Organization" ?
                      cubit.changeOrganizationBottomNavBar(context, 1):
                      cubit.changeUserBottomNavBar(context, 1);
                      navigateAndFinish(context, const VolunHeroLayout());
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.settings_outlined,
                      size: 30.0,
                    ),
                    title: const Text(
                      'Settings',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Roboto',
                        fontSize: 15.0,
                      ),
                    ),
                    onTap: () {
                      navigateToPage(context, const SettingsPage());
                      // Close the drawer
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsetsDirectional.only(
                      top: screenHeight / 5,
                      start: screenWidth / 23,
                    ),
                    leading: const Icon(
                      Icons.add_circle_outline_sharp,
                      size: 30.0,
                    ),
                    title: const Text(
                      'Add Account',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Roboto',
                        fontSize: 15.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsetsDirectional.only(
                      start: screenWidth / 23,
                    ),
                    leading: const Icon(
                      Icons.exit_to_app_outlined,
                      size: 30.0,
                    ),
                    title: const Text(
                      'Log out',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Roboto',
                        fontSize: 15.0,
                      ),
                    ),
                    onTap: () {
                      // Remove token
                      navigateToPage(context, LoginPage());

                      ///signOut(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
