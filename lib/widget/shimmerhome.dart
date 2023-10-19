import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:water_order/widget/skelton.dart';

Widget shimmerHome(Size size) {
  return Shimmer.fromColors(
    period: const Duration(milliseconds: 900),
    baseColor: Colors.black,
    highlightColor: const Color.fromARGB(255, 176, 174, 174),
    // child: skelton(400, 400),
    child: Padding(
      padding: EdgeInsets.only(top: size.height * .035),
      child: Column(
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

          // scrollbar
          skelton(size.height * .04, size.width * .9),

          const SizedBox(
            height: 10,
          ),

          // carousel
          skelton(size.height * .25, size.width * .9, radius: 8),

          const SizedBox(
            height: 10,
          ),
          // categories
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              skelton(size.height * .04, size.width * .4),
              skelton(size.height * .04, size.width * .4)
            ],
          ),

          const SizedBox(
            height: 10,
          ),

          // caategories items
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              skelton(size.height * .2, size.width * .45, radius: 8),
              skelton(size.height * .2, size.width * .45, radius: 8)
            ],
          ),

          // product
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              skelton(size.height * .04, size.width * .4),
              skelton(size.height * .04, size.width * .4)
            ],
          ),

          const SizedBox(
            height: 10,
          ),

          // product items
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              skelton(size.height * .145, size.width * .45, radius: 8),
              skelton(size.height * .145, size.width * .45, radius: 8)
            ],
          ),
        ],
      ),
    ),
  );
}
