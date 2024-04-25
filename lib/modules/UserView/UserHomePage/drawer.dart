import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/states.dart';
import 'package:flutter_code/layout/VolunHeroUserLayout/layout.dart';
import 'package:flutter_code/modules/GeneralView/Settings/settingsPage.dart';
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
        var cubit = HomeLayoutCubit.get(context);

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
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "assets/images/User_circle.svg",
                      width: 30.0,
                      height: 30.0,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth / 40,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                    },
                    child: const Text(
                      'Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Roboto',
                        fontSize: 15.0,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/images/View_alt_fill.svg',
                      width: 30.0,
                      height: 30.0,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth / 40,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                    },
                    child: const Text(
                      'RoadBlocks',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Roboto',
                        fontSize: 15.0,
                      ),
                    ),
                  )
                ],
              ),
              ListTile(
                contentPadding: EdgeInsetsDirectional.only(
                  start: screenWidth / 35,
                ),
                leading: const Icon(
                  Icons.local_phone_outlined,
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
                  cubit.changeBottomNavBar(1);
                  navigateAndFinish(context, const VolunHeroUserLayout());
                },
              ),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsetsDirectional.only(
                  start: screenWidth / 35,
                ),
                leading: const Icon(
                  Icons.info_outline,
                  size: 30.0,
                ),
                title: const Text(
                  'Help and Support',
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
                  start: screenWidth / 35,
                ),
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
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                contentPadding: EdgeInsetsDirectional.only(
                  top: screenHeight / 7.5,
                  start: screenWidth / 35,
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
                  start: screenWidth / 35,
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
                  // navigateToPage(context, const SettingsPage());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
