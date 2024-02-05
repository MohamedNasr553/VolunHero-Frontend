import 'package:flutter/material.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_list_view/smooth_list_view.dart';

class SidePage extends StatelessWidget {
  const SidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SmoothListView(
        duration: const Duration(milliseconds: 400),
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
            contentPadding: const EdgeInsetsDirectional.only(
              start: 5.0,
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
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            contentPadding: const EdgeInsetsDirectional.only(
              start: 5.0,
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
            title: const Text('Road Blocks'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.local_phone_outlined,
                size: 35.0,
              ),
            ),
            title: const Text('Video Call'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          const Divider(),
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.info_outline,
                size: 35.0,
              ),
            ),
            title: const Text('Help and Support'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.settings,
                size: 35.0,
              ),
            ),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
