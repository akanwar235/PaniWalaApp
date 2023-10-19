import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:water_order/widget/skelton.dart';

Widget shimmerProductDetail(Size size) {
  return Shimmer.fromColors(
    period: const Duration(milliseconds: 900),
    baseColor: Colors.black,
    highlightColor: const Color.fromARGB(255, 176, 174, 174),
    // child: skelton(400, 400),
    child: Padding(
      padding: EdgeInsets.only(
          top: size.height * .01,
          left: size.width * .03,
          right: size.width * .03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // address and notification
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              skelton(size.height * .03, size.width * .3),
              SizedBox(
                width: size.width * .2,
              ),
              skelton(size.height * .03, size.width * .3)
            ],
          ),

          const SizedBox(
            height: 10,
          ),

          // product image
          skelton(size.height * .35, size.width * .9, radius: 8),

          const SizedBox(
            height: 10,
          ),

          // Details
          skelton(size.height * .03, size.width * .5),
          skelton(size.height * .03, size.width * .4),
          skelton(size.height * .03, size.width * .4),

          const SizedBox(
            height: 10,
          ),

          // horizontal bar
          skelton(2, size.width),

          // description
          skelton(size.height * .04, size.width * .5),

          const SizedBox(
            height: 10,
          ),

          // description lines
          skelton(size.height * .03, size.width * .9),
          skelton(size.height * .03, size.width * .9),
          skelton(size.height * .03, size.width * .9),

          const SizedBox(
            height: 10,
          ),

          // bottom button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              skelton(size.height * .06, size.width * .4),
              skelton(size.height * .06, size.width * .4),
            ],
          )
        ],
      ),
    ),
  );
}
