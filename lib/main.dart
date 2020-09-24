import 'package:Flashcards/pages/homepage/HomePage.dart';
import 'package:Flashcards/utils/style/ColorPalette.dart';
import 'package:Flashcards/utils/style/CustomTextStyle.dart';
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
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
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
          selectedLabelStyle: CustomTextStyle.bodyText2,
          unselectedLabelStyle: CustomTextStyle.bodyText2,
          elevation: 20,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: ColorPalette.primaryColor,
          unselectedItemColor: ColorPalette.primaryColor,
          selectedIconTheme: IconThemeData(
            color: ColorPalette.secondaryColor,
          ),
          unselectedIconTheme: IconThemeData(
            color: ColorPalette.secondaryColor,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
