import 'package:flutter/material.dart';

Container skelton(double height, double width,
    {double radius = 4.0, Color color = Colors.black12}) {
  return Container(
    margin: const EdgeInsets.all(6),
    height: height,
    width: width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius), color: color),
  );
}
