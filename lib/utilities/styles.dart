import 'package:flutter/material.dart';

const kAppBarStyle = AppBarTheme(
  color: Colors.white,
  foregroundColor: Colors.black,
  elevation: 1,
  centerTitle: true,
);

ButtonStyle kRedOutlinedButtonStyle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all(Colors.red),
);

BoxDecoration kDrawerHeaderStyle = BoxDecoration(
  color: Colors.indigo.shade100,
  borderRadius: const BorderRadius.only(
    bottomLeft: Radius.circular(40),
    bottomRight: Radius.circular(40),
  ),
);

ButtonStyle kRoundedButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
);

RoundedRectangleBorder kShape20 = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(20),
);

class Palette {
  static const MaterialColor veryPeri = MaterialColor(
    0xff6667ab,
    <int, Color>{
      50: Color(0xffce5641), //10%
      100: Color(0xffb74c3a), //20%
      200: Color(0xffa04332), //30%
      300: Color(0xff89392b), //40%
      400: Color(0xff733024), //50%
      500: Color(0xff6667ab), //60%
      600: Color(0xff451c16), //70%
      700: Color(0xff2e130e), //80%
      800: Color(0xff170907), //90%
      900: Color(0xff000000), //100%
    },
  );
}
