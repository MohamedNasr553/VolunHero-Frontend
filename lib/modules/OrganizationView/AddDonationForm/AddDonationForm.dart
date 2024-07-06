import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/DonationForm_bloc/cubit.dart';
import 'package:flutter_code/bloc/DonationForm_bloc/states.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/layout/VolunHeroLayout/layout.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class AddDonationFormPage extends StatelessWidget {
  const AddDonationFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var titleController = TextEditingController();
    var announceDateController = TextEditingController(
      text: DateFormat('DD/MM/YYYY').format(DateTime.now()),
    );
    var endDateController = TextEditingController();
    var descriptionController = TextEditingController();
    var linkController = TextEditingController();
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    void pickEndDate(BuildContext context) async {
      final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 30)),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.black,
              hintColor: Colors.black,
              colorScheme: const ColorScheme.light(
                primary: defaultColor,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            child: child!,
          );
        },
      );
      if (pickedDate != null) {
        endDateController.text = pickedDate.toIso8601String();
      }
    }

    return BlocConsumer<UserLoginCubit, UserLoginStates>(
      listener: (context, builder) {},
      builder: (context, builder) {
        return BlocConsumer<DonationFormCubit, DonationFormStates>(
          listener: (context, state) {
            if (state is AddDonationFormSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: defaultColor,
                content: Text(
                  'Form Created Successfully',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ));
              navigateAndFinish(context, const VolunHeroLayout());
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Add Donation Form',
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
                        SizedBox(height: screenHeight / 150),
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
                        SizedBox(height: screenHeight / 50),
                        // Announce Date
                        Row(
                          children: [
                            const Text(
                              'Announce Date',
                              style: TextStyle(
                                fontSize: 11.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: screenWidth / 70),
                            const Text(
                              "*Read only",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w800,
                                fontSize: 8.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight / 150),
                        defaultTextFormField(
                          fillColor: Colors.grey.shade300,
                          readonly: true,
                          validate: (value) {
                            return null;
                          },
                          controller: announceDateController,
                          type: TextInputType.text,
                          hintText: 'DD/MM/YYYY',
                        ),
                        SizedBox(height: screenHeight / 50),
                        // End Date
                        const Text(
                          'End Date',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight / 150),
                        defaultTextFormField(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'End Date must be entered';
                            }
                            return null;
                          },
                          onTap: () => pickEndDate(context),
                          controller: endDateController,
                          type: TextInputType.datetime,
                          hintText: 'DD/MM/YYYY',
                        ),
                        SizedBox(height: screenHeight / 50),
                        // Description
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight / 150),
                        Container(
                          height: screenHeight / 5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: screenWidth / 50,
                              end: screenWidth / 50
                            ),
                            child: TextFormField(
                              maxLines: null,
                              minLines: 1,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: screenHeight / 70,
                                  horizontal: screenWidth / 25,
                                ),
                                hintText: 'Description',
                                hintStyle: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Description must be entered';
                                }
                                return null;
                              },
                              controller: descriptionController,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight / 50),
                        // Donation Link
                        const Text(
                          'Donation Link',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight / 150),
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
                        SizedBox(height: screenHeight / 20),
                        // Submit Button
                        defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              final endDate =
                                  DateTime.tryParse(endDateController.text);
                              if (endDate == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Invalid date format'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              DonationFormCubit.get(context)
                                  .addDonationFormMethod(
                                title: titleController.text,
                                endDate: endDate,
                                description: descriptionController.text,
                                donationLink: linkController.text,
                                token: UserLoginCubit.get(context)
                                        .loginModel!
                                        .refresh_token ??
                                    "",
                              );
                            }
                          },
                          text: 'Submit',
                          fontWeight: FontWeight.w300,
                          width: screenWidth / 1.1,
                          isUpperCase: false,
                        ),
                        SizedBox(height: screenHeight / 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
