import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/OrganizationLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/OrganizationLayout_bloc/states.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/states.dart';

class VolunHeroOrganizationLayout extends StatelessWidget {
  const VolunHeroOrganizationLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeOrganizationLayoutCubit(),
      child: BlocConsumer<HomeOrganizationLayoutCubit, OrganizationLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final homeLayoutBloc = BlocProvider.of<HomeOrganizationLayoutCubit>(context);
          homeLayoutBloc.initializeBottomItems();
          homeLayoutBloc.homeLayoutScreens();

          return Scaffold(
            body: homeLayoutBloc.layoutScreens[homeLayoutBloc.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
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
              currentIndex: homeLayoutBloc.currentIndex,
              items: homeLayoutBloc.bottomItems,
              onTap: (index) {
                if (index == 4 && !homeLayoutBloc.isActive) {
                  homeLayoutBloc.isActive = true;
                  homeLayoutBloc.initializeBottomItems();
                } else if (index != 4 && homeLayoutBloc.isActive) {
                  homeLayoutBloc.isActive = false;
                  homeLayoutBloc.initializeBottomItems();
                }
                homeLayoutBloc.changeBottomNavBar(index);
              },
            ),
          );
        },
      ),
    );
  }
}
