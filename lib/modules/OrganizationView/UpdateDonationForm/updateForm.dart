import 'package:flutter/material.dart';
import 'package:flutter_code/modules/OrganizationView/AllDonationFormPage/AllForms.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class UpdateDonationForm extends StatelessWidget {
  const UpdateDonationForm({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var titleController = TextEditingController();
    var announceDateController = TextEditingController();
    var endDateController = TextEditingController();
    var descriptionController = TextEditingController();
    var linkController = TextEditingController();
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/images/arrowLeft.svg',
          ),
          color: HexColor("858888"),
          onPressed: () {
            navigateAndFinish(context, const AllDonationForms());
          },
        ),
        title: Text(
          'Edit Donation Form',
          style: TextStyle(
            fontSize: 23.0,
            color: HexColor("296E6F"),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: screenWidth / 30,
              top: screenHeight / 30,
              end: screenWidth / 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  'Title',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: screenHeight / 150,
                ),
                defaultTextFormField(
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Title must be entered';
                    }
                    return null;
                  },
                  controller: titleController,
                  type: TextInputType.text,
                  hintText: 'Title',
                ),
                SizedBox(
                  height: screenHeight / 50,
                ),
                // Announce Date
                const Text(
                  'Announce Date',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: screenHeight / 150,
                ),
                defaultTextFormField(
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Announce Date must be entered';
                    }
                    return null;
                  },
                  controller: announceDateController,
                  type: TextInputType.datetime,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.parse('2025-12-31'),
                    ).then((value) {
                      announceDateController.text = value.toString();
                    });
                  },
                  hintText: 'DD/MM/YYYY',
                ),
                SizedBox(
                  height: screenHeight / 50,
                ),
                // End Date
                const Text(
                  'End Date',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: screenHeight / 150,
                ),
                defaultTextFormField(
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'End Date must be entered';
                    }
                    return null;
                  },
                  controller: endDateController,
                  type: TextInputType.datetime,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.parse('2030-12-31'),
                    ).then((value) {
                      endDateController.text = value.toString();
                    });
                  },
                  hintText: 'DD/MM/YYYY',
                ),
                SizedBox(
                  height: screenHeight / 50,
                ),
                // Description
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: screenHeight / 150,
                ),
                defaultTextFormField(
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Description must be entered';
                    }
                    return null;
                  },
                  controller: descriptionController,
                  type: TextInputType.text,
                  onTap: () {},
                  hintText: '',
                  height: 80.0,
                ),
                SizedBox(
                  height: screenHeight / 50,
                ),
                // Donation Link
                const Text(
                  'Donation Link',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: screenHeight / 150,
                ),
                defaultTextFormField(
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Donation Link must be entered';
                    }
                    return null;
                  },
                  controller: linkController,
                  type: TextInputType.text,
                  onTap: () {},
                  hintText: 'https://googleForm',
                ),
                SizedBox(
                  height: screenHeight / 20,
                ),
                // Submit Button
                defaultButton(
                  function: (){
                    if (formKey.currentState!.validate()) {
                      showToast(
                        text: "Form updated successfully",
                        state: ToastStates.SUCCESS,
                      );
                      // navigateAndFinish(context, const VolunHeroOrganizationLayout());
                    }
                  },
                  text: 'Submit',
                  fontWeight: FontWeight.w300,
                  width: screenWidth / 1.1,
                  isUpperCase: false,
                ),
                SizedBox(
                  height: screenHeight / 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
