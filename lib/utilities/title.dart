import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  String title;
  double top;
  double bottom;
  TitleText({
    Key? key,
    required this.title,
    this.top = 20,
    this.bottom = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: top, bottom: bottom),
      child: Text(
        title,
        style: bold20,
      ),
    );
  }
}
