import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/DonationForm_bloc/cubit.dart';
import 'package:flutter_code/bloc/DonationForm_bloc/states.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/models/GetDetailedDonationFormModel.dart';
import 'package:flutter_code/modules/OrganizationView/AllDonationFormPage/AllForms.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class DetailedDonationFormPage extends StatelessWidget {
  const DetailedDonationFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLoginCubit, UserLoginStates>(
      listener: (context, state) {},
      builder: (context, userLoginState) {
        return BlocConsumer<DonationFormCubit, DonationFormStates>(
          listener: (context, state) {},
          builder: (context, state) {
            double screenWidth = MediaQuery.of(context).size.width;
            double screenHeight = MediaQuery.of(context).size.height;

            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: SvgPicture.asset('assets/images/arrowLeft.svg'),
                  color: HexColor("858888"),
                  onPressed: () {
                    navigateAndFinish(context, const AllDonationForms());
                  },
                ),
              ),
              body: Padding(
                padding: EdgeInsetsDirectional.only(
                  top: screenHeight / 30,
                  start: screenWidth / 30,
                  end: screenWidth / 30,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final donationForm = DonationFormCubit.get(context)
                        .detailedDonationFormResponse
                        ?.donationForm;

                    if (donationForm != null) {
                      return detailedDonationFormItem(donationForm, context);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: defaultColor,
                        ),
                      );
                    }
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(height: screenHeight / 50),
                  itemCount: 1,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget detailedDonationFormItem(
      DetailedDonationFormDetails? getOrgDonationFormsDetails, context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
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
          start: screenWidth / 20,
          top: screenHeight / 50,
          end: screenWidth / 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getOrgDonationFormsDetails?.title ?? "",
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
                  getOrgDonationFormsDetails != null
                      ? DateFormat('dd-MM-yyyy')
                          .format(getOrgDonationFormsDetails.endDate)
                      : 'No date available',
                  // Placeholder text or alternative handling
                  style: const TextStyle(
                    fontSize: 9.0,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight / 50),
            Expanded(
              child: Text(
                getOrgDonationFormsDetails?.description ?? "",
                style: const TextStyle(
                  fontSize: 11.0,
                  color: Colors.black45,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: screenHeight / 40),
            SizedBox(
              height: screenHeight / 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Donation Link: ",
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight / 150),
                  Expanded(
                    child: Text(
                      getOrgDonationFormsDetails?.donationLink ?? "",
                      style: const TextStyle(
                        fontSize: 11.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2, // Adjust as needed
                      overflow: TextOverflow.ellipsis,
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
