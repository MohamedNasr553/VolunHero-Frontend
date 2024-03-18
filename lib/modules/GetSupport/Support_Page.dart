import 'package:flutter/material.dart';
import 'package:flutter_code/modules/AllQuestions/AllQuestions_Page.dart';
import 'package:flutter_code/modules/Education/Education_Page.dart';
import 'package:flutter_code/modules/MedicalHelp/MedicalHelp_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stroke_text/stroke_text.dart';

class GetSupport extends StatelessWidget {
  const GetSupport({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(

      body: Stack(

        children: [
          Container(
            width: screenWidth,
            height: screenHeight/3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/getSupportpng.png'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight/4,),
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
              SizedBox(height: screenHeight/3,),
              boxElement(screenHeight, screenWidth,"assets/images/Rectangle 4184.png" , "General", "get support from all volunteers", context ,Questions()),
              boxElement(screenHeight, screenWidth,"assets/images/Rectangle 4189.png" , "Education", "get support from volunteering teachers",context ,Education()),
              boxElement(screenHeight, screenWidth,"assets/images/Rectangle 4191.png" , "Medical", "get support from volunteering doctors",context,MedicalHelp() ),
            ],
          )

        ],
      ),
    );





  }

  Widget boxElement(var screenHeight, var screenWidth,String assetPath ,String title,String text ,BuildContext context,Widget page){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12),
      child: Container(
        width: double.infinity, // Adjust according to your requirements
        height: screenHeight/7.5, // Adjust according to your requirements
        decoration: BoxDecoration(
          color: Colors.white, // Container background color
          borderRadius: BorderRadius.circular(10), // Adjust according to your requirements
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10.0,
              spreadRadius: -5.0,
              offset: Offset(7.0, 7.0), // Right and bottom shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenWidth/2.9,
              height:  screenHeight/6,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('$assetPath'),
                ),
              ),
            ),
            SizedBox(width: screenWidth/18,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 33.0,
                    fontWeight: FontWeight.w700,
                    color: HexColor("318284"),
                  ),
                ),
                SizedBox(height: 1.0,),
                Text(
                  "$text",
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: "Roboto",
                      color: HexColor("656565")
                  ),
                ),
                SizedBox(height: screenHeight/200,),
                Row(
                  children: [
                    SizedBox(width: screenWidth/3.3 ,),
                    InkWell(
                      onTap: (){
                        navigateToPage(context, page);
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Go",
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight:FontWeight.w700
                                ),
                              ),
                              SizedBox(width: screenWidth/150,),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                        height: 30,
                        width: 66,
                        decoration: BoxDecoration(
                            color: HexColor("00B5B9"),
                            borderRadius: BorderRadius.circular(20)
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
