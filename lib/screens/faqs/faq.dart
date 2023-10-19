import 'package:flutter/material.dart';
import 'package:water_order/utils/colors.dart';
import 'package:water_order/widget/appbar.dart';

class FAQs extends StatefulWidget {
  const FAQs({super.key});

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appbar("FAQs"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: size.height * .02,
            ),
            Text(
              "How Can We Help You ?",
              style: getstyle(fontsize: 20, fontweight: FontWeight.w700),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: size.height * .05,
                  width: size.width * .3,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                      ),
                      child: Text(
                        "Payments",
                        style: getstyle(color: Colors.white, fontsize: 16),
                      )),
                ),
                SizedBox(
                  height: size.height * .05,
                  width: size.width * .3,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                      ),
                      child: Text(
                        "Coupons",
                        style: getstyle(color: Colors.white, fontsize: 16),
                      )),
                ),
                SizedBox(
                  height: size.height * .05,
                  width: size.width * .3,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                      ),
                      child: Text(
                        "Delivery",
                        style: getstyle(color: Colors.white, fontsize: 16),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
