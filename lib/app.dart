import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_flutter/core/localization/app_localization_delegate.dart';
import 'package:task_flutter/core/them/them_app.dart';
import 'package:task_flutter/features/splash/splash_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en'); 
 // الافتراضي إنجليزي
  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Task',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData(context),
      locale: _locale,
  supportedLocales: const [
    Locale('en'),
    Locale('ar'),
  ],
  localizationsDelegates: const [
    AppLocalizationDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
      home: SplashScreen(),
    );
  }
}