// import 'package:flutter/material.dart';
// import 'package:flutter_code/modules/OrganizationView/AllDonationFormPage/AllForms.dart';
// import 'package:flutter_code/shared/components/components.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:hexcolor/hexcolor.dart';
//
// class UpdateDonationForm extends StatelessWidget {
//   const UpdateDonationForm({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var formKey = GlobalKey<FormState>();
//     var titleController = TextEditingController();
//     var announceDateController = TextEditingController();
//     var endDateController = TextEditingController();
//     var descriptionController = TextEditingController();
//     var linkController = TextEditingController();
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight = MediaQuery.of(context).size.height;
//
//     return donationFormUI(
//       leading: IconButton(
//         icon: SvgPicture.asset(
//           'assets/images/arrowLeft.svg',
//         ),
//         color: HexColor("858888"),
//         onPressed: () {
//           navigateAndFinish(context, const AllDonationForms());
//         },
//       ),
//       title: 'Edit Donation Form',
//       formKey: formKey,
//       titleController: titleController,
//       announceDateController: announceDateController,
//       endDateController: endDateController,
//       descriptionController: descriptionController,
//       linkController: linkController,
//       screenWidth: screenWidth,
//       screenHeight: screenHeight,
//       context: context, addDonationForm: null, token: null,
//     );
//   }
// }
