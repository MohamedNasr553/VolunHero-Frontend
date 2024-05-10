import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/states.dart';
import 'package:flutter_code/shared/styles/colors.dart';

class VolunHeroUserLayout extends StatelessWidget {
  const VolunHeroUserLayout({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeLayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userLayoutBloc = BlocProvider.of<HomeLayoutCubit>(context);

        return Scaffold(
          body: userLayoutBloc.layoutScreens[userLayoutBloc.currentIndex],
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
            currentIndex: userLayoutBloc.currentIndex,
            items: userLayoutBloc.bottomItems,
            onTap: (index) {
              userLayoutBloc.changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}