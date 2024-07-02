import 'dart:convert';
import 'dart:io';
import 'package:flutter_code/models/SignUpModel.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/SignUp_bloc/cubit.dart';
import 'package:flutter_code/bloc/SignUp_bloc/states.dart';
import 'package:flutter_code/modules/GeneralView/Login/Login_Page.dart';
import 'package:flutter_code/modules/GeneralView/OnBoarding/OnBoarding_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stroke_text/stroke_text.dart';

class UserSignupPage extends StatefulWidget {
  const UserSignupPage({super.key});

  @override
  State<UserSignupPage> createState() => _UserSignupPageState();
}

class _UserSignupPageState extends State<UserSignupPage> {
  final formKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var userNameController = TextEditingController();
  var emailAddressController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var specification = '';
  final _picker = ImagePicker();
  File? _profilePic;
  List<File>? _attachments = [];
  String classification = '';
  String? selectedItem;

  Future<void> _signUp() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://volunhero.onrender.com/api/auth/signUp'),
      );

      // bool attachmentsRequired =
      // (classification == "Medical" || classification == "Educational");

      request.fields['firstName'] = firstNameController.text;
      request.fields['lastName'] = lastNameController.text;
      request.fields['userName'] = userNameController.text;
      request.fields['email'] = emailAddressController.text;
      request.fields['password'] = passwordController.text;
      request.fields['cpassword'] = confirmPasswordController.text;
      request.fields['phone'] = phoneController.text;
      request.fields['address'] = addressController.text;
      request.fields['specification'] = selectedItem!;

      if (_profilePic != null) {
        print('Profile Pic: ${_profilePic!.path}');
        request.files.add(
          await http.MultipartFile.fromPath(
            'profilePic',
            _profilePic!.path,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      for (var attachment in _attachments!) {
        print('Attachment: ${attachment.path}');
        request.files.add(
          await http.MultipartFile.fromPath(
            'attachments',
            attachment.path,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      try {
        final response = await request.send();

        final responseString = await response.stream.bytesToString();
        print('Response status: ${response.statusCode}');
        print('Response body: $responseString');

        if (response.statusCode == 201) {
          print('User created successfully');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: defaultColor,
            content: Text(
              'User created successfully',
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
          ));
        } else {
          final responseData = jsonDecode(responseString);
          final signUpModel = SignupModel.fromJson(responseData);
          print('Failed to create user');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              signUpModel.message ?? 'Unexpected error',
              style: const TextStyle(
                fontSize: 12.0,
              ),
            ),
          ));
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  Future<void> _pickProfilePic() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profilePic = File(pickedFile!.path);
    });
  }

  Future<void> _pickAttachments() async {
    final pickedFiles = await _picker.pickMultiImage();
    setState(() {
      _attachments = pickedFiles.map((file) => File(file.path)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<UserSignUpCubit, UserSignUpStates>(
      listener: (context, states) {},
      builder: (context, states) {
        return Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: screenHeight / 0.48,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: screenHeight / 0.2,
                    child: SvgPicture.asset(
                      "assets/images/Vector_401.svg",
                      width: double.infinity,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 0,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                      onPressed: () {
                        navigateAndFinish(context, const OnBoarding());
                      },
                    ),
                  ),
                  // Form
                  SizedBox(
                    height: screenHeight / 0.3,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: screenWidth / 20,
                        top: screenHeight / 2.8,
                        end: screenWidth / 20,
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const StrokeText(
                              text: "First name",
                              textStyle: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              strokeWidth: 1.0,
                              strokeColor: Colors.black,
                            ),
                            SizedBox(height: screenHeight / 100),
                            defaultTextFormField(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your First Name';
                                }
                                return null;
                              },
                              controller: firstNameController,
                              type: TextInputType.text,
                              hintText: 'First Name',
                            ),
                            SizedBox(height: screenHeight / 50),
                            const StrokeText(
                              text: "Last name",
                              textStyle: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              strokeWidth: 1.0,
                              strokeColor: Colors.black,
                            ),
                            SizedBox(height: screenHeight / 100),
                            defaultTextFormField(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your Last Name';
                                }
                                return null;
                              },
                              controller: lastNameController,
                              type: TextInputType.text,
                              hintText: 'Last Name',
                            ),
                            SizedBox(height: screenHeight / 50),
                            const StrokeText(
                              text: "Phone",
                              textStyle: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              strokeWidth: 1.0,
                              strokeColor: Colors.black,
                            ),
                            SizedBox(height: screenHeight / 100),
                            defaultTextFormField(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your Last Name';
                                }
                                return null;
                              },
                              controller: phoneController,
                              type: TextInputType.phone,
                              hintText: 'Phone',
                            ),
                            // SizedBox(height: screenHeight / 50),
                            // const StrokeText(
                            //   text: "Date Of Birth",
                            //   textStyle: TextStyle(
                            //     fontSize: 12.0,
                            //     fontWeight: FontWeight.w500,
                            //     color: Colors.black,
                            //   ),
                            //   strokeWidth: 1.0,
                            //   strokeColor: Colors.black,
                            // ),
                            // SizedBox(height: screenHeight / 100),
                            // defaultTextFormField(
                            //   validate: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'Enter your date of birth in YYYY-MM-DD';
                            //     }
                            //     return null;
                            //   },
                            //   controller: _dob,
                            //   type: TextInputType.text,
                            //   hintText: 'YYYY-MM-DD',
                            // ),
                            SizedBox(height: screenHeight / 50),
                            const StrokeText(
                              text: "Address",
                              textStyle: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              strokeWidth: 1.0,
                              strokeColor: Colors.black,
                            ),
                            SizedBox(height: screenHeight / 100),
                            defaultTextFormField(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your address';
                                }
                                return null;
                              },
                              controller: addressController,
                              type: TextInputType.text,
                              hintText: 'Address',
                            ),
                            SizedBox(height: screenHeight / 50),
                            const StrokeText(
                              text: "Username",
                              textStyle: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              strokeWidth: 1.0,
                              strokeColor: Colors.black,
                            ),
                            SizedBox(height: screenHeight / 100),
                            defaultTextFormField(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your username';
                                }
                                return null;
                              },
                              controller: userNameController,
                              type: TextInputType.text,
                              hintText: 'UserName',
                            ),
                            SizedBox(height: screenHeight / 50),
                            const StrokeText(
                              text: "Email Address",
                              textStyle: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              strokeWidth: 1.0,
                              strokeColor: Colors.black,
                            ),
                            SizedBox(height: screenHeight / 100),
                            defaultTextFormField(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your Email Address';
                                }
                                return null;
                              },
                              controller: emailAddressController,
                              type: TextInputType.emailAddress,
                              hintText: 'Youremail@gmail.com',
                            ),
                            SizedBox(height: screenHeight / 50),
                            const StrokeText(
                              text: "Password",
                              textStyle: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              strokeWidth: 1.0,
                              strokeColor: Colors.black,
                            ),
                            SizedBox(height: screenHeight / 100),
                            TextFormField(
                              obscureText: (UserSignUpCubit.get(context).isPassword) ? true : false,
                              controller: passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your Password';
                                }
                                return null;
                              },
                              style: const TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w300,
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey.shade500,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1.0,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    UserSignUpCubit.get(context).suffix,
                                  ),
                                  onPressed: () {
                                    UserSignUpCubit.get(context)
                                        .changePasswordVisibility();
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight / 50),
                            const StrokeText(
                              text: "Confirm Password",
                              textStyle: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              strokeWidth: 1.0,
                              strokeColor: Colors.black,
                            ),
                            SizedBox(height: screenHeight / 100),
                            TextFormField(
                              obscureText: (UserSignUpCubit.get(context).isCPassword) ? true : false,
                              controller: confirmPasswordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Confirm Password must be entered';
                                }
                                return null;
                              },
                              style: const TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w300,
                                ),
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey.shade500,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1.0,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    UserSignUpCubit.get(context).cSuffix,
                                  ),
                                  onPressed: () {
                                    UserSignUpCubit.get(context)
                                        .changeCPasswordVisibility();
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight / 50),
                            const StrokeText(
                              text: "Specification",
                              textStyle: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              strokeWidth: 1.0,
                              strokeColor: Colors.black,
                            ),
                            SizedBox(height: screenHeight / 100),
                            /// Specification
                            Column(
                              children: [
                                RadioListTile<String>(
                                  title: const Text(
                                    'General',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  activeColor: defaultColor,
                                  dense: true,
                                  visualDensity:
                                      const VisualDensity(vertical: -4),
                                  value: 'General',
                                  contentPadding: EdgeInsets.zero,
                                  groupValue: selectedItem,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedItem = value!;
                                    });
                                  },
                                ),
                                RadioListTile<String>(
                                  title: const Text(
                                    'Medical',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  activeColor: defaultColor,
                                  visualDensity:
                                      const VisualDensity(vertical: -4),
                                  value: 'Medical',
                                  groupValue: selectedItem,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedItem = value!;
                                    });
                                  },
                                ),
                                RadioListTile<String>(
                                  title: const Text(
                                    'Educational',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  activeColor: defaultColor,
                                  visualDensity:
                                      const VisualDensity(vertical: -4),
                                  value: 'Educational',
                                  groupValue: selectedItem,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedItem = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight / 25),
                            const StrokeText(
                              text: "Profile Picture",
                              textStyle: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              strokeWidth: 1.0,
                              strokeColor: Colors.black,
                            ),
                            SizedBox(height: screenHeight / 70),
                            ElevatedButton(
                              onPressed: _pickProfilePic,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.blueGrey.shade200,
                                minimumSize: Size(
                                  screenHeight / 2,
                                  screenWidth / 6,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'Upload Profile Photo',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight / 25),
                            const StrokeText(
                              text: "Attachments",
                              textStyle: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              strokeWidth: 1.0,
                              strokeColor: Colors.black,
                            ),
                            SizedBox(height: screenHeight / 70),
                            ElevatedButton(
                              onPressed: _pickAttachments,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.blueGrey.shade200,
                                minimumSize: Size(
                                  screenHeight / 2,
                                  screenWidth / 6,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'Upload Attachment',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight / 15),
                            (states is! UserSignUpLoadingState) ?
                            defaultButton(
                              function: () {
                                _signUp();
                                print("Selected Item: $selectedItem");
                              },
                              text: 'Sign up',
                              isUpperCase: false,
                              fontWeight: FontWeight.w300,
                              width: screenWidth / 1.1,
                            )
                                : const Center(
                              child: CircularProgressIndicator(
                                color: defaultColor,
                              ),
                            ),
                            SizedBox(height: screenHeight / 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account.",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ),
                                SizedBox(width: screenWidth / 80),
                                InkWell(
                                  onTap: () {
                                    navigateToPage(context, LoginPage());
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: defaultColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Create Account Text
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 15.0,
                      bottom: screenHeight / 0.651,
                    ),
                    child: const Row(
                      children: [
                        StrokeText(
                          text: "Cre",
                          textStyle: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 47, 129, 131),
                          ),
                          strokeWidth: 3.0,
                          strokeColor: Colors.white,
                        ),
                        SizedBox(
                          width: 2.0,
                        ),
                        Text(
                          "ate Account",
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
