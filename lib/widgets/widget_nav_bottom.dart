import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/shared/theme.dart';

import '../screens/add_timer.dart';
import '../screens/home_page.dart';
import '../screens/report_page.dart';

class NavBottom extends StatefulWidget {
  const NavBottom({super.key});

  @override
  State<NavBottom> createState() => _NavBottomState();
}

class _NavBottomState extends State<NavBottom> {
  final List<Widget> _pages = const [
    HomePage(),
    AddTimer(),
    ReportPage(),
  ];
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_activeIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 90,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30),
            ),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                  blurRadius: 100,
                  color: const Color(0xff828282).withOpacity(.15),
                  offset: const Offset(0, -8)),
            ]),
        child: AnimatedBottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          icons: const [
            Icons.access_time_filled_rounded,
            Icons.add,
            Icons.pie_chart_rounded,
          ],
          gapLocation: GapLocation.none,
          inactiveColor: grayColor,
          activeColor: blackColor,
          iconSize: 32,
          activeIndex: _activeIndex,
          onTap: (index) {
            setState(() {
              print(index);
              _activeIndex = index;
            });
          },
        ),
      ),
    );
  }
}
