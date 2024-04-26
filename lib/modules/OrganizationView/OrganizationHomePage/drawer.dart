import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/OrganizationLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/states.dart';
import 'package:flutter_code/layout/VolunHeroOrganizationLayout/layout.dart';
import 'package:flutter_code/modules/OrganizationView/AllDonationFormPage/AllForms.dart';
import 'package:flutter_code/modules/OrganizationView/OrganizationSavedPosts/Organization_Saved_Posts.dart';
import 'package:flutter_code/modules/GeneralView/GetSupport/Support_Page.dart';
import 'package:flutter_code/modules/GeneralView/Settings/settingsPage.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_list_view/smooth_list_view.dart';

class OrganizationSidePage extends StatelessWidget {
  const OrganizationSidePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<HomeLayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = OrganizationLayoutCubit.get(context);

        return Drawer(
          child: SmoothListView(
            duration: const Duration(milliseconds: 200),
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text('@UserName'),
                accountEmail: const Text('user@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: defaultColor,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/OrganizationLogo.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: defaultColor,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsetsDirectional.only(
                  start: screenWidth / 65,
                ),
                leading: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/images/User_circle.svg",
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.cover,
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
                    'assets/images/AddDonationFormLogo.svg',
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text(
                  'Add Donation Form',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Roboto',
                    fontSize: 15.0,
                  ),
                ),
                onTap: () {
                  cubit.orgChangeBottomNavBar(4);
                  navigateAndFinish(context, const VolunHeroOrganizationLayout());
                },
              ),
              ListTile(
                leading: Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: screenWidth / 60,
                  ),
                  child: const Icon(
                    Icons.local_phone_outlined,
                    size: 30.0,
                  ),
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
                  cubit.orgChangeBottomNavBar(1);
                  navigateAndFinish(context, const VolunHeroOrganizationLayout());
                },
              ),
              ListTile(
                leading: Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: screenWidth / 60,
                  ),
                  child: const Icon(
                    Icons.save,
                    size: 30.0,
                  ),
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
                  navigateAndFinish(context, const OrganizationSavedPosts());
                },
              ),
              ListTile(
                contentPadding: EdgeInsetsDirectional.only(
                  start: screenWidth / 65,
                  top: screenHeight / 300,
                ),
                leading: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/images/File_dock.svg",
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.cover,
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
                  navigateAndFinish(context, const AllDonationForms());
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
                    size: 30.0,
                  ),
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
                leading: Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: screenWidth / 60,
                  ),
                  child: const Icon(
                    Icons.settings_outlined,
                    size: 30.0,
                  ),
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
                  // Navigator.pop(context); // Close the drawer
                },
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  top: screenHeight / 30,
                  end: screenWidth / 60,
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.add_circle_outline_sharp,
                    size: 30.0,
                  ),
                  title: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: screenWidth / 55,
                    ),
                    child: const Text(
                      'Add Account',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Roboto',
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                  },
                ),
              ),
              ListTile(
                leading: Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: screenWidth / 60,
                  ),
                  child: const Icon(
                    Icons.exit_to_app_outlined,
                    size: 30.0,
                  ),
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
