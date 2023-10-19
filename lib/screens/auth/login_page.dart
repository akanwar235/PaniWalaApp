import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_order/screens/auth/otp_verify.dart';
import 'package:water_order/services/module.dart';
import 'package:water_order/utils/colors.dart';
import 'package:water_order/widget/loading.dart';
import 'package:water_order/widget/snakbar.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _phone = TextEditingController();
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final otpservice = ref.read(otpServiceProvider);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(
                flex: 2,
              ),
              CachedNetworkImage(
                imageUrl:
                    "https://th.bing.com/th/id/OIP.X8q1KaRQJY59HzhcGF63QgHaFW?pid=ImgDet&rs=1",
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: size.height * .15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.contain)),
                  );
                },
                placeholder: (context, url) {
                  return const CircularProgressIndicator();
                },
              ),
              Spacer(),
              Text(
                "Login",
                style: getstyle(
                    fontsize: size.height * .04, fontweight: FontWeight.w700),
              ),
              SizedBox(
                height: size.height * .035,
              ),
              Text(
                "Enter your mobile number, we will send you OTP to verify later",
                style: getstyle(
                    fontsize: size.height * .02, fontweight: FontWeight.w200),
                textAlign: TextAlign.center,
              ),
              const Spacer(
                flex: 2,
              ),
              Container(
                height: size.height * .08,
                decoration: BoxDecoration(
                    color: appColor, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * .14,
                      child: TextFormField(
                          initialValue: "+91",
                          style: getstyle(color: Colors.white),
                          cursorColor: Colors.white,
                          cursorHeight: 20,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            fillColor: appColor,
                            filled: true,
                            hintText: "Enter your mobile number",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: appColor)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: appColor)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: appColor)),
                          )),
                    ),
                    Container(
                      color: Colors.grey,
                      width: 2,
                      height: 50,
                    ),
                    Expanded(
                      child: TextFormField(
                          controller: _phone,
                          validator: (value) {
                            if (value!.length < 10 || value.length > 10) {
                              return "Enter 10 digits mobile number";
                            }
                            return null;
                          },
                          style: getstyle(color: Colors.white),
                          cursorColor: Colors.white,
                          cursorHeight: 20,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            fillColor: appColor,
                            filled: true,
                            hintStyle:
                                getstyle(color: Colors.white, fontsize: 16),
                            hintText: "Enter your mobile number",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: appColor)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: appColor)),
                          )),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                height: size.height * .06,
                width: size.width * .8,
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        showLoadingAnimation(context);
                        await otpservice.sendOtp(_phone.text).then((value) {
                          value.fold((l) {
                            Navigator.pop(context);
                            showApiRequestErrorSnackBar(l.message);
                          },
                              (r) => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OtpVerify(phno: _phone.text)),
                                  (route) => false));
                        });
                      }
                    },
                    style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                      backgroundColor: MaterialStateProperty.all(appColor),
                    ),
                    child: Text(
                      "Continue",
                      style: getstyle(color: Colors.white),
                    )),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
