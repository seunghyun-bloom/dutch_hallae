import 'package:dutch_hallae/firebase/social_login/email_login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailLoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  EmailLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이메일 로그인'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: FaIcon(
                FontAwesomeIcons.moneyBillWave,
                size: 100,
                color: Colors.green,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 30.w),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: '이메일', hintText: 'abc123@gmail.com'),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 30.w),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    labelText: '비밀번호', hintText: '********'),
                obscureText: true,
              ),
            ),
            ElevatedButton(
              child: const Text('로그인'),
              onPressed: () => createWithEmail(
                  email: _emailController.text,
                  password: _passwordController.text),
            ),
            OutlinedButton(onPressed: (){
              print()
            }, child: Text('verifyed'))
          ],
        ),
      ),
    );
  }
}
