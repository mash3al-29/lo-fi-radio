import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lo_fi_radio_app/shared/network/local/Cache_Helper.dart';
import 'package:lo_fi_radio_app/shared/styles/colors.dart';

ThemeData LightTheme = ThemeData(
  primarySwatch: ThemeColors.orange,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.black87,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    bodyText2: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 50,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: ThemeColors.orangeAccent,
    backgroundColor: Colors.white,
  ),
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.w800,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ThemeColors.orangeAccent,
        statusBarIconBrightness: Brightness.dark,
      ),
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.black,
        size: 15,
      )),
  fontFamily: 'Vcr',
);

ThemeData DarkTheme = ThemeData(
  splashColor: ThemeColors.button,
  brightness: Brightness.dark,
  primarySwatch: CacheHelper.GetData(key: 'color') == 0
      ? ThemeColors.teal
      : CacheHelper.GetData(key: 'color') == 1
          ? ThemeColors.purple
          : CacheHelper.GetData(key: 'color') == 2
              ? ThemeColors.yellow
              : CacheHelper.GetData(key: 'color') == 3
                  ? ThemeColors.blue
                  : CacheHelper.GetData(key: 'color') == 4
                      ? ThemeColors.orange
                      : CacheHelper.GetData(key: 'color') == 5
                          ? ThemeColors.red
                          : ThemeColors.teal,
  cardColor: ThemeColors.background,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: CacheHelper.GetData(key: 'color') == 0
          ? ThemeColors.teal
          : CacheHelper.GetData(key: 'color') == 1
              ? ThemeColors.purple
              : CacheHelper.GetData(key: 'color') == 2
                  ? ThemeColors.yellow
                  : CacheHelper.GetData(key: 'color') == 3
                      ? ThemeColors.blue
                      : CacheHelper.GetData(key: 'color') == 4
                          ? ThemeColors.orange
                          : CacheHelper.GetData(key: 'color') == 5
                              ? ThemeColors.red
                              : ThemeColors.teal,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    bodyText2: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),
  scaffoldBackgroundColor: ThemeColors.transparent,
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      backgroundColor: ThemeColors.transparent,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w800,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ThemeColors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 15,
      )),
  fontFamily: 'Vcr',
);
