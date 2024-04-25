import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/OrganizationLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/OrganizationLayout_bloc/states.dart';
import 'package:flutter_code/shared/styles/colors.dart';

class VolunHeroOrganizationLayout extends StatelessWidget {
  const VolunHeroOrganizationLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrganizationLayoutCubit, OrganizationLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var organizationHomeLayoutBloc = BlocProvider.of<OrganizationLayoutCubit>(context);

        return Scaffold(
          body: organizationHomeLayoutBloc.layoutScreens[organizationHomeLayoutBloc.currentIndex],
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
            currentIndex: organizationHomeLayoutBloc.currentIndex,
            selectedItemColor: defaultColor,
            unselectedItemColor: Colors.black54,
            items: organizationHomeLayoutBloc.bottomItems,
            onTap: (index) {
              organizationHomeLayoutBloc.orgChangeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
