import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String platform;
  final Color color;
  final dynamic onTap;

  const LoginButton({
    Key? key,
    required this.platform,
    required this.color,
    required this.onTap,
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
            title: Text('$platform로 시작하기'),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            overlayColor: MaterialStateProperty.all(Colors.purple.shade100),
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
