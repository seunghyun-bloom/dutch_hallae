import 'package:dutch_hallae/pages/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseInitializer extends StatelessWidget {
  const FirebaseInitializer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('firebase load fail'),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MainPage();
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
