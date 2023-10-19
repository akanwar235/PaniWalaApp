import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:water_order/dtos/verify_otp_dto.dart';
import 'package:water_order/models/verify_otp_model.dart';
import 'package:water_order/screens/auth/register.dart';
import 'package:water_order/screens/bottomnav/bottomnav.dart';
import 'package:water_order/services/constants/local_db_keys.dart';
import 'package:water_order/services/module.dart';
import 'package:water_order/services/local_database.dart';
import 'package:water_order/utils/colors.dart';
import 'package:water_order/utils/global.dart';
import 'package:water_order/widget/loading.dart';

import '../../widget/custombutton.dart';
import '../../widget/snakbar.dart';

class OtpVerify extends StatefulWidget {
  final String phno;
  const OtpVerify({super.key, required this.phno});

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  int otpcode = 0000;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding:
              EdgeInsets.symmetric(vertical: size.height * .1, horizontal: 30),
          child: Column(
            children: [
              // Align(
              //   alignment: Alignment.topLeft,
              //   child: GestureDetector(
              //     onTap: () => Navigator.of(context).pop(),
              //     child: Icon(Icons.arrow_back),
              //   ),
              // ),
              Container(
                width: 200,
                height: 200,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: appColor,
                ),
                child: Image.asset(
                  "assets/images/otp.gif",
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Verification",
                style: getstyle(
                    color: Colors.black,
                    fontsize: size.height * .025,
                    fontweight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Enter the OTP send to your phone number",
                style:
                    getstyle(color: Colors.black, fontweight: FontWeight.w100),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Pinput(
                length: 4,
                showCursor: true,
                defaultPinTheme: PinTheme(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: appColor,
                    ),
                  ),
                  textStyle:
                      getstyle(fontweight: FontWeight.w600, fontsize: 18),
                ),
                onCompleted: (value) {
                  setState(() {
                    otpcode = int.parse(value);
                  });
                },
              ),
              const SizedBox(height: 25),
              Consumer(builder:
                  (BuildContext context, WidgetRef ref, Widget? child) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: CustomButton(
                    size: size,
                    text: "Verify",
                    onPressed: () async {
                      if (otpcode != 0000) {
                        showLoadingAnimation(context);
                        final VerifyOtpDto dto =
                            VerifyOtpDto(phone: widget.phno, otp: otpcode);
                        if (true) {
                          await ref
                              .read(otpServiceProvider)
                              .verifyOtp(dto)
                              .then(
                            (value) {
                              value.fold(
                                (l) {
                                  print(l);
                                  Navigator.pop(context);
                                  showApiRequestErrorSnackBar(l.message);
                                },
                                (r) async {
                                  print(r);
                                  if (r.jwt != null &&
                                      r.accountDetails != null) {
                                    ///LOGIN
                                    final String userDataStr =
                                        json.encode(r.toJson());
                                    await ref.read(localDbProvider).write(
                                        LocalDbKeys.userData, userDataStr);
                                    VarGlobal.userData = r;

                                    ///Nav to home
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const BottomNav(),
                                        ),
                                        (route) => false);
                                  } else {
                                    ///REGISTER USER
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Register(phoneNo: widget.phno),
                                        ),
                                        (route) => false);
                                  }
                                },
                              );
                            },
                          );
                        }
                      } else {
                        showCustomSnackBar("Enter 4-Digit code");
                      }
                    },
                  ),
                );
              }),
              const SizedBox(height: 20),
              const Text(
                "Didn't receive code",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () async {
                  // resend();
                },
                child: Text(
                  "Resend New Code",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: appColor,
                  ),
                ),
              )
            ],
          ),
        ));
  }

  // void verifyOtp(BuildContext context, String userOtp) async {
  //   try {
  //     PhoneAuthCredential creds = PhoneAuthProvider.credential(
  //         verificationId: widget.verificationId, smsCode: userOtp);

  //     User? user = (await _firebaseAuth.signInWithCredential(creds)).user;

  //     if (user != null) {
  //       SharedPreferences shd = await SharedPreferences.getInstance();
  //       shd.setBool("isUserSignedIn", true);
  //       Global.isUserSignedIn = true;

  //       showCustomSnackBar(context, "Verified !!!");
  //       Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (context) => const Register()),
  //           (route) => false);
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     showCustomSnackBar(context, e.message.toString());
  //   }
  // }

  // void resend() async {
  //   try {
  //     await _firebaseAuth.verifyPhoneNumber(
  //         phoneNumber: widget.phno,
  //         verificationCompleted:
  //             (PhoneAuthCredential phoneAuthCredential) async {
  //           await _firebaseAuth.signInWithCredential(phoneAuthCredential);
  //         },
  //         verificationFailed: (error) {
  //           showCustomSnackBar(context, "Cannot able to send OTP. Please try again!");
  //           throw Exception(error.message);
  //         },
  //         codeSent: (verificationId, forceResendingToken) {
  //           print("send");
  //           // print(forceResendingToken);
  //           showCustomSnackBar(context, "Otp Sent!!!");
  //         },
  //         codeAutoRetrievalTimeout: (verificationId) {});
  //   } on FirebaseAuthException catch (e) {
  //     showCustomSnackBar(context, e.code);
  //   }
  // }
}
