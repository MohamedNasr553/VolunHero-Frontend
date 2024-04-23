import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/states.dart';
import 'package:flutter_code/modules/UserView/GetSupport/Support_Page.dart';
import 'package:flutter_code/modules/GeneralView/Settings/settingsPage.dart';
import 'package:flutter_code/modules/UserView/RoadBlocks/Roadblocks.dart';
import 'package:flutter_code/modules/UserView/UserSavedPost/User_Saved_Posts.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_list_view/smooth_list_view.dart';

class SidePage extends StatelessWidget {
  const SidePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<HomeLayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Drawer(
          child: SmoothListView(
            duration: const Duration(milliseconds: 200),
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text('@UserName'),
                accountEmail: const Text('user@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(child: Image.asset("assets/images/logo.png")),
                ),
                decoration: const BoxDecoration(
                  color: defaultColor,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsetsDirectional.only(
                  start: screenWidth / 65,
                  top: screenHeight / 60,
                ),
                leading: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/images/User_circle.svg",
                    width: 35.0,
                    height: 35.0,
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text(
                  'Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Roboto',
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                contentPadding: EdgeInsetsDirectional.only(
                  start: screenWidth / 65,
                ),
                leading: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/images/View_alt_fill.svg',
                    width: 35.0,
                    height: 35.0,
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text(
                  'RoadBlocks',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Roboto',
                  ),
                ),
                onTap: () {
                  navigateAndFinish(context, const RoadBlocksPage());
                },
              ),
              ListTile(
                leading: Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: screenWidth / 60,
                  ),
                  child: const Icon(
                    Icons.local_phone_outlined,
                    size: 35.0,
                  ),
                ),
                title: const Text(
                  'Video Call',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Roboto',
                  ),
                ),
                onTap: () {
                  // cubit.changeBottomNavBar(1);
                  navigateAndFinish(context, const GetSupport());
                },
              ),
              ListTile(
                leading: Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: screenWidth / 60,
                  ),
                  child: const Icon(
                    Icons.save,
                    size: 35.0,
                  ),
                ),
                title: const Text(
                  'Saved Posts',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Roboto',
                  ),
                ),
                onTap: () {
                  // cubit.changeBottomNavBar(1);
                  navigateAndFinish(context, const UserSavedPosts());
                },
              ),
              const Divider(),
              ListTile(
                leading: Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: screenWidth / 60,
                  ),
                  child: const Icon(
                    Icons.info_outline,
                    size: 35.0,
                  ),
                ),
                title: const Text(
                  'Help and Support',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Roboto',
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: screenWidth / 60,
                  ),
                  child: const Icon(
                    Icons.settings_outlined,
                    size: 35.0,
                  ),
                ),
                title: const Text(
                  'Settings',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Roboto',
                  ),
                ),
                onTap: () {
                  navigateToPage(context, const SettingsPage());
                  // Navigator.pop(context); // Close the drawer
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
