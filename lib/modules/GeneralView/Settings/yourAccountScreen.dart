import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/states.dart';
import 'package:flutter_code/modules/GeneralView/Settings/settingsPage.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stroke_text/stroke_text.dart';

class YourAccountPage extends StatelessWidget {
  const YourAccountPage({super.key});

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
                    navigateAndFinish(context, const SettingsPage());
                  },
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StrokeText(
                      text: "Your Account",
                      textStyle: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                        color:HexColor("296E6F"),
                      ),
                      strokeWidth: 1.0,
                      strokeColor: Colors.white,
                    ),
                    Text(
                      "See more details about your account security",
                      style: TextStyle(
                          color: HexColor("656565"),
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                          fontSize: 10
                      ),
                    ),
                  ],
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 42.0),
                  child: Column(
                    children: [
                      // assets/images/lock.svg
                      buttonComponent(screenWidth, screenHeight, "assets/images/lock.svg", "Update Password"),
                      SizedBox(height: screenHeight/50,),
                      InkWell(
                        onTap: (){},
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(Icons.email_outlined,color: HexColor("039FA2"),),
                                SizedBox(width: screenWidth/50,),
                                const Text(
                                  "Change Email",
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                const Spacer(),
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
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/images/delete_account.svg"),
                                SizedBox(width: screenWidth/50,),
                                Text(
                                  "Delete Account",
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      color: HexColor("E92727"),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                 
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
  Widget buttonComponent(var screenWidth,var screenHeight, String iconAsset,String text){
    return InkWell(
      onTap: (){},
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              SvgPicture.asset(iconAsset),
              SizedBox(width: screenWidth/50,),
              Text(
                text,
                style: const TextStyle(
                    fontFamily: "Roboto",
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
              const Spacer(),
              SvgPicture.asset("assets/images/Expand_right.svg"),
            ],
          ),
        ),
      ),
    );
  }
}
