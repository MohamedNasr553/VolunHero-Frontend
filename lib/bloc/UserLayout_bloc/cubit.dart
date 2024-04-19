import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/states.dart';
import 'package:flutter_code/modules/GeneralView/CreatePost/CreatePost_Page.dart';
import 'package:flutter_code/modules/UserView/GetSupport/Support_Page.dart';
import 'package:flutter_code/modules/UserView/RoadBlocks/Roadblocks.dart';
import 'package:flutter_code/modules/UserView/UserHomePage/User_Home_Page.dart';
import 'package:flutter_code/modules/UserView/UserNotifications/User_Notifications_Page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeLayoutCubit extends Cubit<LayoutStates> {
  HomeLayoutCubit() : super(LayoutInitialState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isActive = false;

  List<BottomNavigationBarItem> bottomItems = [];
  List<Widget> layoutScreens = [];

  Widget activatedSvg = SvgPicture.asset(
    'assets/images/View_alt_fill_activated.svg',
    width: 25.0,
    height: 25.0,
    fit: BoxFit.cover,
  );

  Widget deactivatedSvg = SvgPicture.asset(
    'assets/images/View_alt_fill.svg',
    width: 25.0,
    height: 25.0,
    fit: BoxFit.cover,
  );

  // ------ NADER -----------
  // Widget changeBottomIcon(int index, Widget a, Widget b) {
  //   emit(ChangeBottomIconColor());
  //   if (currentIndex == index) {
  //     return a;
  //   }
  //   return b;
  // }

  // void initializeBottomItems() {
  //   bottomItems = [
  //     BottomNavigationBarItem(
  //       icon: changeBottomIcon(
  //           0,
  //           SvgPicture.asset("assets/images/Home_fill_colored.svg"),
  //           SvgPicture.asset("assets/images/Home_fill.svg")),
  //       label: 'Home',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: changeBottomIcon(
  //           1,
  //           SvgPicture.asset("assets/images/Phone_fill.svg"),
  //           SvgPicture.asset("assets/images/supportIcon.svg")),
  //       label: 'Support',
  //     ),
  //     const BottomNavigationBarItem(
  //       icon: Icon(Icons.add_box),
  //       label: 'Post',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: changeBottomIcon(
  //           3,
  //           SvgPicture.asset("assets/images/Bell_fill_colored.svg"),
  //           SvgPicture.asset("assets/images/Bell_fill.svg")),
  //       label: 'UserNotifications',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: changeBottomIcon(
  //           4,
  //           SvgPicture.asset("assets/images/View_alt_fill_activated.svg"),
  //           SvgPicture.asset("assets/images/View_alt_fill.svg")),
  //       label: 'RoadBlocks',
  //     ),
  //   ];
  // }

  // ------ NASR -----------
  void initializeBottomItems() {
    bottomItems = [
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.home_filled,
        ),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.local_phone_outlined,
        ),
        label: 'Support',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.add_box_rounded,
        ),
        label: 'Post',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.notifications,
        ),
        label: 'Notifications',
      ),
      BottomNavigationBarItem(
        icon: isActive ? activatedSvg : deactivatedSvg,
        label: 'RoadBlocks',
      ),
    ];
  }

  void homeLayoutScreens() {
    layoutScreens = [
      const UserHomePage(),
      const GetSupport(),
      CreatePost(),
      UserNotificationPage(),
      const RoadBlocksPage()
    ];
  }

  void changeBottomNavBar(int index) {
    currentIndex = index;
    initializeBottomItems();
    emit(ChangeBottomNavBarState());
  }
}
