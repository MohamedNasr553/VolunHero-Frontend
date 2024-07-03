import 'package:flutter/material.dart';
import 'package:flutter_code/layout/VolunHeroLayout/layout.dart';
import 'package:flutter_code/modules/GeneralView/GetSupport/Support_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stroke_text/stroke_text.dart';

class Questions extends StatelessWidget {
  Questions({super.key});

  List<Map<String, dynamic>> contacts = [];

  @override
  Widget build(BuildContext context) {
    for (int i = 1; i <= 10; i++) {
      contacts.add({
        'image': 'assets/images/logo.png', // Dummy image filename
        'name': 'User $i Name', // Dummy description
        'role': (i % 2 == 0) ? 'Teacher' : "Doctor" // Calculate time ago
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/images/arrowLeft.svg',
          ),
          color: HexColor("858888"),
          onPressed: () {
            navigateToPage(context, const GetSupport());
          },
        ),
        title: StrokeText(
          text: "General",
          strokeColor: Colors.white,
          textStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              color: HexColor("296E6F")),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildSupportCallItem(index, context),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(start: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 0.1,
                  color: Colors.white,
                ),
              ),
              itemCount: contacts.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSupportCallItem(index, context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth / 30, vertical: screenHeight / 100),
      child: Container(
        height: screenHeight / 11,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10.0,
              spreadRadius: -5.0,
              offset: const Offset(10.0, 5.0),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: screenWidth / 70,
            end: screenWidth / 50,
          ),
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    radius: 35.0,
                    backgroundImage: AssetImage(contacts[index]['image']),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      bottom: screenHeight / 100,
                      end: screenWidth / 80,
                    ),
                    child: const CircleAvatar(
                      radius: 5.0,
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
              SizedBox(width: screenWidth / 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: screenHeight / 50,
                    ),
                    child: Text(
                      contacts[index]['name'],
                      style: const TextStyle(
                          fontFamily: "Roboto",
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: screenHeight / 300),
                  Text(
                    contacts[index]['role'],
                    style: const TextStyle(fontWeight: FontWeight.w100),
                  )
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  // Phone Here Waiting for Backend...
                  launchPhoneDialer('1234567890');
                },
                icon: SvgPicture.asset('assets/images/Phone_fill.svg'),
                color: HexColor("039FA2"),
              ),
              IconButton(
                onPressed: () {
                  navigateToURL(url: "https://app.zoom.us/wc");
                },
                icon: const Icon(
                  Icons.videocam,
                ),
                color: HexColor("039FA2"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
