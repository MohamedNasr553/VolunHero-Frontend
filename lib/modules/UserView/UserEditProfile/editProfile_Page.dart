import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/modules/UserView/UserProfilePage/Profile_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/components/constants.dart';
import 'package:flutter_code/shared/network/local/CacheHelper.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../bloc/Login_bloc/cubit.dart';

class UserEditProfile extends StatelessWidget {
  UserEditProfile({super.key});

  var formKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var userNameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<UserLoginCubit, UserLoginStates>(
      listener: (context, state) {
        if (state is UpdateLoggedInUserSuccessState) {
          // Save User Token
          CacheHelper.saveData(
            key: "token",
            value: userToken,
          ).then((value) {
            navigateAndFinish(context, const ProfilePage());
          });
          showToast(
            text: "Profile Updated Successfully",
            state: ToastStates.SUCCESS,
          );
        }
        if (state is UpdateLoggedInUserErrorState) {
          showToast(
            text: "Something went wrong",
            state: ToastStates.ERROR,
          );
        }
      },
      builder: (context, state) {
        Map<String, dynamic> oldData = {
          "firstName": UserLoginCubit.get(context).loggedInUser!.firstName,
          "lastName": UserLoginCubit.get(context).loggedInUser!.lastName,
          "userName": UserLoginCubit.get(context).loggedInUser!.userName,
          "phone": UserLoginCubit.get(context).loggedInUser!.phone,
          "address": UserLoginCubit.get(context).loggedInUser!.address,
        };

        print("Old data: $oldData");

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
                                fontWeight: FontWeight.w300,
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
                              oldData["firstName"] =
                                  (firstNameController.text.trim() != "")
                                      ? firstNameController.text
                                      : UserLoginCubit.get(context)
                                          .loggedInUser!
                                          .firstName;
                              oldData["lastName"] =
                                  (lastNameController.text.trim() != "")
                                      ? lastNameController.text
                                      : UserLoginCubit.get(context)
                                          .loggedInUser!
                                          .lastName;
                              oldData["userName"] =
                                  (userNameController.text.trim() != "")
                                      ? userNameController.text
                                      : UserLoginCubit.get(context)
                                          .loggedInUser!
                                          .userName;
                              oldData["phone"] =
                                  (phoneController.text.trim() != "")
                                      ? phoneController.text
                                      : UserLoginCubit.get(context)
                                          .loggedInUser!
                                          .phone;
                              oldData["address"] =
                                  (addressController.text.trim() != "")
                                      ? addressController.text
                                      : UserLoginCubit.get(context)
                                          .loggedInUser!
                                          .address;

                              UserLoginCubit.get(context)
                                  .updateLoggedInUserData(
                                token: userToken ?? "",
                                firstName: oldData["firstName"],
                                lastName: oldData["lastName"],
                                userName: oldData["userName"],
                                phone: oldData["phone"],
                                address: oldData["address"],
                              )
                                  .then((value) {
                                print('Updated Data: $oldData');
                              });
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
