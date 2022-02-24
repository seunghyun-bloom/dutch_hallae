import 'package:dutch_hallae/firebase/firebase_initializer.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'getx/binding/init_bindings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dutch-pay calculator with convenience functions.',
        theme: ThemeData(
          primaryColor: Colors.white,
          primarySwatch: Palette.veryPeri,
          appBarTheme: kAppBarStyle,
          useMaterial3: true,
        ),
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
        initialBinding: InitBinding(),
        home: const FirebaseInitializer(),
      ),
    );
  }
}
