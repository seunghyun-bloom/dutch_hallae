import 'package:flutter/material.dart';

const kAppBarStyle = AppBarTheme(
  color: Colors.transparent,
  foregroundColor: Colors.black,
  elevation: 0,
  centerTitle: true,
  titleTextStyle: TextStyle(
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontSize: 20,
  ),
);

ButtonStyle kRedOutlinedButtonStyle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all(Colors.red),
);

BoxDecoration kDrawerHeaderStyle = const BoxDecoration(
  color: Pantone.cloudDancer,
  borderRadius: BorderRadius.only(
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

InputDecoration kTextFieldStyle = InputDecoration(
  prefixIcon: const Icon(Icons.search),
  hintText: '검색 / 직접 입력',
  filled: true,
  fillColor: Colors.grey.shade200,
  contentPadding: EdgeInsets.zero,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide.none,
  ),
);

TextStyle bold20 = const TextStyle(fontWeight: FontWeight.w700, fontSize: 20);

TextStyle whiteText = const TextStyle(color: Colors.white);

class Palette {
  static const MaterialColor basicBlue = MaterialColor(
    0xff3F68A7,
    <int, Color>{
      50: Color(0xff3F68A7), //10%
      100: Color(0xff3F68A7), //20%
      200: Color(0xff3F68A7), //30%
      300: Color(0xff3F68A7), //40%
      400: Color(0xff3F68A7), //50%
      500: Color(0xff3F68A7), //60%
      600: Color(0xff3F68A7), //70%
      700: Color(0xff3F68A7), //80%
      800: Color(0xff3F68A7), //90%
      900: Color(0xff3F68A7), //100%
    },
  );
  static const MaterialColor basicYellow = MaterialColor(
    0xffFFE072,
    <int, Color>{
      50: Color(0xffFFE072), //10%
      100: Color(0xffFFE072), //20%
      200: Color(0xffFFE072), //30%
      300: Color(0xffFFE072), //40%
      400: Color(0xffFFE072), //50%
      500: Color(0xffFFE072), //60%
      600: Color(0xffFFE072), //70%
      700: Color(0xffFFE072), //80%
      800: Color(0xffFFE072), //90%
      900: Color(0xffFFE072), //100%
    },
  );
}

class Pantone {
  static const MaterialColor veryPeri = MaterialColor(
    0xff6667ab,
    <int, Color>{
      50: Color(0xff6667ab), //10%
      100: Color(0xff6667ab), //20%
      200: Color(0xff6667ab), //30%
      300: Color(0xff6667ab), //40%
      400: Color(0xff6667ab), //50%
      500: Color(0xff6667ab), //60%
      600: Color(0xff6667ab), //70%
      700: Color(0xff6667ab), //80%
      800: Color(0xff6667ab), //90%
      900: Color(0xff6667ab), //100%
    },
  );
  static const MaterialColor volcanicGalss = MaterialColor(
    0xff615c61,
    <int, Color>{
      50: Color(0xff615c61), //10%
      100: Color(0xff615c61), //20%
      200: Color(0xff615c61), //30%
      300: Color(0xff615c61), //40%
      400: Color(0xff615c61), //50%
      500: Color(0xff615c61), //60%
      600: Color(0xff615c61), //70%
      700: Color(0xff615c61), //80%
      800: Color(0xff615c61), //90%
      900: Color(0xff615c61), //100%
    },
  );
  static const MaterialColor whiteSand = MaterialColor(
    0xffdbd5d1,
    <int, Color>{
      50: Color(0xffdbd5d1), //10%
      100: Color(0xffdbd5d1), //20%
      200: Color(0xffdbd5d1), //30%
      300: Color(0xffdbd5d1), //40%
      400: Color(0xffdbd5d1), //50%
      500: Color(0xffdbd5d1), //60%
      600: Color(0xffdbd5d1), //70%
      700: Color(0xffdbd5d1), //80%
      800: Color(0xffdbd5d1), //90%
      900: Color(0xffdbd5d1), //100%
    },
  );
  static const MaterialColor cloudDancer = MaterialColor(
    0xffF0EEE9,
    <int, Color>{
      50: Color(0xffF0EEE9), //10%
      100: Color(0xffF0EEE9), //20%
      200: Color(0xffF0EEE9), //30%
      300: Color(0xffF0EEE9), //40%
      400: Color(0xffF0EEE9), //50%
      500: Color(0xffF0EEE9), //60%
      600: Color(0xffF0EEE9), //70%
      700: Color(0xffF0EEE9), //80%
      800: Color(0xffF0EEE9), //90%
      900: Color(0xffF0EEE9), //100%
    },
  );
}
