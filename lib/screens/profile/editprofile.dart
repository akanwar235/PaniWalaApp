// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_order/utils/global.dart';
import 'package:water_order/widget/custombutton.dart';
import 'package:water_order/widget/loading.dart';

import '../../utils/colors.dart';
import '../../widget/snakbar.dart';
import '../auth/login_page.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  File? imageFromDevice;
  bool isselectedImage = true;
  var userdata = VarGlobal.userData;
  late String _firstName;
  late String _phone;
  late String _email;

  Future _pickMedia(ImageSource source) async {
    // widget.photourl = null;
    imageFromDevice = null;
    try {
      var image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        isselectedImage = false;
        return;
      }
      File? img = File(image.path);
      if (img.lengthSync() ~/ 1024 <= 12000) {
        setState(() {
          imageFromDevice = img;
        });
      } else {
        isselectedImage = true;
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _firstName = userdata!.accountDetails!.accountDetailList[0].firstName;
    _phone = userdata!.accountDetails!.accountDetailList[0].mobile.toString();
    _email = userdata!.accountDetails!.accountDetailList[0].email;
    // _email = "sanatthakur2002@gmail.com";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () async {
            FocusScope.of(context).unfocus();
            await Future.delayed(const Duration(milliseconds: 100), () {
              Navigator.pop(context);
            });
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: appColor,
        title: Text(
          "Profile",
          style: appstyle(),
        ),
        actions: [
          IconButton(
            splashRadius: 1,
            onPressed: () async {
              showLoadingAnimation(context);
              // await signOut();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 30,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: size.height * .7,
          width: size.width,
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  splashColor: appColor,
                  splashFactory: InkSparkle.splashFactory,
                  onTap: () async {
                    await _pickMedia(ImageSource.gallery);
                  },
                  borderRadius: BorderRadius.circular(80),
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 219, 217, 217),
                      radius: 80,
                      child: imageFromDevice != null
                          ? Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80),
                                  image: DecorationImage(
                                      image: FileImage(imageFromDevice!))),
                            )
                          : Image.asset("assets/images/otp.gif"),
                    ),
                  ),
                ),
                const Spacer(),
                TextFormField(
                  style: getstyle(
                      fontsize: 16,
                      color: const Color.fromARGB(255, 113, 110, 110)),
                  keyboardType: TextInputType.name,
                  initialValue: _firstName,
                  onChanged: (value) {
                    _firstName = value;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "First Name",
                    labelStyle: getstyle(),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                const Spacer(),
                TextFormField(
                  style: getstyle(
                      fontsize: 16,
                      color: const Color.fromARGB(255, 113, 110, 110)),
                  keyboardType: TextInputType.phone,
                  initialValue: _phone.toString(),
                  onChanged: (value) {
                    _phone = value;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    labelStyle: getstyle(),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                const Spacer(),
                TextFormField(
                  style: getstyle(
                      fontsize: 16,
                      color: const Color.fromARGB(255, 113, 110, 110)),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  initialValue: _email,
                  onChanged: (value) {
                    _email = value;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$')
                        .hasMatch(value!)) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: getstyle(),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                const Spacer(
                  flex: 10,
                ),
                CustomButton(
                    size: size,
                    text: "Update",
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        print(_firstName);
                        print(_phone);
                        print(_email);
                      }
                    }),
                const Spacer(),
                SizedBox(
                  height: size.height * .08,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future signOut() async {
  //   try {
  //     await _firebaseAuth.signOut();
  //     SharedPreferences shd = await SharedPreferences.getInstance();
  //     shd.setBool("isUserSignedIn", false);
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (context) => const LoginPage()),
  //         (route) => false);
  //     showCustomSnackBar("Logged Out !!!");
  //   } on FirebaseAuthException catch (e) {
  //     showCustomSnackBar( e.code);
  //     return "Failed";
  //   }
  // }
}
