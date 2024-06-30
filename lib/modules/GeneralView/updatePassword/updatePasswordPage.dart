import 'package:flutter/material.dart';
import 'package:flutter_code/modules/GeneralView/ForgetPassword/ForgetPassword_Page.dart';
import 'package:flutter_code/modules/GeneralView/accountInformation/accountInformationScreen.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stroke_text/stroke_text.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset("assets/images/arrowLeft.svg"),
          onPressed: () {
            navigateToPage(context, const AccountInformationPage());
          },
        ),
        title: StrokeText(
          text: "Update Password",
          textStyle: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w500,
            color: HexColor("296E6F"),
          ),
          strokeWidth: 1.0,
          strokeColor: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          start: screenWidth / 20,
          top: screenHeight / 30,
        ),
        child: Container(
          width: screenWidth / 1.1,
          height: screenHeight / 2.1,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: screenWidth / 18,
              top: screenHeight / 40,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current Password',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Roboto",
                  ),
                ),
                SizedBox(height: screenHeight / 50),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: screenWidth / 15,
                  ),
                  child: defaultTextFormField(
                    hintColor: Colors.black54,
                    fillColor: Colors.grey.shade100,
                    validate: (value){
                      return null;
                    },
                    controller: currentPasswordController,
                    type: TextInputType.text,
                    hintText: 'At least 8 characters',
                  ),
                ),
                SizedBox(height: screenHeight / 100),
                InkWell(
                  onTap: () => navigateToPage(context, ForgetPassword()),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: screenWidth / 1.68,
                    ),
                    child: const Text(
                      'Forget Password',
                      style: TextStyle(
                        fontSize: 9.0,
                        color: defaultColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight / 60),
                Padding(
                  padding: EdgeInsetsDirectional.only(end: screenWidth / 18),
                  child: Container(
                    height: 1.0,
                    color: Colors.grey.shade300,
                  ),
                ),
                SizedBox(height: screenHeight / 40),
                const Text(
                  'New Password',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Roboto",
                  ),
                ),
                SizedBox(height: screenHeight / 50),
                Padding(
                  padding: EdgeInsetsDirectional.only(end: screenWidth / 15),
                  child: defaultTextFormField(
                    hintColor: Colors.black54,
                    fillColor: Colors.grey.shade100,
                    validate: (value){
                      return null;
                    },
                    controller: newPasswordController,
                    type: TextInputType.text,
                    hintText: 'At least 8 characters',
                  ),
                ),
                SizedBox(height: screenHeight / 15),
                Padding(
                  padding: EdgeInsetsDirectional.only(end: screenWidth / 18),
                  child: defaultButton(
                    isUpperCase: false,
                    function: (){},
                    text: 'Save',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
