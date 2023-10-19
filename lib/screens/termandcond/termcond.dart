import 'package:flutter/material.dart';
import 'package:water_order/utils/colors.dart';
import 'package:water_order/widget/appbar.dart';

class TermsAndCond extends StatefulWidget {
  const TermsAndCond({super.key});

  @override
  State<TermsAndCond> createState() => _TermsAndCondState();
}

class _TermsAndCondState extends State<TermsAndCond> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appbar("Term and Conditions"),
      body: Container(
        margin: EdgeInsets.only(
            top: size.height * .03,
            left: size.width * .02,
            right: size.width * .02),
        width: size.width,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Terms & Conditions",
              style: getstyle(fontsize: 25, fontweight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
