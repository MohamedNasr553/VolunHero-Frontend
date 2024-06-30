import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/bloc/Settings_bloc/cubit.dart';
import 'package:flutter_code/bloc/Settings_bloc/states.dart';
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

    return BlocConsumer<UserLoginCubit, UserLoginStates>(
      listener: (context, state) { },
      builder: (context, state) {
        return BlocConsumer<SettingsCubit, SettingsStates>(
          listener: (context, state) {
            if(state is UpdatePasswordSuccessState){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: defaultColor,
                  content: Text(
                    'Password Changed Successfully',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
              );
              navigateToPage(context, const AccountInformationPage());
            }
            else if(state is UpdatePasswordErrorState){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    "Invalid Current Password",
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
              );
            }
          },
          builder: (context, states) {
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
                          child: TextFormField(
                            obscureText:
                            (UserLoginCubit.get(context).isPassword)
                                ? true
                                : false,
                            controller: currentPasswordController,
                            validator: (value) {
                              return null;
                            },
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w300,
                              ),
                              hintText: 'At least 8 characters',
                              hintStyle: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey.shade500,
                              ),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 1.0,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  size: 20.0,
                                  UserLoginCubit.get(context).suffix,
                                ),
                                onPressed: () {
                                  UserLoginCubit.get(context)
                                      .changeVisibility();
                                },
                              ),
                            ),
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
                          padding: EdgeInsetsDirectional.only(
                            end: screenWidth / 15,
                          ),
                          child: TextFormField(
                            obscureText:
                            (UserLoginCubit.get(context).isPassword)
                                ? true
                                : false,
                            controller: newPasswordController,
                            validator: (value) {
                              return null;
                            },
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w300,
                              ),
                              hintText: 'At least 8 characters',
                              hintStyle: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey.shade500,
                              ),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 1.0,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  size: 20.0,
                                  UserLoginCubit.get(context).suffix,
                                ),
                                onPressed: () {
                                  UserLoginCubit.get(context)
                                      .changeVisibility();
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight / 15),
                        Padding(
                          padding: EdgeInsetsDirectional.only(end: screenWidth / 18),
                          child: defaultButton(
                            isUpperCase: false,
                            function: () {
                              SettingsCubit.get(context).updateUserPassword(
                                currentPassword: currentPasswordController.text,
                                newPassword: newPasswordController.text,
                                token: UserLoginCubit.get(context).loginModel!.refresh_token ?? "",
                              );

                            },
                            text: 'Save',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
