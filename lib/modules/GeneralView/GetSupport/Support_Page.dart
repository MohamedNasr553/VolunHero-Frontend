import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Layout_bloc/cubit.dart';
import 'package:flutter_code/bloc/Layout_bloc/states.dart';
import 'package:flutter_code/layout/VolunHeroLayout/layout.dart';
import 'package:flutter_code/modules/GeneralView/AllQuestions/AllQuestions_Page.dart';
import 'package:flutter_code/modules/GeneralView/Education/Education_Page.dart';
import 'package:flutter_code/modules/GeneralView/MedicalHelp/MedicalHelp_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stroke_text/stroke_text.dart';

class GetSupport extends StatelessWidget {
  const GetSupport({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<HomeLayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight / 3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/getSupportpng.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight / 4,
                    ),
                    Text(
                      "Support Calls",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 32.0,
                        fontWeight: FontWeight.w700,
                        color: HexColor("296E6F"),
                      ),
                    ),
                    StrokeText(
                      text: "For easy communication",
                      strokeColor: Colors.white,
                      textStyle: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: HexColor("296E6F"),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(height: screenHeight / 3),
                  boxElement(
                      screenHeight,
                      screenWidth,
                      "assets/images/Rectangle 4184.png",
                      "General",
                      "Get support from all volunteers",
                      context,
                      Questions()),
                  boxElement(
                      screenHeight,
                      screenWidth,
                      "assets/images/Rectangle 4189.png",
                      "Education",
                      "Get support from volunteering teachers",
                      context,
                      Education()),
                  boxElement(
                      screenHeight,
                      screenWidth,
                      "assets/images/Rectangle 4191.png",
                      "Medical",
                      "Get support from volunteering doctors",
                      context,
                      MedicalHelp()),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget boxElement(var screenHeight, var screenWidth, String assetPath,
      String title, String text, BuildContext context, Widget page) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth / 25, vertical: screenHeight / 70),
      child: Container(
        width: double.infinity,
        height: screenHeight / 7.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10.0,
              spreadRadius: -5.0,
              offset: const Offset(7.0, 7.0), // Right and bottom shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenWidth / 2.9,
              height: screenHeight / 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(assetPath),
                ),
              ),
            ),
            SizedBox(
              width: screenWidth / 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                    color: HexColor("318284"),
                  ),
                ),
                SizedBox(
                  height: 1.0,
                ),
                Text(
                  text,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: "Roboto",
                      color: HexColor("656565")),
                ),
                SizedBox(
                  height: screenHeight / 50,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth / 2.8,
                    ),
                    InkWell(
                      onTap: () {
                        navigateToPage(context, page);
                      },
                      child: Container(
                        height: 30,
                        width: 66,
                        decoration: BoxDecoration(
                            color: HexColor("00B5B9"),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth / 46),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Go",
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: screenWidth / 150,
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
