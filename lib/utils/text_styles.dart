import 'package:flutter/material.dart';

class TextStyles {
  static const smallTextStyle = TextStyle(fontSize: 16, color: Colors.white);
  static const mediumTextStyle = TextStyle(fontSize: 20, color: Colors.black);
  static const bigTextStyle = TextStyle(fontSize: 25, color: Colors.white);
  static const boldBigText =
      TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black);
  static const bigText = TextStyle(
      color: Color(0xff2B435D),
      fontSize: 35,
      fontWeight: FontWeight.bold,
      fontFamily: 'Avenir');
  static const smallText =
      TextStyle(color: Color(0xff2B435D), fontSize: 16, fontFamily: 'Avenir');

  static const mediumText = TextStyle(
      color: Color(0xff2B435D),
      fontWeight: FontWeight.bold,
      fontSize: 24,
      fontFamily: 'Avenir');

  static const tabText1 = TextStyle(
      color: Color(0xff2B435D),
      fontWeight: FontWeight.bold,
      fontSize: 18,
      fontFamily: 'Avenir');
  static const tabText2 = TextStyle(
      color: Color(0xff2B435D),
      fontWeight: FontWeight.bold,
      fontSize: 18,
      fontFamily: 'Avenir');

  static const textButton1 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: 'Avenir',
    color: Color(0xff2B435D),
    decorationColor: Color(0xff2B435D),
    decoration: TextDecoration.underline,
  );
  static const textButton2 =
      TextStyle(fontSize: 20, color: Colors.black26, fontFamily: 'Avenir');
}
