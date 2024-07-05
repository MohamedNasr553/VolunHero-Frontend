import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/modules/GeneralView/ProfilePage/Profile_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../bloc/Login_bloc/cubit.dart';

class UserEditProfile extends StatefulWidget {
  UserEditProfile({super.key});

  @override
  State<UserEditProfile> createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = UserLoginCubit.get(context).loggedInUser;
    if (user != null) {
      firstNameController.text = user.firstName;
      lastNameController.text = user.lastName;
      phoneController.text = user.phone;
      addressController.text = user.address;
      userNameController.text = user.userName;
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<UserLoginCubit, UserLoginStates>(
      listener: (context, state) {
        if (state is UpdateLoggedInUserSuccessState) {
          // Save User Token
          // CacheHelper.saveData(
          //   key: "token",
          //   value: userToken ?? "",
          // ).then((value) {
          //   navigateAndFinish(context, const ProfilePage());
          // });
          // showToast(
          //   text: "Profile Updated Successfully",
          //   state: ToastStates.SUCCESS,
          // );
        }
        if (state is UpdateLoggedInUserErrorState) {
          showToast(
            text: "Something went wrong",
            state: ToastStates.ERROR,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                SizedBox(
                  height: screenHeight / 2.93,
                  child: SvgPicture.asset(
                    "assets/images/Vector 405.svg",
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: screenHeight / 15,
                  ),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/arrow_left_white.svg',
                    ),
                    onPressed: () {
                      navigateAndFinish(context, const ProfilePage());
                    },
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
                  padding: EdgeInsets.fromLTRB(
                      screenWidth / 20, screenHeight / 15, screenWidth / 17, 0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.fromLTRB(0, screenHeight / 6, 20, 0),
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
                          validate: (value) {
                            return null;
                          },
                          controller: firstNameController,
                          type: TextInputType.text,
                          hintText: UserLoginCubit.get(context)
                              .loggedInUser!
                              .firstName,
                        ),
                        SizedBox(height: screenHeight / 30),
                        const Text(
                          "Last Name",
                          style: TextStyle(
                            color: defaultColor,
                            fontWeight: FontWeight.w200,
                            fontSize: 14.0,
                          ),
                        ),
                        updateProfileTextFormField(
                          validate: (value) {
                            return null;
                          },
                          controller: lastNameController,
                          type: TextInputType.text,
                          hintText: UserLoginCubit.get(context)
                              .loggedInUser!
                              .lastName,
                        ),
                        SizedBox(height: screenHeight / 30),
                        Row(
                          children: [
                            const Text(
                              "Username",
                              style: TextStyle(
                                color: defaultColor,
                                fontWeight: FontWeight.w200,
                                fontSize: 14.0,
                              ),
                            ),
                            SizedBox(width: screenWidth / 50),
                            const Text(
                              "*Read only",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w800,
                                fontSize: 8.0,
                              ),
                            ),
                          ],
                        ),
                        updateProfileTextFormField(
                          validate: (value) {
                            return null;
                          },
                          readonly: true,
                          controller: userNameController,
                          type: TextInputType.text,
                          hintText: UserLoginCubit.get(context)
                              .loggedInUser!
                              .userName,
                        ),
                        SizedBox(height: screenHeight / 30),
                        const Text(
                          "Phone Number",
                          style: TextStyle(
                            color: defaultColor,
                            fontWeight: FontWeight.w200,
                            fontSize: 14.0,
                          ),
                        ),
                        updateProfileTextFormField(
                          validate: (value) {
                            return null;
                          },
                          controller: phoneController,
                          type: TextInputType.phone,
                          hintText:
                              UserLoginCubit.get(context).loggedInUser!.phone,
                        ),
                        SizedBox(height: screenHeight / 30),
                        const Text(
                          "Address",
                          style: TextStyle(
                            color: defaultColor,
                            fontWeight: FontWeight.w200,
                            fontSize: 14.0,
                          ),
                        ),
                        updateProfileTextFormField(
                          validate: (value) {
                            return null;
                          },
                          controller: addressController,
                          type: TextInputType.streetAddress,
                          hintText:
                              UserLoginCubit.get(context).loggedInUser!.address,
                        ),
                        SizedBox(height: screenHeight / 15),
                        defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              UserLoginCubit.get(context)
                                  .updateLoggedInUserData(
                                token: UserLoginCubit.get(context)
                                        .loginModel!
                                        .refresh_token ??
                                    "",
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                phone: phoneController.text,
                                address: addressController.text,
                              );
                              navigateAndFinish(context, const ProfilePage());
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
          ),
        );
      },
    );
  }
}
