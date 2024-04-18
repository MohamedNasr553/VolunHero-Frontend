import 'package:flutter/material.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserEditProfile extends StatelessWidget {
  UserEditProfile({super.key});

  var formKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          SizedBox(
            height: screenHeight / 3.0,
            child: SvgPicture.asset(
              "assets/images/Vector 405.svg",
              width: double.infinity,
              alignment: Alignment.topLeft,
              fit: BoxFit.fitHeight,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: screenHeight / 15,),
            child: IconButton(
              onPressed: (){

              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 23,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: screenWidth / 20,
              top: screenHeight / 7,
            ),
            child: const Text(
              "Edit Profile",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
                fontSize: 27.0,
              ),
            ),
          ),
          SizedBox(
            height: screenHeight / 1.0,
            child: SvgPicture.asset(
              "assets/images/Vector 404.svg",
              width: double.infinity,
              alignment: Alignment.bottomLeft,
              // fit: BoxFit.fitHeight,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(screenWidth / 20, screenHeight / 15, screenWidth / 17, 0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, screenHeight / 6, 20, 0),
                  ),
                  Text(
                    "First Name",
                    style: TextStyle(
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.w200,
                      fontSize: 14.0,
                    ),
                  ),
                  updateProfileTextFormField(
                    validate: (value){
                      if(value!.isEmpty){
                        return 'First name is required';
                      }
                      return null;
                    },
                    controller: firstNameController,
                    type: TextInputType.text,
                    hintText: 'Test',
                  ),
                  SizedBox(height: screenHeight / 30,),
                  const Text(
                    "Last Name",
                    style: TextStyle(
                      color: defaultColor,
                      fontWeight: FontWeight.w200,
                      fontSize: 14.0,
                    ),
                  ),
                  updateProfileTextFormField(
                    validate: (value){
                      if(value!.isEmpty){
                        return 'Last name is required';
                      }
                      return null;
                    },
                    controller: lastNameController,
                    type: TextInputType.text,
                    hintText: 'Test',
                  ),
                  SizedBox(height: screenHeight / 30,),
                  const Text(
                    "Phone Number",
                    style: TextStyle(
                      color: defaultColor,
                      fontWeight: FontWeight.w200,
                      fontSize: 14.0,
                    ),
                  ),
                  updateProfileTextFormField(
                    validate: (value){
                      if(value!.isEmpty){
                        return 'Phone number must not be empty';
                      }
                      return null;
                    },
                    controller: lastNameController,
                    type: TextInputType.phone,
                    hintText: '+02 01125687415',
                  ),
                  SizedBox(height: screenHeight / 30,),
                  const Text(
                    "Location",
                    style: TextStyle(
                      color: defaultColor,
                      fontWeight: FontWeight.w200,
                      fontSize: 14.0,
                    ),
                  ),
                  updateProfileTextFormField(
                    validate: (value){
                      if(value!.isEmpty){
                        return 'Location must not be empty';
                      }
                      return null;
                    },
                    controller: locationController,
                    type: TextInputType.streetAddress,
                    hintText: 'New Cairo',
                  ),
                  SizedBox(height: screenHeight / 10,),
                  defaultButton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        showToast(
                          text: "Profile Updated Successfully",
                          state: ToastStates.SUCCESS,
                        );
                      }
                    },
                    text: 'Save',
                    isUpperCase: false,
                    fontWeight: FontWeight.w300,
                    width: screenWidth / 1.1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
