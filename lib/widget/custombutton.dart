import 'package:flutter/material.dart';
import 'package:water_order/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Size size;
  final VoidCallback onPressed;

  const CustomButton(
      {super.key,
      required this.size,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * .06,
      width: size.width * .8,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          splashFactory: InkSparkle.splashFactory,
          // overlayColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(appColor),

          // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //   RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(25.0),
          //   ),
          // ),
        ),
        child: Text(text,
            style: getstyle(
              color: Colors.white,
            )),
      ),
    );
  }
}
