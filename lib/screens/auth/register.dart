import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_order/dtos/create_user_dto.dart';
import 'package:water_order/models/verify_otp_model.dart';
import 'package:water_order/screens/auth/login_page.dart';
import 'package:water_order/screens/bottomnav/bottomnav.dart';
import 'package:water_order/screens/maps/map.dart';
import 'package:water_order/services/module.dart';
import 'package:water_order/utils/colors.dart';
import 'package:water_order/utils/global.dart';
import 'package:water_order/widget/custombutton.dart';
import 'package:water_order/widget/loading.dart';
import 'package:water_order/widget/snakbar.dart';

import '../../services/constants/local_db_keys.dart';

class Register extends StatefulWidget {
  final String phoneNo;
  const Register({super.key, required this.phoneNo});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * .09, vertical: size.height * .1),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Image.asset("assets/images/register.png"),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "Register",
                  style: getstyle(
                      color: Colors.black,
                      fontsize: size.width * .12,
                      fontweight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * .15,
                ),
                SizedBox(
                  height: size.height * .065,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.white,
                    cursorHeight: 20,
                    controller: _firstName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter first name";
                      }
                      return null;
                    },
                    style: getstyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "First name",
                      hintStyle: getstyle(color: Colors.white60, fontsize: 17),
                      fillColor: appColor,
                      filled: true,
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: appColor),
                          borderRadius: BorderRadius.circular(18)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: appColor),
                          borderRadius: BorderRadius.circular(18)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: appColor),
                          borderRadius: BorderRadius.circular(18)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                registerDataInputField(size, _lastName, "Last Name"),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: size.height * .065,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.white,
                    cursorHeight: 20,
                    controller: _email,
                    validator: (value) {
                      if (!RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$')
                          .hasMatch(value!)) {
                        return "Enter valid email";
                      }
                      return null;
                    },
                    style: getstyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter email",
                      hintStyle: getstyle(color: Colors.white60, fontsize: 17),
                      fillColor: appColor,
                      filled: true,
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: appColor),
                          borderRadius: BorderRadius.circular(18)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: appColor),
                          borderRadius: BorderRadius.circular(18)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: appColor),
                          borderRadius: BorderRadius.circular(18)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return CustomButton(
                      text: "Continue",
                      size: size,
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          showLoadingAnimation(context);
                          final CreateUserDto createUserDto = CreateUserDto(
                              phone: widget.phoneNo,
                              firstName: _firstName.text,
                              lastName: _lastName.text,
                              email: _email.text);
                          await ref
                              .read(createAccountProvider)
                              .createUser(createUserDto)
                              .then((value) {
                            value.fold((l) {
                              Navigator.pop(context);
                              showApiRequestErrorSnackBar(l.message);
                            }, (r) async {
                              showCustomSnackBar("Registration successful");
                              // final List<AccountDetail> accountDetailList = [
                              //   AccountDetail(
                              //       id: 1,
                              //       mobile: int.parse(createUserDto.phone),
                              //       first_name: createUserDto.firstName,
                              //       last_name: createUserDto.lastName,
                              //       email: createUserDto.email,
                              //       creation_date:
                              //           DateTime.now().toIso8601String())
                              // ];
                              // final AccountDetails accountDetails =
                              //     AccountDetails(
                              //         accountDetailList: accountDetailList,
                              //         addressData: []);
                              // final VerifyOtpModel userData = VerifyOtpModel(
                              //     msg: r.msg,
                              //     accountDetails: accountDetails,
                              //     jwt: r.jwt);
                              await ref.read(localDbProvider).write(
                                  LocalDbKeys.userData,
                                  json.encode(r.toJson()));
                              VarGlobal.userData = r;
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Maps(),
                                  ),
                                  (route) => false);
                            });
                          });
                        }
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox registerDataInputField(Size size,
      TextEditingController textEditingController, String? hintText) {
    return SizedBox(
      height: size.height * .065,
      child: TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        cursorColor: Colors.white,
        cursorHeight: 20,
        controller: textEditingController,
        style: getstyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: getstyle(color: Colors.white60, fontsize: 17),
          fillColor: appColor,
          filled: true,
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appColor),
              borderRadius: BorderRadius.circular(18)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appColor),
              borderRadius: BorderRadius.circular(18)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appColor),
              borderRadius: BorderRadius.circular(18)),
        ),
      ),
    );
  }
}
