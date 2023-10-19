import 'package:flutter/material.dart';
import 'package:water_order/utils/colors.dart';

appbar(String text) {
  return AppBar(
    centerTitle: true,
    backgroundColor: appColor,
    title: Text(
      text,
      style: appstyle(),
    ),
  );
}
