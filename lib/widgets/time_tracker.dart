import 'package:flutter/material.dart';
import 'package:time_tracker/shared/theme.dart';

class TimeTracker extends StatelessWidget {
  const TimeTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 220,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: FractionalOffset(.1, 0),
          end: FractionalOffset(0, .9),
          colors: [
            Color(0xffFFFFFF),
            Color(0xff7012CE),
          ],
        ),
      ),
    );
  }
}
