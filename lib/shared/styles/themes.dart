import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_code/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
    primaryColor: defaultColor,
    scaffoldBackgroundColor: Colors.grey.shade100,
    fontFamily: 'Poppins',

    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      centerTitle: true,
      backgroundColor: Colors.grey.shade100,
      elevation: 0.0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: defaultColor,
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color.fromARGB(255, 3, 159, 162),
      unselectedItemColor: Colors.grey,
      // elevation: 20.0,
      backgroundColor: Colors.grey.shade100,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
);
