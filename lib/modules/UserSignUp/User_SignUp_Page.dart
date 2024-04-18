import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code/modules/Login/Login_Page.dart';
import 'package:flutter_code/modules/OnBoarding2/OnBoarding2_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:permission_handler/permission_handler.dart';

class UserSignupPage extends StatefulWidget {
  const UserSignupPage({super.key});

  @override
  State<UserSignupPage> createState() => _UserSignupPageState();
}

class _UserSignupPageState extends State<UserSignupPage> {
  var formKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailAddressController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  String selectedItem = '';
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
                  navigateAndFinish(context, const OnBoarding2());
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
                        text: "First name",
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
                        validate: (value){
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
                      SizedBox(
                        height: screenHeight / 100,
                      ),
                      defaultTextFormField(
                        validate: (value){
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
                        validate: (value){
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
                      defaultTextFormField(
                        isPassword: true,
                        validate: (value){
                          if (value!.isEmpty) {
                            return 'please enter your Password';
                          }
                          return null;
                        },
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        hintText: 'Password',
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
                        validate: (value){
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
                        text: "Specification",
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
                      Column(
                        children: [
                          RadioListTile(
                            title: const Text(
                              'General',
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            activeColor: defaultColor,
                            dense: true,
                            visualDensity: const VisualDensity(vertical: -4),
                            value: 'General',
                            contentPadding: EdgeInsets.zero,
                            groupValue: selectedItem,
                            onChanged: (value) {
                              setState(() {
                                selectedItem = value!;
                              });
                            },
                          ),
                          RadioListTile(
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
                            visualDensity: const VisualDensity(vertical: -4),
                            value: 'Medical',
                            groupValue: selectedItem,
                            onChanged: (value) {
                              setState(() {
                                selectedItem = value!;
                              });
                            },
                          ),
                          RadioListTile(
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
                            visualDensity: const VisualDensity(vertical: -4),
                            value: 'Educational',
                            groupValue: selectedItem,
                            onChanged: (value) {
                              setState(() {
                                selectedItem = value!;
                              });
                            },
                          ),
                        ],
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
                                    _filePath == null ? 'Add or drop your' : 'File Selected',
                                    style: TextStyle(
                                      color: defaultColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    _filePath == null ? ' file in here' : 'File Selected',
                                    style: TextStyle(
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
          title: Text('Permission Required'),
          content: Text('Please allow access to external storage to upload files.'),
          actions:[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
              },
              child: Text('Open Settings'),
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
