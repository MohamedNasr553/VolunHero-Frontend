import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/layout_bloc/cubit.dart';
import 'package:flutter_code/bloc/layout_bloc/states.dart';
import 'package:hexcolor/hexcolor.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var  cubit = HomeLayoutCubit.get(context);
          return Scaffold(
            // appBar: AppBar(
            //
            //   actions: [
            //     IconButton(onPressed: (){
            //
            //     }, icon: Icon(Icons.sunny_snowing))
            //   ],
            //
            //   elevation: 0.0,
            // ),
            body: cubit.layoutScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                elevation: 0.0,
                selectedItemColor: HexColor("039FA2") ,
                onTap: (index) {
                  cubit.changeBottomNavBar(index);
                },
                unselectedItemColor: HexColor("575757"),
                items:cubit.bottomItems
            ),
          );
        }
    );
  }


}
