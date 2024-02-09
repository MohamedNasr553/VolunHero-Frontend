import 'package:flutter/material.dart';
import 'package:flutter_code/modules/AllQuestions/AllQuestions_Page.dart';
import 'package:flutter_code/modules/Education/Education_Page.dart';
import 'package:flutter_code/modules/MedicalHelp/MedicalHelp_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:stroke_text/stroke_text.dart';

class GetSupport extends StatelessWidget {
  const GetSupport({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              radius: 70.0,
              child: ClipOval(
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight / 200,
          ),
          const Column(
            children: [
              StrokeText(
                text: "Support calls",
                textStyle: TextStyle(
                    letterSpacing: 0.5,
                    fontSize: 35.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: "Roboto"),
              ),
              StrokeText(
                text: "For easy communication",
                textStyle: TextStyle(
                  letterSpacing: 0.5,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: "Roboto",
                ),
                strokeWidth: 0.3,
                strokeColor: Colors.black,
              ),
            ],
          ),
          SizedBox(
            height: screenHeight / 15,
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: screenWidth / 30,
              end: screenHeight / 80,
            ),
            child: const Row(
              children: [
                StrokeText(
                  text: "Choose Category",
                  textStyle: TextStyle(
                    letterSpacing: 0.5,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: "Roboto",
                  ),
                  strokeWidth: 0.5,
                  strokeColor: Colors.black,
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight / 25),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    navigateToPage(context, Questions());
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/Rectangle 4178.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Center(
                        child: Text(
                          "All",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                      )
                    ],
                  )),
              SizedBox(height: screenHeight / 30),
              InkWell(
                  onTap: () {
                    navigateToPage(context, MedicalHelp());
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/Rectangle 4178.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Center(
                        child: Text(
                          "Medical help",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                      )
                    ],
                  )),
              SizedBox(height: screenHeight / 30),
              InkWell(
                  onTap: () {
                    navigateToPage(context, Education());
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/Rectangle 4178.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Center(
                        child: Text(
                          "Education",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                      )
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
