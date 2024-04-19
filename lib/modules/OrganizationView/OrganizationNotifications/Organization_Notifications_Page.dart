import 'package:flutter/material.dart';
import 'package:flutter_code/modules/GeneralView/Settings/settingsPage.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stroke_text/stroke_text.dart';

class OrganizationNotificationPage extends StatelessWidget {
  OrganizationNotificationPage({super.key});

  List<Map<String, dynamic>> notifications = [];

  // Fill the list with 10 dummy notifications

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    for (int i = 1; i <= 10; i++) {
      notifications.add({
        'image': 'assets/images/logo.png', // Dummy image filename
        'description': 'Notification $i description', // Dummy description
        'time': '10m' // Calculate time ago
      });
    }
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
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildNotificationItem(index, context),
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10.0),
                  child: Container(
                    width: double.infinity,
                    height: 0.1,
                    color: Colors.white,
                  ),
                ),
                itemCount: notifications.length,
              ),
            ),
          ],
        ));
  }

  Widget buildNotificationItem(index, context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth / 30, vertical: screenHeight / 120),
      child: Container(
        height: screenHeight / 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: (index % 2 == 0)
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
              CircleAvatar(
                radius: 40.0,
                backgroundImage: AssetImage(notifications[index]['image']),
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
                    notifications[index]['description'],
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 1.0,
                  ),
                  Text(
                    notifications[index]['time'],
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
    );
  }
}
