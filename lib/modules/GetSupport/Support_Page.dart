import 'package:flutter/material.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:stroke_text/stroke_text.dart';

class GetSupport extends StatelessWidget {
  const GetSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              radius: 50.0,
              child: ClipOval(
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 7,),
          Column(
            children: [
              StrokeText(
                text: "Support calls",
                textStyle: TextStyle(
                  letterSpacing: 0.5,
                  fontSize: 35.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: "Roboto"
                ),
                strokeWidth: 0.5,
                strokeColor: Colors.black,
              ),
              SizedBox(height: 1.0,),
              StrokeText(
                text: "For easy communication",
                textStyle: TextStyle(
                  letterSpacing: 0.5,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                    fontFamily: "Roboto"
                ),
                strokeWidth: 0.3,
                strokeColor: Colors.black,
              ),
            ],
          ),
          SizedBox(height: 28,),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                StrokeText(
                  text: "Choose your needed category",
                  textStyle: TextStyle(
                      letterSpacing: 0.5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontFamily: "Roboto"
                  ),
                  strokeWidth: 0.5,
                  strokeColor: Colors.black,
                ),
              ],
            ),
          ),
          SizedBox(height: 22,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  showToast(text: "text", state: ToastStates.ERROR);
                },
                child:Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/Rectangle 4178.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Center(
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
                )
              ),
              SizedBox(height: 30,),
              InkWell(
                  onTap: (){
                    showToast(text: "text", state: ToastStates.ERROR);
                  },
                  child:Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/Rectangle 4178.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
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
                  )
              ),
              SizedBox(height: 30,),
              InkWell(
                  onTap: (){
                    showToast(text: "text", state: ToastStates.ERROR);
                  },
                  child:Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/Rectangle 4178.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
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
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}
