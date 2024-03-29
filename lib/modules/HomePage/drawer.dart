import 'package:flutter/material.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_list_view/smooth_list_view.dart';

class SidePage extends StatelessWidget {
  const SidePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Drawer(
      child: SmoothListView(
        duration: const Duration(milliseconds: 200),
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('@UserName'),
            accountEmail: const Text('user@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  // Sample
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 100.0,
                  height: 100.0,
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
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.local_phone_outlined,
              size: 35.0,
            ),
            title: const Text(
              'Video Call',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontFamily: 'Roboto',
              ),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.info_outline,
              size: 35.0,
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
            leading: const Icon(
              Icons.settings_outlined,
              size: 35.0,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontFamily: 'Roboto',
              ),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
