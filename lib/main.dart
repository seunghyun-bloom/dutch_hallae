import 'package:dutch_hallae/firebase/firebase_initializer.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'getx/binding/init_bindings.dart';

void main() {
  KakaoSdk.init(nativeAppKey: '7bc862771df0af1c0179e1bc4a641a28');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ko')],
        locale: const Locale('ko'),
        debugShowCheckedModeBanner: false,
        title: 'Dutch-pay calculator with convenience functions.',
        theme: ThemeData(
          fontFamily: 'AppleSDGothic',
          primaryColor: Colors.white,
          primarySwatch: Pantone.veryPeri,
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
