import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String platform;
  final Color color;
  final dynamic onTap;
  Color? fontColor = Colors.black;

  LoginButton({
    Key? key,
    required this.platform,
    required this.color,
    required this.onTap,
    this.fontColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 350,
        child: ElevatedButton(
          child: ListTile(
            leading:
                Image.asset('assets/images/${platform.toLowerCase()}_logo.png'),
            title: Text(
              '$platform로 시작하기',
              style: TextStyle(color: fontColor),
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
