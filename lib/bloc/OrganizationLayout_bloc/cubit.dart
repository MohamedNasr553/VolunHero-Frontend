import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/OrganizationLayout_bloc/states.dart';
import 'package:flutter_code/modules/GeneralView/CreatePost/CreatePost_Page.dart';
import 'package:flutter_code/modules/GeneralView/GetSupport/Support_Page.dart';
import 'package:flutter_code/modules/GeneralView/HomePage/Home_Page.dart';
import 'package:flutter_code/modules/GeneralView/Notifications/Notifications_Page.dart';
import 'package:flutter_code/modules/OrganizationView/AddDonationForm/AddDonationForm.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrganizationLayoutCubit extends Cubit<OrganizationLayoutStates> {
  OrganizationLayoutCubit() : super(OrgLayoutInitialState());

  static OrganizationLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isActive = false;

  List<BottomNavigationBarItem> bottomItems = [];

  Widget changeBottomIcon(int index, Widget a, Widget b) {
    emit(OrgChangeBottomIconColor());
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
          SvgPicture.asset(
            "assets/images/Home_fill_colored.svg",
            width: 25.0,
            height: 25.0,
          ),
          SvgPicture.asset(
            "assets/images/Home_fill.svg",
            width: 25.0,
            height: 25.0,
          ),
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: changeBottomIcon(
            1,
            SvgPicture.asset(
              "assets/images/Phone_fill.svg",
              width: 25.0,
              height: 25.0,
            ),
            SvgPicture.asset(
              "assets/images/supportIcon.svg",
              width: 25.0,
              height: 25.0,
            )),
        label: 'Support',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.add_box_rounded,
        ),
        label: 'Post',
      ),
      BottomNavigationBarItem(
        icon: changeBottomIcon(
            3,
            SvgPicture.asset(
              "assets/images/Bell_fill_colored.svg",
              width: 25.0,
              height: 25.0,
            ),
            SvgPicture.asset(
              "assets/images/Bell_fill.svg",
              width: 25.0,
              height: 25.0,
            )),
        label: 'Notifications',
      ),
      BottomNavigationBarItem(
        icon: changeBottomIcon(
            4,
            SvgPicture.asset(
              "assets/images/AddDonationFormActivated.svg",
              width: 20.0,
              height: 20.0,
            ),
            SvgPicture.asset(
              "assets/images/AddDonationFormLogo.svg",
              width: 25.0,
              height: 25.0,
            )),
        label: 'Donation Form',
      ),
    ];
  }

  var layoutScreens = [
    const HomePage(),
    const GetSupport(),
    CreatePost(),
    NotificationPage(),
    const AddDonationForm()
  ];

  void orgChangeBottomNavBar(int index) {
    currentIndex = index;
    initializeBottomItems();
    emit(OrgHomeChangeBottomNavBarState());
  }
}
