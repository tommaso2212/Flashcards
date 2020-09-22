import 'package:Flashcards/pages/homepage/HomePage.dart';
import 'package:Flashcards/utils/ColorPalette.dart';
import 'package:Flashcards/utils/CustomTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));
    CustomTextStyle(window);
    return MaterialApp(
      title: 'Flashcard',
      theme: ThemeData(
        textTheme: TextTheme(
          headline4: CustomTextStyle.headline4,
          headline5: CustomTextStyle.headline5,
          headline6: CustomTextStyle.headline6,
          subtitle1: CustomTextStyle.subTitle1,
          subtitle2: CustomTextStyle.subTitle2,
          bodyText1: CustomTextStyle.bodyText1,
          bodyText2: CustomTextStyle.bodyText2,
          caption: CustomTextStyle.caption,
        ),
        primaryColor: ColorPalette.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedIconTheme: IconThemeData(
            color: ColorPalette.primaryColor,
          ),
          unselectedIconTheme: IconThemeData(
            color: ColorPalette.grey,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}