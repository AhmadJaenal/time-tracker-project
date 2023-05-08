import 'package:flutter/material.dart';
import 'package:time_tracker/screens/home_page.dart';
import 'package:time_tracker/screens/report_page.dart';
import 'package:time_tracker/widgets/widget_nav_bottom.dart';

import 'shared/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffFAFAFF),
        fontFamily: 'Rubik',
        primaryColor: darkBlackColor,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 24.0,
            fontWeight: semiBold,
          ),
          bodyLarge: TextStyle(
            fontSize: 32.0,
            fontWeight: medium,
            color: whiteColor,
          ),
          bodyMedium: TextStyle(
            fontSize: 16.0,
            fontWeight: regular,
          ),
          bodySmall: TextStyle(
            fontSize: 12.0,
            fontWeight: regular,
          ),
        ),
      ),
      routes: {
        '/': (context) => const NavBottom(),
        '/home-page': (context) => const HomePage(),
        '/nav-bottom': (context) => const NavBottom(),
        '/report-page': (context) => const ReportPage(),
      },
    );
  }
}
