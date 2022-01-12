import 'package:dutch_hallae/firebase/firebase_initializer.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dutch-pay calculator with convenience functions.',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirebaseInitializer(),
    );
  }
}

//TODO: solve the problem of Android debug (13 Jan 2022)
//TODO: solve Facebook Login error (consider using web version) (13 Jan 2022)
