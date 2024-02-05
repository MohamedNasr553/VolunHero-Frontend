import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_code/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
    primaryColor: defaultColor,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Poppins',

    appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: defaultColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
      ),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color.fromARGB(255, 3, 159, 162),
      unselectedItemColor: Colors.grey,
      // elevation: 20.0,
      backgroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
);
