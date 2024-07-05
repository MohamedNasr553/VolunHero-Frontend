import 'package:flutter/material.dart';
import 'package:flutter_code/layout/VolunHeroLayout/layout.dart';
import 'package:flutter_code/modules/OrganizationView/UpdateDonationForm/updateForm.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

class AllDonationForms extends StatelessWidget {
  const AllDonationForms({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => allDonationFormItem(context),
          separatorBuilder: (context, index) =>
              SizedBox(height: screenHeight / 50),
          itemCount: 2,
        ),
      ),
    );
  }

  Widget allDonationFormItem(context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth / 2,
      height: screenHeight / 5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10.0,
            spreadRadius: -5.0,
            offset: const Offset(5.0, 5.0),
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
                  const Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight / 70,
                  ),
                  const Text(
                    ' I would like to know if anyone need any kind of help, '
                    'Just contact me on Direct messages  ',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 130.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      50.0,
                    ),
                    color: defaultColor,
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
                          Icons.edit,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: screenWidth / 40,
                        ),
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
                SizedBox(
                  width: screenWidth / 8,
                ),
                Container(
                  width: 130.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      50.0,
                    ),
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
                        SizedBox(
                          width: screenWidth / 40,
                        ),
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
          ],
        ),
      ),
    );
  }
}
