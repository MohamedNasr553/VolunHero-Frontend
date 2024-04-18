import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/layout_bloc/states.dart';
import 'package:flutter_code/modules/CreatePost/CreatePost_Page.dart';
import 'package:flutter_code/modules/GetSupport/Support_Page.dart';
import 'package:flutter_code/modules/HomePage/homePage.dart';
import 'package:flutter_code/modules/Notifications/Notifications_Page.dart';
import 'package:flutter_code/modules/RoadBlocks/Roadblocks.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeLayoutCubit extends Cubit<LayoutStates> {
  HomeLayoutCubit() : super(LayoutInitialState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isActive = false;

  List<BottomNavigationBarItem> bottomItems = [];

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

  Widget changeBottomIcon(int index, Widget a, Widget b) {
    emit(ChangeBottomIconColor());
    if (currentIndex == index) {
      return a;
    }
    return b;
  }

  void initializeBottomItems() {
    bottomItems = [
      BottomNavigationBarItem(
        icon: changeBottomIcon(
            0,
            SvgPicture.asset("assets/images/Home_fill_colored.svg"),
            SvgPicture.asset("assets/images/Home_fill.svg")),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: changeBottomIcon(
            1,
            SvgPicture.asset("assets/images/Phone_fill.svg"),
            SvgPicture.asset("assets/images/supportIcon.svg")),
        label: 'Support',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.add_box),
        label: 'Post',
      ),
      BottomNavigationBarItem(
        icon: changeBottomIcon(
            3,
            SvgPicture.asset("assets/images/Bell_fill_colored.svg"),
            SvgPicture.asset("assets/images/Bell_fill.svg")),
        label: 'Notifications',
      ),
      BottomNavigationBarItem(
        icon: changeBottomIcon(
            4,
            SvgPicture.asset("assets/images/View_alt_fill_activated.svg"),
            SvgPicture.asset("assets/images/View_alt_fill.svg")),
        label: 'RoadBlocks',
      ),
    ];
  }

  // void toggleRoadBlocks() {
  //   isActive = !isActive;
  //   // print('isActive: $isActive');
  //   emit(ToggleRoadBlocksState());
  // }

  var layoutScreens = [
    HomePage(),
    const GetSupport(),
    CreatePost(),
    NotificationPage(),
    const RoadBlocksPage()
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    initializeBottomItems();
    emit(ChangeBottomNavBarState());
  }
}
