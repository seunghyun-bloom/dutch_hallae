import 'package:dutch_hallae/firebase/firebase_initializer.dart';
import 'package:dutch_hallae/utilities/styles.dart';
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
        primaryColor: Colors.white,
        primarySwatch: Colors.blueGrey,
        appBarTheme: kAppBarStyle,
      ),
      home: const FirebaseInitializer(),
    );
  }
}
