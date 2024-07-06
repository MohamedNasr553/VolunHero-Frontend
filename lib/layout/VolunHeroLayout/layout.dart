import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Layout_bloc/cubit.dart';
import 'package:flutter_code/bloc/Layout_bloc/states.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/models/ChatsModel.dart';
import 'package:flutter_code/shared/styles/colors.dart';

class VolunHeroLayout extends StatelessWidget {
  const VolunHeroLayout({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<UserLoginCubit, UserLoginStates>(
          listener: (context, state) {},
          builder: (context, state) {

            return Scaffold(
              body: (UserLoginCubit.get(context).loggedInUser?.role ==
                      "Organization")
                  ? HomeLayoutCubit.get(context).layoutOrganizationScreens[
                      HomeLayoutCubit.get(context).currentIndex]
                  : HomeLayoutCubit.get(context).layoutUserScreens[
                      HomeLayoutCubit.get(context).currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                iconSize: 25.0,
                selectedLabelStyle: const TextStyle(
                  fontSize: 8.0,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 8.0,
                  fontWeight: FontWeight.bold,
                ),
                selectedItemColor: defaultColor,
                unselectedItemColor: Colors.black54,
                currentIndex: HomeLayoutCubit.get(context).currentIndex,
                items: HomeLayoutCubit.get(context).bottomItems,
                onTap: (index) {
                  UserLoginCubit.get(context).loggedInUser?.role == "Organization" ?
                  HomeLayoutCubit.get(context)
                      .changeOrganizationBottomNavBar(context, index):
                  HomeLayoutCubit.get(context)
                      .changeUserBottomNavBar(context, index);
                },
              ),
            );
          },
        );
      },
    );
  }
}
