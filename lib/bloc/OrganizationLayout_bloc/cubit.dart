import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/OrganizationLayout_bloc/states.dart';
import 'package:flutter_code/modules/GeneralView/CreatePost/CreatePost_Page.dart';
import 'package:flutter_code/modules/GeneralView/GetSupport/Support_Page.dart';
import 'package:flutter_code/modules/OrganizationView/AddDonationForm/AddDonationForm.dart';
import 'package:flutter_code/modules/OrganizationView/OrganizationHomePage/organizationHomePage.dart';
import 'package:flutter_code/modules/OrganizationView/OrganizationNotifications/Organization_Notifications_Page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeOrganizationLayoutCubit extends Cubit<OrganizationLayoutStates> {
  HomeOrganizationLayoutCubit() : super(OrganizationLayoutInitialState());

  static HomeOrganizationLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isActive = false;

  List<BottomNavigationBarItem> bottomItems = [];
  List<Widget> layoutScreens = [];

  Widget activatedSvg = SvgPicture.asset(
    'assets/images/AddDonationFormActivated.svg',
    width: 25.0,
    height: 25.0,
    fit: BoxFit.cover,
  );

  Widget deactivatedSvg = SvgPicture.asset(
    'assets/images/AddDonationFormLogo.svg',
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
        label: 'Donation Form',
      ),
    ];
  }

  void homeLayoutScreens() {
    layoutScreens = [
      const OrganizationHomePage(),
      const GetSupport(),
      CreatePost(),
      OrganizationNotificationPage(),
      const AddDonationForm(),
    ];
  }

  void changeBottomNavBar(int index) {
    currentIndex = index;
    initializeBottomItems();
    emit(OrganizationHomeChangeBottomNavBarState());
  }
}
