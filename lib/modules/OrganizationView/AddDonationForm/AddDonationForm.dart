import 'package:flutter/material.dart';
import 'package:flutter_code/shared/components/components.dart';

class AddDonationForm extends StatelessWidget {
  const AddDonationForm({super.key});

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

    return donationFormUI(
      title: 'Add Donation Form',
      formKey: formKey,
      titleController: titleController,
      announceDateController: announceDateController,
      endDateController: endDateController,
      descriptionController: descriptionController,
      linkController: linkController,
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      context: context,
    );
  }
}
