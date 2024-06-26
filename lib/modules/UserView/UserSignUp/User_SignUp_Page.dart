import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/SignUp_bloc/cubit.dart';
import 'package:flutter_code/bloc/SignUp_bloc/states.dart';
import 'package:flutter_code/modules/GeneralView/Login/Login_Page.dart';
import 'package:flutter_code/modules/GeneralView/OnBoarding/OnBoarding_Page.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/multi_images_utils.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:permission_handler/permission_handler.dart';

class UserSignupPage extends StatefulWidget {
  const UserSignupPage({super.key});

  @override
  State<UserSignupPage> createState() => _UserSignupPageState();
}

class _UserSignupPageState extends State<UserSignupPage> {
  List<File>? attachments;
  File? profilePic;
  var formKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var dateOfBirthController = TextEditingController();
  var addressController = TextEditingController();
  var userNameController = TextEditingController();
  var emailAddressController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  String selectedItem = '';
  String? _filePath;
  String selectedProfile = '';
  String? _profilePath;

  XFile? pickedFile;


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
   // print(_filePath);

    return BlocConsumer<UserSignUpCubit, UserSignUpStates>(
      listener: (context, states) {},
      builder: (context, states) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: screenHeight / 0.45,
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
                      // padding: const EdgeInsets.fromLTRB(20, 280, 20, 0),
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
                            SizedBox(
                              height: screenHeight / 100,
                            ),
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
                            SizedBox(
                              height: screenHeight / 100,
                            ),
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
                            SizedBox(
                              height: screenHeight / 100,
                            ),
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
                            SizedBox(height: screenHeight / 50),
                            const StrokeText(
                              text: "Date Of Birth",
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
                                  return 'Enter your date of birth in YYYY-MM-DD';
                                }
                                return null;
                              },
                              controller: dateOfBirthController,
                              type: TextInputType.text,
                              hintText: 'YYYY-MM-DD',
                            ),
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
                            SizedBox(
                              height: screenHeight / 100,
                            ),
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
                            SizedBox(
                              height: screenHeight / 100,
                            ),
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
                                  visualDensity:
                                      const VisualDensity(vertical: -4),
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
                                  visualDensity:
                                      const VisualDensity(vertical: -4),
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
                                  visualDensity:
                                      const VisualDensity(vertical: -4),
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
                              text: "Profile Picture",
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
                                  //  await _requestPermission();
                                  pickProfileFile();
                                 // checkPermission();
                                  },
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          profilePic == null
                                              ? 'Add or drop your'
                                              : 'File Selected',
                                          style: const TextStyle(
                                            color: defaultColor,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          profilePic == null
                                              ? ' Profile Pic in here'
                                              : ' tap to select another',
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
                                    //await _requestPermission();
                                     await pickFiles();
                                  },
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              : ' tap to select another',
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
                            SizedBox(height: screenHeight / 20),
                            (states is! UserSignUpLoadingState)?defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  showToast(text: _profilePath??"profile b null XD", state: ToastStates.SUCCESS);
                                  if (selectedItem.isEmpty) {
                                    showToast(
                                      text: 'Please select a specification',
                                      state: ToastStates.ERROR,
                                    );
                                  } else {
                                    String classification = '';
                                    if (selectedItem == 'Medical') {
                                      classification = 'Medical';
                                    } else if (selectedItem == 'Educational') {
                                      classification = 'Educational';
                                    }
                                    print("picked file path 2bl register");

                                    UserSignUpCubit.get(context).registerUserUsingHTTP(
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      DOB: dateOfBirthController.text,
                                      address: addressController.text,
                                      userName: userNameController.text,
                                      email: emailAddressController.text,
                                      password: passwordController.text,
                                      cpassword: confirmPasswordController.text,
                                      phone: phoneController.text,
                                      specification: selectedItem,
                                      attachments: attachments,
                                      profilePic: profilePic,
                                      classification: classification,
                                    );
                                    // navigateToPage(context, LoginPage());
                                    // if (UserSignUpCubit.get(context).signupModel != null) {
                                    //   if (UserSignUpCubit.get(context).signupModel!.message == 'success') {
                                    //     showToast(
                                    //       text: 'Registered Successfully',
                                    //       state: ToastStates.SUCCESS,
                                    //     );
                                    //   } else {
                                    //     showToast(
                                    //       text: UserSignUpCubit.get(context).signupModel!.message!,
                                    //       state: ToastStates.ERROR,
                                    //     );
                                    //   }
                                    // }
                                    // navigateAndFinish(context, LoginPage());
                                  }
                                }
                              },
                              text: 'Sign up',
                              isUpperCase: false,
                              fontWeight: FontWeight.w300,
                              width: screenWidth / 1.1,
                            ):const Center(
                              child: CircularProgressIndicator(
                                color: defaultColor,
                              ),
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
                  // Create Account Text
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 15.0,
                      bottom: screenHeight / 0.601,
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

  Future<void> _requestPermission() async {
    // Request external storage permission
    var status = await Permission.storage.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
            'Please allow access to external storage to upload files.',
          ),
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

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        attachments = result.paths.map((path) => File(path!)).toList();
      });
    }
  }

  checkPermission() async{
    Map<Permission , PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage
    ].request();
    print("Asked_for_permission");
    if(statuses[Permission.camera] != PermissionStatus.granted || statuses[Permission.storage] != PermissionStatus.granted ){
      // Permission is not guaranted
      return;
    }
    print("confirmed_for_permission");
    pickedImage();
  }

  pickedImage()async{
    final picker = ImagePicker();
    pickedFile = await picker.pickImage(
        source: ImageSource.gallery
    );
    print("pickedFile: ");
    print(pickedFile.toString());
    setState(() {

    });
  }

  Future<void> pickProfileFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        profilePic = File(result.files.single.path!);
        _profilePath = profilePic?.path;
      });
    }
  }

}
