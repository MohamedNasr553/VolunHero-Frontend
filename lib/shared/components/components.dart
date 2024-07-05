import 'package:flutter/material.dart';
import 'package:flutter_code/bloc/DonationForm_bloc/cubit.dart';
import 'package:flutter_code/bloc/Layout_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/layout/VolunHeroLayout/layout.dart';
import 'package:flutter_code/models/AddDonationFormModel.dart';
import 'package:flutter_code/models/getUsersSupportCalls.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

Widget defaultButton({
  double width = double.infinity,
  Color color = defaultColor,
  double height = 64.0,
  double radius = 50.0,
  bool isUpperCase = true,
  FontWeight fontWeight = FontWeight.normal,
  double fontSize = 18.0,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
        ),
      ),
    );

Widget defaultTextFormField({
  bool isPassword = false,
  ValueChanged<String>? onChange,
  VoidCallback? onTap,
  ValueChanged<String>? onFieldSubmitted,
  required String? Function(String?) validate,
  required TextEditingController controller,
  required TextInputType type,
  String? labelText,
  required String hintText,
  IconData? suffix,
  double hintSize = 11.0,
  double radius = 4.0,
  Color borderColor = Colors.grey,
  VoidCallback? suffixPressed,
  Color textFieldColor = Colors.black,
  double width = 20.0,
  double height = 10.0,
  double outlineBorderWidth = 0.5,
  Color fillColor = Colors.white,
  Color hintColor = Colors.grey,
  bool readonly = false,
}) {
  return TextFormField(
    onTap: onTap,
    textAlignVertical: TextAlignVertical.top,
    controller: controller,
    validator: validate,
    style: const TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
    ),
    readOnly: readonly,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 12.0,
        fontWeight: FontWeight.w300,
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: hintSize,
        color: Colors.grey.shade500,
      ),
      fillColor: fillColor,
      filled: true,
      contentPadding: EdgeInsets.symmetric(vertical: height, horizontal: width),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(
          color: borderColor,
          width: outlineBorderWidth,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(
          color: borderColor,
          width: outlineBorderWidth,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(
          color: borderColor,
          width: outlineBorderWidth,
        ),
      ),
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                isPassword ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: suffixPressed,
            )
          : null,
    ),
  );
}

Widget updateProfileTextFormField({
  ValueChanged<String>? onChange,
  VoidCallback? onTap,
  ValueChanged<String>? onFieldSubmitted,
  required String? Function(String?) validate,
  required TextEditingController controller,
  required TextInputType type,
  String? labelText,
  required String hintText,
  Color textFieldColor = Colors.black,
  bool readonly = false,
}) =>
    TextFormField(
      cursorColor: defaultColor,
      readOnly: readonly,
      style: TextStyle(
        fontSize: 15.0,
        color: textFieldColor.withOpacity(.6),
        fontWeight: FontWeight.w500,
      ),
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      validator: validate,
      onChanged: onChange,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 12.0,
          color: textFieldColor.withOpacity(0.5),
          fontWeight: FontWeight.w500,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 15.5,
          color: Colors.black.withOpacity(0.65),
          fontWeight: FontWeight.w500,
        ),
        focusColor: textFieldColor,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey, // Set your desired border color
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey, // Set your desired focused border color
          ),
        ),
      ),
    );

Widget separator() => Container(
      height: 0.5,
      color: Colors.grey.shade400,
    );

void navigateToPage(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateToURL({
  required String url,
}) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false, forceWebView: false);
  } else {
    throw 'Could not launch $url';
  }
}

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 14.0);

enum ToastStates {
  SUCCESS,
  ERROR,
  WARNING,
}

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = defaultColor;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

Widget buildLoadingWidget(int itemCount, context) {
  var screenHeight = MediaQuery.of(context).size.height;
  var screenWidth = MediaQuery.of(context).size.width;

  return SizedBox(
    height: screenHeight,
    child: ListView.builder(
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          period: const Duration(milliseconds: 1000),
          baseColor: Colors.grey,
          highlightColor: Colors.white30,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                    ),
                    SizedBox(
                      width: screenWidth / 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenHeight / 75,
                          width: screenWidth / 4,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: screenHeight / 75,
                          width: screenWidth / 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight / 100,
                ),
                Center(
                  child: SizedBox(
                    height: screenHeight / 4,
                    width: screenWidth,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget postSubComponent(String assetIcon, String action, context,
    {GestureTapCallback? onTap,
    Color color = const Color(0xFF575757),
    FontWeight fontWeight = FontWeight.w300}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        SvgPicture.asset(
          assetIcon,
          color: (HomeLayoutCubit.get(context).modifiedPost?.isLikedByMe == true)
              ? Colors.blue
              : color
        ),
        const SizedBox(width: 1),
        Text(
          action,
          style: TextStyle(
            fontSize: 12,
            fontFamily: "Roboto",
            color: color,
            fontWeight: fontWeight,
          ),
        )
      ],
    ),
  );
}

Widget buildSettingsItem(
    IconData? icon, String title, BuildContext context, Widget screen) {
  var screenHeight = MediaQuery.of(context).size.height;
  var screenWidth = MediaQuery.of(context).size.width;

  return InkWell(
    onTap: () => navigateToPage(context, screen),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          top: screenHeight / 120,
          bottom: screenHeight / 120,
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: screenWidth / 30,
                end: screenWidth / 30,
              ),
              child: Icon(
                icon,
                size: 25,
                color: HexColor("039FA2"),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: screenWidth / 80,
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: "Roboto",
                  color: Colors.black87,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsetsDirectional.only(
                end: screenWidth / 60,
              ),
              child: SvgPicture.asset("assets/images/Expand_right.svg"),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildSupportCallItem(
    SupportCallsUserDetails? supportCallsUserDetails, index, context) {
  var screenHeight = MediaQuery.of(context).size.height;
  var screenWidth = MediaQuery.of(context).size.width;

  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: screenWidth / 30, vertical: screenHeight / 100),
    child: Container(
      height: screenHeight / 11,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10.0,
            spreadRadius: -5.0,
            offset: const Offset(10.0, 5.0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: screenWidth / 70,
          end: screenWidth / 50,
        ),
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                InkWell(
                  onTap: () {
                  //   HomeLayoutCubit.get(context)
                  //       .getAnotherUserData(
                  //           token: UserLoginCubit.get(context)
                  //               .loginModel!
                  //               .refresh_token,
                  //           id: supportCallsUserDetails!.id)
                  //       .then((value) {
                  //     UserLoginCubit.get(context)
                  //         .getAnotherUserPosts(
                  //             token: UserLoginCubit.get(context)
                  //                 .loginModel!
                  //                 .refresh_token,
                  //             id: supportCallsUserDetails.id,
                  //             userName: supportCallsUserDetails.userName)
                  //         .then((value) {
                  //       UserLoginCubit.get(context).anotherUser =
                  //           HomeLayoutCubit.get(context).anotherUser;
                  //       navigateToPage(context, const AnotherUserProfile());
                  //     });
                  //   });
                  },
                  child: CircleAvatar(
                    radius: 28.0,
                    backgroundImage:
                        (supportCallsUserDetails?.profilePic?.secureUrl != null)
                            ? NetworkImage(supportCallsUserDetails!
                                .profilePic!.secureUrl) as ImageProvider
                            : const AssetImage("assets/images/nullProfile.png"),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    bottom: screenHeight / 300,
                    end: screenWidth / 150,
                  ),
                  child: const CircleAvatar(
                    radius: 6.0,
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(width: screenWidth / 20),
            InkWell(
              onTap: () {
                // HomeLayoutCubit.get(context)
                //     .getAnotherUserData(
                //         token: UserLoginCubit.get(context)
                //             .loginModel!
                //             .refresh_token,
                //         id: supportCallsUserDetails.id)
                //     .then((value) {
                //   UserLoginCubit.get(context)
                //       .getAnotherUserPosts(
                //           token: UserLoginCubit.get(context)
                //               .loginModel!
                //               .refresh_token,
                //           id: supportCallsUserDetails.id,
                //           userName: supportCallsUserDetails.userName)
                //       .then((value) {
                //     UserLoginCubit.get(context).anotherUser =
                //         HomeLayoutCubit.get(context).anotherUser;
                //     navigateToPage(context, const AnotherUserProfile());
                //   });
                // });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: screenHeight / 50,
                    ),
                    child: Text(
                      supportCallsUserDetails!.userName,
                      style: const TextStyle(
                          fontFamily: "Roboto",
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: screenHeight / 300),
                  Row(
                    children: [
                      Text(
                        supportCallsUserDetails.role,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 11.0,
                            color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            (supportCallsUserDetails.id ==
                    UserLoginCubit.get(context).loggedInUser!.id)
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      // Phone Here Waiting for Backend...
                      launchPhoneDialer(supportCallsUserDetails.phone);
                    },
                    icon: SvgPicture.asset('assets/images/Phone_fill.svg'),
                    color: HexColor("039FA2"),
                  ),
            (supportCallsUserDetails.id ==
                    UserLoginCubit.get(context).loggedInUser!.id)
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      navigateToURL(url: "https://app.zoom.us/wc");
                    },
                    icon: const Icon(
                      Icons.videocam,
                    ),
                    color: HexColor("039FA2"),
                  ),
          ],
        ),
      ),
    ),
  );
}

Future<void> launchPhoneDialer(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  if (await canLaunch(launchUri.toString())) {
    await launch(launchUri.toString());
  } else {
    throw 'Could not launch $phoneNumber';
  }
}
