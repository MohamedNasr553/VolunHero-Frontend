import 'package:flutter/material.dart';
import 'package:flutter_code/layout/VolunHeroUserLayout/layout.dart';
import 'package:flutter_code/modules/GeneralView/GetSupport/Support_Page.dart';
import 'package:flutter_code/modules/UserView/UserHomePage/User_Home_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stroke_text/stroke_text.dart';

class Education extends StatelessWidget {
  Education({super.key});

  List<Map<String, dynamic>> contacts = [];

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    for (int i = 1; i <= 5; i++) {
      contacts.add({
        'image': 'assets/images/logo.png', // Dummy image filename
        'name': 'User $i Name', // Dummy description
        'role': "Teacher" // Calculate time ago
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(
          icon:SvgPicture.asset(
            'assets/images/arrowLeft.svg',
          ),
          color: HexColor("858888"),
          onPressed:(){
            // navigateToPage(context, const VolunHeroUserLayout());
          },
        ),
        title:  StrokeText(
          text: "Education",
          strokeColor: Colors.white,
          textStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              color: HexColor("296E6F")
          ),
        ),
      ),
      body: Column(
        children: [

          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildContactItem(index, context),
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

  Widget buildContactItem(index, context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth / 30, vertical: screenHeight / 100),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10.0,
              spreadRadius: -5.0,
              offset: Offset(15.0, 5.0), // Right and bottom shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage:
                    AssetImage(contacts[index]['image']),
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
              SizedBox(width: screenWidth/20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contacts[index]['name'],
                    style: TextStyle(
                        fontFamily: "Roboto",
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: screenHeight/300,),
                  Text(
                    contacts[index]['role'],
                    style: TextStyle(
                        fontWeight: FontWeight.w100
                    ),
                  )
                ],
              ),
              Spacer(),
              IconButton(
                onPressed: (){
                  showToast(text: "Calling...", state: ToastStates.SUCCESS);
                },
                icon:SvgPicture.asset(
                  'assets/images/Phone_fill.svg',
                ),
                color: HexColor("039FA2"),

              )
            ],
          ),
        ),
      ),
    );
  }
}
