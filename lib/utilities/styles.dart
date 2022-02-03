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
  backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
);

RoundedRectangleBorder kShape20 = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(20),
);
