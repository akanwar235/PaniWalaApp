import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color appColor = Colors.green.shade400;


appstyle() {
  return TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      fontFamily: GoogleFonts.poppins().fontFamily);
}

getstyle(
    {Color color = Colors.black,
    double fontsize = 18,
    FontWeight fontweight = FontWeight.normal}) {
  return TextStyle(
      color: color,
      fontSize: fontsize,
      fontWeight: fontweight,
      fontFamily: GoogleFonts.poppins().fontFamily);
}
