import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:time_tracker/shared/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../view_models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String titleLastOpen = 'Do the task';
String timeLastOpen = '00:00:00';
int timeSeconds = 0;
int index = 0;

void _updateTimer(int index, int time) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  taskModels[index]['duration'] = time;
  String jsonData = jsonEncode(taskModels);
  prefs.setString('data', jsonData);
}

Future<List<dynamic>> getData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? jsonData = prefs.getString('data');
  List<dynamic> jsonDecode = json.decode(jsonData!);
  return jsonDecode;
}

void lastTask(String titleLastOpen, String timeLastOpen, int duration) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('title', titleLastOpen);
  prefs.setString('durationInString', timeLastOpen);
  prefs.setInt('durationInSeconds', duration);
}

Future<String> getLastTitle() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('title') ?? 'Do the task';
}

Future<String> getLastDuration() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('durationInString') ?? '00:00:00';
}

Future<int> getDuration() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('durationInSeconds') ?? 0;
}

int indexRandom() {
  Random random = Random();
  int randomNumber = random.nextInt(5);
  return randomNumber;
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: margin),
            child: Column(
              children: [
                const SizedBox(height: 42),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {},
                        child: Text('Task',
                            style: Theme.of(context).textTheme.titleLarge)),
                    Image.asset('assets/icon_more.png', width: 24),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                // NOTE :: TIME CARD CODE
                FutureBuilder<String>(
                  future: getLastDuration(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return snapshot.hasData.toString() == 'Do the task'
                                ? Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: purpleColor,
                                    ),
                                  )
                                : PopUpTimeTracker(
                                    titleTask: titleLastOpen,
                                    descTask: 'Personal',
                                    time: timeSeconds,
                                    index: index,
                                    color: greenColor,
                                  );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 26),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: darkBlackColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  snapshot.data.toString(),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const Spacer(),
                                Image.asset(
                                  'assets/icon_right_arrow.png',
                                  width: 24,
                                  color: whiteColor,
                                )
                              ],
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icon_loading.png',
                                  width: 16,
                                ),
                                const SizedBox(width: 12),
                                FutureBuilder<String>(
                                  future: getLastDuration(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<String> data) {
                                    return Text(
                                      data.data.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: whiteColor),
                                    );
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // END TIME CARD CODE
                const SizedBox(height: 32),
                // NOTE:: START CODE TITLE
                Row(
                  children: [
                    Text('Today',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 20)),
                    const Spacer(),
                    Text('See All',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                // END CODE TITLE
                const SizedBox(height: 16),
                // NOTE:: START CODE LIST TASK
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .50,
                  child: ListView.builder(
                    itemCount: taskModels.length,
                    itemBuilder: (context, index) {
                      getData();
                      return CardWidget(
                        titleTask: taskModels[index]['title'],
                        descTask1: taskModels[index]['type'],
                        descTask2: taskModels[index]['description'],
                        time: taskModels[index]['duration'],
                        index: index,
                        icon: taskModels[index]['icon'],
                        colorDesc1: randomColor[indexRandom()],
                        colorDesc2: randomColor[indexRandom()],
                      );
                    },
                  ),
                ),
                // END CODE LIST TASK
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//NOTE:: START CODE WIDGET CARDWIDGET
class CardWidget extends StatefulWidget {
  final String titleTask;
  final String descTask1;
  final String descTask2;
  final String icon;
  final int time;
  final int index;
  final Color colorDesc1;
  final Color colorDesc2;
  const CardWidget({
    required this.titleTask,
    required this.descTask1,
    required this.descTask2,
    required this.colorDesc1,
    required this.colorDesc2,
    required this.index,
    required this.time,
    required this.icon,
    super.key,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  String get timerString {
    int hours = (widget.time / 3600).floor();
    int minutes = ((widget.time / 60) % 60).floor();
    int seconds = (widget.time % 60).floor();
    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: widget.index == 0
          ? const EdgeInsets.only(top: 0)
          : const EdgeInsets.only(top: 16),
      height: 84,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: whiteColor,
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.colorDesc2,
            ),
            child: SvgPicture.asset(
              'assets/${widget.icon}',
              fit: BoxFit.none,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.titleTask,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: widget.colorDesc1.withOpacity(.15),
                    ),
                    child: Text(
                      widget.descTask1,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: widget.colorDesc1),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: widget.colorDesc2.withOpacity(.15),
                    ),
                    child: Text(
                      widget.descTask2,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: widget.colorDesc2),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                timerString,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: grayColor),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    titleLastOpen = widget.titleTask;
                    timeLastOpen = timerString;
                    timeSeconds = widget.time;
                    index = widget.index;
                    lastTask(
                      widget.titleTask,
                      timerString,
                      timeSeconds,
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PopUpTimeTracker(
                          titleTask: widget.titleTask,
                          descTask: widget.descTask2,
                          time: widget.time,
                          index: widget.index,
                          color: widget.colorDesc2,
                        );
                      },
                    );
                  });
                },
                child: SvgPicture.asset('assets/icon_play.svg', width: 26),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// END CODE CARDWIDGET

// NOTE:: START CODE POPUPTIMETRACKER WIDGET
class PopUpTimeTracker extends StatefulWidget {
  final String titleTask;
  final String descTask;
  final int time;
  final int index;
  final Color color;
  const PopUpTimeTracker({
    super.key,
    required this.titleTask,
    required this.descTask,
    required this.time,
    required this.index,
    required this.color,
  });

  @override
  State<PopUpTimeTracker> createState() => _PopUpTimeTrackerState();
}

class _PopUpTimeTrackerState extends State<PopUpTimeTracker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  late int _counter;
  Timer? _timer;
  bool _isPaused = false;

  String get timerString {
    int hours = (_counter / 3600).floor();
    int minutes = ((_counter / 60) % 60).floor();
    int seconds = (_counter % 60).floor();
    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (timer) {
        setState(() {
          if (_counter < 1) {
            _timer!.cancel();
          } else {
            _counter -= 1;
          }
        });
      },
    );
  }

  void pauseTimer() {
    _timer!.cancel();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _counter = widget.time;
    _offsetAnimation = Tween<Offset>(
            begin: const Offset(0, 1.5), end: const Offset(0.0, 0.0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        _controller.value -=
            details.primaryDelta! / MediaQuery.of(context).size.height;
      },
      onVerticalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity! < 0) {
        } else if (details.primaryVelocity! > 0) {
          Navigator.pop(context);
          setState(() {
            _updateTimer(widget.index, _counter);
            getData();
          });
        }
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SlideTransition(
          position: _offsetAnimation,
          child: Container(
            width: double.infinity,
            height: (MediaQuery.of(context).size.height - 50),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
              color: whiteColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(height: margin),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: purpleColor.withOpacity(.2)),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.titleTask,
                          style: Theme.of(context).textTheme.titleLarge),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: widget.color.withOpacity(.15),
                        ),
                        child: Text(
                          widget.descTask,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: widget.color),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 150),
                  Text(
                    // widget.time,
                    timerString,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: blackColor, fontSize: 48),
                  ),
                  const SizedBox(height: 210),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPaused = !_isPaused;
                                  _isPaused ? startTimer() : pauseTimer();
                                });
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: lavenderBlueColor,
                                ),
                                child: SvgPicture.asset(
                                  _isPaused
                                      ? 'assets/icon_pause.svg'
                                      : 'assets/icon_play.svg',
                                  width: 24,
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _isPaused ? 'Pause' : 'Play',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _updateTimer(widget.index, _counter);
                                  getData();
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: lavenderBlueColor,
                                ),
                                child: SvgPicture.asset(
                                  'assets/icon_quit.svg',
                                  width: 24,
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Quit',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// END CODE POPUPTIMETRACKER WIDGET
