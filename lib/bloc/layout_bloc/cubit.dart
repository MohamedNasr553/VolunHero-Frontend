import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/layout_bloc/states.dart';
import 'package:flutter_code/modules/CreatePosts/Posts.dart';
import 'package:flutter_code/modules/GetSupport/Support_Page.dart';
import 'package:flutter_code/modules/HomePage/homePage.dart';
import 'package:flutter_code/modules/Notifications/Notifications_Page.dart';
import 'package:flutter_code/modules/RoadBlocks/Roadblocks.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeLayoutCubit extends Cubit<LayoutStates>{
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

  // void toggleRoadBlocks() {
  //   isActive = !isActive;
  //   // print('isActive: $isActive');
  //   emit(ToggleRoadBlocksState());
  // }

  void homeLayoutScreens() {
    layoutScreens = [
      HomePage(),
      const GetSupport(),
      const CreatePosts(),
      NotificationPage(),
      const RoadBlocksPage()
    ];
  }

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }
}
