import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyleDecoration {
  /// list grey text
  static TextStyle grey(context,
      {double fontSize = 12.0, Color clr = const Color(0xff929292)}) {
    return GoogleFonts.poppins(
        textStyle: TextStyle(color: const Color(0xff929292), fontSize: 13));
  }


  static TextStyle hintTextColor(context,
      {double fontSize = 12.0, Color clr = const Color(0xff929292)}) {
    return GoogleFonts.poppins(
        textStyle: TextStyle(color: const Color(0xff778EB8), fontSize: 13));
  }
}