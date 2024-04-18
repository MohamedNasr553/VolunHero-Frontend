import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/states.dart';

class VolunHeroUserLayout extends StatelessWidget {
  const VolunHeroUserLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeLayoutBloc = HomeLayoutCubit.get(context);

        return Scaffold(
          body: homeLayoutBloc.layoutScreens[homeLayoutBloc.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            iconSize: 25.0,
            selectedLabelStyle: const TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
            ),
            currentIndex: homeLayoutBloc.currentIndex,
            items: homeLayoutBloc.bottomItems,
            onTap: (index) {
              if (index == 4 && !homeLayoutBloc.isActive) {
                homeLayoutBloc.isActive = true;
                homeLayoutBloc.initializeBottomItems();
              }
              else if (index != 4 && homeLayoutBloc.isActive) {
                homeLayoutBloc.isActive = false;
                homeLayoutBloc.initializeBottomItems();
              }
              homeLayoutBloc.changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
