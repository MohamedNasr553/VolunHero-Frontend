import 'package:flutter/material.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
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
        borderRadius: BorderRadius.circular(
          radius,
        ),
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
  IconData? prefix,
  IconData? suffix,
  double hintSize = 14.0,
  double labelSize = 14.0,
  double radius = 3.0,
  Color iconColor = Colors.black,
  Color borderColor = Colors.grey,
  VoidCallback? suffixPressed,
  Color textFieldColor = Colors.black,
}) {
  return TextFormField(
    controller: controller,
    validator: validate,
    style: const TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
    ),
    obscureText: isPassword,
    decoration: InputDecoration(
      prefixIcon: Icon(
        prefix,
        color: iconColor,
      ),
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.grey,
        fontSize: labelSize,
        fontWeight: FontWeight.w300,
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: hintSize,
        color: Colors.grey.shade500,
      ),
      fillColor: Colors.white,
      filled: true,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(
          color: borderColor,
          width: 0.5,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(
          color: borderColor,
          width: 0.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(
          color: borderColor,
          width: 0.5,
        ),
      ),
      // Add suffix icon conditionally based on isPassword
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
}) =>
    TextFormField(
      cursorColor: defaultColor,
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
          fontSize: 14.0,
          color: Colors.grey.shade500,
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
      height: 1.0,
      color: HexColor("039FA2"),
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

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
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
