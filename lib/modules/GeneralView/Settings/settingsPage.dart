import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/states.dart';
import 'package:flutter_code/modules/GeneralView/Settings/yourAccountScreen.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/src/mainScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
      return BlocConsumer<HomeLayoutCubit,LayoutStates>(
          listener:(context,state){} ,
          builder: (context,state){
          var cubit = HomeLayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: SvgPicture.asset("assets/images/arrowLeft.svg"),
                onPressed: (){
                  cubit.changeBottomNavBar(0);
                  navigateAndFinish(context, MainScreen());
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 8.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/images/Setting_line.svg"),
                        SizedBox(width: screenWidth/20,),
                        Text(
                          "Settings",
                          style: TextStyle(
                              fontFamily: "Roboto",
                              color:  HexColor("296E6F"),
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: screenHeight/50,),
                    Text(
                        "Account",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                    ),
                    Text(
                        "Update your info to keep track your account",
                      style: TextStyle(
                        color: HexColor("656565"),
                        fontFamily: "Roboto",
                        fontSize: 12
                      ),
                    ),
                    SizedBox(height: screenHeight/50,),
                    buttonComponent( screenWidth, screenHeight, "assets/images/profile.svg", "Account information",YourAccountPage(),context),
                    SizedBox(height: screenHeight/50,),
                    buttonComponent( screenWidth, screenHeight, "assets/images/Bell_fill_colored.svg", "UserNotifications",MainScreen(),context),
                    SizedBox(height: screenHeight/20,),
                    Text(
                      "Privacy",
                      style: TextStyle(
                          fontFamily: "Roboto",
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "Customize your privacy to make experience better",
                      style: TextStyle(
                          color: HexColor("656565"),
                          fontFamily: "Roboto",
                          fontSize: 12
                      ),
                    ),
                    SizedBox(height: screenHeight/50,),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.security,
                                color: HexColor("039FA2"),
                              ),
                              SizedBox(width: screenWidth/50,),
                              Text(
                                "Sign in & security",
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Spacer(),
                              SvgPicture.asset("assets/images/Expand_right.svg"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight/50,),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.help_outline_outlined,
                                color: HexColor("039FA2"),
                              ),
                              SizedBox(width: screenWidth/50,),
                              Text(
                                "Help and support",
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Spacer(),
                              SvgPicture.asset("assets/images/Expand_right.svg"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight/50,),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                             SvgPicture.asset("assets/images/arcticons_score-sheets.svg"),
                              SizedBox(width: screenWidth/50,),
                              Text(
                                "Terms of Services",
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Spacer(),
                              SvgPicture.asset("assets/images/Expand_right.svg"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight/50,),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.exit_to_app_outlined,color: HexColor("039FA2"),),
                              SizedBox(width: screenWidth/50,),
                              Text(
                                "Log out",
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Spacer(),
                              SvgPicture.asset("assets/images/Expand_right.svg"),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
      }
    );
  }

  Widget buttonComponent(var screenWidth,var screenHeight, String iconAsset,String text,Widget page,context){
    var cubit = HomeLayoutCubit.get(context);
    return InkWell(
      onTap: (){
        if(text=="UserNotifications"){
          cubit.changeBottomNavBar(3);
        }
        navigateToPage(context, page);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              SvgPicture.asset("$iconAsset"),
              SizedBox(width: screenWidth/50,),
              Text(
                "$text",
                style: TextStyle(
                    fontFamily: "Roboto",
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
              Spacer(),
              SvgPicture.asset("assets/images/Expand_right.svg"),
            ],
          ),
        ),
      ),
    );
  }
}
