import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:water_order/widget/skelton.dart';

Widget shimmerProfile(Size size) {
  return Shimmer.fromColors(
    period: const Duration(milliseconds: 900),
    baseColor: const Color.fromARGB(255, 255, 255, 255),
    highlightColor: const Color.fromARGB(255, 233, 231, 231),
    // child: skelton(400, 400),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // edit profile
        skelton(size.height * .02, size.width * .06,
            radius: 2, color: const Color.fromARGB(255, 204, 202, 202)),

        const SizedBox(
          height: 0,
        ),

        // details
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              radius: 57.7,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                skelton(size.height * .03, size.width * .4,
                    color: const Color.fromARGB(255, 253, 252, 252)),
                skelton(size.height * .02, size.width * .6,
                    color: const Color.fromARGB(255, 255, 255, 255)),
                skelton(size.height * .02, size.width * .6,
                    color: const Color.fromARGB(255, 255, 255, 255)),
              ],
            )
          ],
        )
      ],
    ),
  );
}
