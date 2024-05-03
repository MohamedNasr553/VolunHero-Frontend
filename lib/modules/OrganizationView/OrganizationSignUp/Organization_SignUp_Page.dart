import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code/modules/GeneralView/Login/Login_Page.dart';
import 'package:flutter_code/modules/GeneralView/OnBoarding/OnBoarding_Page.dart';
import 'package:flutter_code/modules/GeneralView/OnBoarding2/OnBoarding2_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:permission_handler/permission_handler.dart';

class OrganizationSignUp extends StatefulWidget {
  const OrganizationSignUp({super.key});

  @override
  State<OrganizationSignUp> createState() => _OrganizationSignUpState();
}

class _OrganizationSignUpState extends State<OrganizationSignUp> {
  var formKey = GlobalKey<FormState>();
  var organizationController = TextEditingController();
  var organizationUserNameController = TextEditingController();
  var emailAddressController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  String? _filePath;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: screenHeight / 0.5,
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
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 10.0,
                bottom: screenHeight / 0.68,
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
            SizedBox(
              height: screenHeight / 0.69,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 40, 20, 0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const StrokeText(
                        text: "Organization name",
                        textStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        strokeWidth: 1.0,
                        strokeColor: Colors.black,
                      ),
                      SizedBox(
                        height: screenHeight / 100,
                      ),
                      defaultTextFormField(
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter organization name';
                          }
                          return null;
                        },
                        controller: organizationController,
                        type: TextInputType.text,
                        hintText: 'Organization Name',
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
                      SizedBox(
                        height: screenHeight / 100,
                      ),
                      defaultTextFormField(
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your Username';
                          }
                          return null;
                        },
                        controller: organizationUserNameController,
                        type: TextInputType.text,
                        hintText: 'Username',
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
                      SizedBox(
                        height: screenHeight / 100,
                      ),
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
                      SizedBox(
                        height: screenHeight / 100,
                      ),
                      TextFormField(
                        // obscureText: (UserSignUpCubit.get(context).isPassword) ? true : false,
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
                          // suffixIcon: IconButton(
                          //   icon: Icon(
                          //     UserSignUpCubit.get(context).suffix,
                          //   ),
                          //   onPressed: () {
                          //     UserSignUpCubit.get(context)
                          //         .changePasswordVisibility();
                          //   },
                          // ),
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
                      SizedBox(
                        height: screenHeight / 100,
                      ),
                      defaultTextFormField(
                        isPassword: true,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please confirm password';
                          }
                          if (value != passwordController.text) {
                            return 'Passwords are not same';
                          }
                          return null;
                        },
                        controller: confirmPasswordController,
                        type: TextInputType.visiblePassword,
                        hintText: 'Confirm Password',
                      ),
                      SizedBox(height: screenHeight / 50),
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
                      SizedBox(
                        height: screenHeight / 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 10),
                        child: Container(
                          width: 400,
                          height: 85,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            onTap: () async {
                              await _requestPermission();
                              _pickFile();
                            },
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _filePath == null
                                        ? 'Add or drop your'
                                        : 'File Selected',
                                    style: const TextStyle(
                                      color: defaultColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    _filePath == null
                                        ? ' file in here'
                                        : 'File Selected',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight / 30),
                      defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            showToast(
                              text: "Registered Successfully",
                              state: ToastStates.SUCCESS,
                            );
                            navigateAndFinish(context, LoginPage());
                          }
                        },
                        text: 'Sign up',
                        isUpperCase: false,
                        fontWeight: FontWeight.w300,
                        width: screenWidth / 1.1,
                      ),
                      SizedBox(height: screenHeight / 70),
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
          ],
        ),
      ),
    );
  }

  Future<void> _requestPermission() async {
    // Request external storage permission
    var status = await Permission.storage.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Permission Required'),
          content:
          const Text('Please allow access to external storage to upload files.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );
    }
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path!;
      });
    }
  }
}
