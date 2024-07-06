import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/DonationForm_bloc/cubit.dart';
import 'package:flutter_code/bloc/DonationForm_bloc/states.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/layout/VolunHeroLayout/layout.dart';
import 'package:flutter_code/models/GetAllDonationFormsModel.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class AllDonationForms extends StatelessWidget {
  const AllDonationForms({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<UserLoginCubit, UserLoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<DonationFormCubit, DonationFormStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/arrowLeft.svg',
                  ),
                  color: HexColor("858888"),
                  onPressed: () {
                    navigateAndFinish(context, const VolunHeroLayout());
                  },
                ),
                title: Text(
                  'Donation Forms',
                  style: TextStyle(
                    fontSize: 23.0,
                    color: HexColor("296E6F"),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              body: Padding(
                padding: EdgeInsetsDirectional.only(
                  top: screenHeight / 30,
                  start: screenWidth / 30,
                  end: screenWidth / 30,
                ),
                child: ListView.separated(
                  reverse: true,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => allDonationFormItem(
                    DonationFormCubit.get(context)
                        .getAllDonationFormsResponse!
                        .donationForms[index],
                    context,
                  ),
                  separatorBuilder: (context, index) =>
                      SizedBox(height: screenHeight / 50),
                  itemCount: DonationFormCubit.get(context)
                          .getAllDonationFormsResponse
                          ?.donationForms
                          .length ??
                      0,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget allDonationFormItem(
    DonationFormDetails? donationFormDetails,
    context,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth / 2,
      height: screenHeight / 4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10.0,
            spreadRadius: -5.0,
            offset: const Offset(10.0, 10.0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          bottom: screenHeight / 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: screenWidth / 20,
                top: screenHeight / 50,
                end: screenWidth / 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        donationFormDetails!.title,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight / 200),
                      Row(
                        children: [
                          const Text(
                            'End Date:  ',
                            style: TextStyle(
                              fontSize: 9.0,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            DateFormat('dd-MM-yyyy').format(donationFormDetails.endDate),
                            style: const TextStyle(
                              fontSize: 9.0,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight / 50),
                  Text(
                    donationFormDetails.description,
                    style: const TextStyle(
                      fontSize: 11.0,
                      color: Colors.black45,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: screenWidth / 70,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: screenWidth / 3.3,
                    height: screenHeight / 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: defaultColor,
                    ),
                    child: MaterialButton(
                      height: screenHeight / 50,
                      onPressed: () {
                        // navigateToPage(context, const UpdateDonationForm());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            size: 20.0,
                            Icons.edit,
                            color: Colors.white,
                          ),
                          SizedBox(width: screenWidth / 40),
                          const Text(
                            'Edit',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 17.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth / 8),
                  Container(
                    width: screenWidth / 3.5,
                    height: screenHeight / 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: HexColor("D61212"),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        // navigateToPage(context, const UpdateDonationForm());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            size: 20.0,
                            Icons.delete_forever,
                            color: Colors.white,
                          ),
                          SizedBox(width: screenWidth / 40),
                          const Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 17.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
