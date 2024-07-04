import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Layout_bloc/cubit.dart';
import 'package:flutter_code/bloc/Layout_bloc/states.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/bloc/SupportCalls_bloc/cubit.dart';
import 'package:flutter_code/bloc/SupportCalls_bloc/states.dart';
import 'package:flutter_code/layout/VolunHeroLayout/layout.dart';
import 'package:flutter_code/modules/GeneralView/GetSupport/Support_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stroke_text/stroke_text.dart';

class Education extends StatelessWidget {
  const Education({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<UserLoginCubit, UserLoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<HomeLayoutCubit, LayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return BlocConsumer<SupportCallsCubit, SupportCallsStates>(
              listener: (context, state) {},
              builder: (context, state) {
                var userModel = SupportCallsCubit.get(context);

                return Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: SvgPicture.asset('assets/images/arrowLeft.svg'),
                      color: HexColor("858888"),
                      onPressed: () {
                        navigateToPage(context, const VolunHeroLayout());
                        (UserLoginCubit.get(context).loggedInUser!.role ==
                                "Organization")
                            ? HomeLayoutCubit.get(context)
                                .changeOrganizationBottomNavBar(context, 1)
                            : HomeLayoutCubit.get(context)
                                .changeUserBottomNavBar(context, 1);
                      },
                    ),
                    title: StrokeText(
                      text: "Educational",
                      strokeColor: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                        color: HexColor("296E6F"),
                      ),
                    ),
                  ),
                  body: userModel
                          .educationalSupportCallsUserModel!.users.isNotEmpty
                      ? ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return buildSupportCallItem(
                              userModel.educationalSupportCallsUserModel!
                                  .users[index],
                              index,
                              context,
                            );
                          },
                          separatorBuilder: (context, index) => Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 10.0),
                            child: Container(
                              width: double.infinity,
                              height: 0.1,
                              color: Colors.white,
                            ),
                          ),
                          itemCount: userModel
                              .educationalSupportCallsUserModel!.users.length,
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.face_retouching_off_sharp,
                                size: 50,
                                color: Colors.black54,
                              ),
                              SizedBox(height: screenHeight / 50),
                              const Text(
                                "No users or organizations available right now",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Roboto",
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: screenHeight / 200),
                              const Text(
                                "Online users and organizations"
                                " will show up here.",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Roboto",
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          ),
                        ),
                );
              },
            );
          },
        );
      },
    );
  }
}
