import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_order/models/verify_otp_model.dart';
import 'package:water_order/screens/about/about.dart';
import 'package:water_order/screens/faqs/faq.dart';
import 'package:water_order/screens/helpandsupport/helpsupport.dart';
import 'package:water_order/screens/home/home.dart';
import 'package:water_order/screens/orders/myorders.dart';
import 'package:water_order/screens/profile/editprofile.dart';
import 'package:water_order/screens/termandcond/termcond.dart';
import 'package:water_order/utils/colors.dart';
import 'package:water_order/utils/global.dart';
import 'package:water_order/widget/shimmerprofile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isloading = true;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isloading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final VerifyOtpModel? userData = VarGlobal.userData;
    final AccountDetailModel userAccountDetails =
        userData!.accountDetails!.accountDetailList.first;

    return SizedBox(
      height: size.height,
      child: Column(
        children: [
          Container(
            color: appColor,
            padding: EdgeInsets.only(
                top: size.height * .07,
                right: size.width * .03,
                left: size.width * .03,
                bottom: size.height * .03),
            margin: EdgeInsets.only(bottom: size.height * .02),
            child: _isloading
                ? shimmerProfile(size)
                : Column(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EditProfile()));
                          },
                          child: const Icon(
                            Icons.edit,
                            size: 27,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: size.width * .15,
                            child: Image.asset("assets/images/otp.gif"),
                          ),
                          const Spacer(
                            flex: 2,
                          ),
                          SizedBox(
                            width: size.width * .62,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${userAccountDetails.firstName} ${userAccountDetails.lastName}",
                                  style: getstyle(
                                      color: Colors.white,
                                      fontsize: 25,
                                      fontweight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  userAccountDetails.email,
                                  style: getstyle(
                                      color: Colors.white,
                                      fontsize: 16,
                                      fontweight: FontWeight.w400),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  "+91 ${userAccountDetails.mobile.toString()}",
                                  style: getstyle(
                                      color: Colors.white,
                                      fontsize: 16,
                                      fontweight: FontWeight.w400),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
          profileOption(
              context, "My Orders", Icons.card_membership, const MyOrders()),
          profileOption(context, "About", Icons.info_rounded, const About()),
          profileOption(context, "Offers", Icons.countertops_outlined,
              const HomeScreen()),
          profileOption(
              context, "Coupons", Icons.countertops, const HomeScreen()),
          profileOption(context, "Terms and Conditions", Icons.assignment_sharp,
              const TermsAndCond()),
          profileOption(
              context, "FAQs", Icons.question_mark_outlined, const FAQs()),
          profileOption(context, "Help & Support", Icons.headset_mic_outlined,
              const HelpSupport()),
        ],
      ),
    );
  }
}

Widget profileOption(
    BuildContext context, String text, IconData icon, Widget screen) {
  return ListTile(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
    },
    leading: Icon(
      icon,
      color: appColor,
    ),
    title: Text(
      text,
      style: getstyle(fontweight: FontWeight.w500),
    ),
  );
}
