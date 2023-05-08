import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:time_tracker/shared/theme.dart';

import '../view_models/task_models.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  bool isDay = true;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: margin, right: margin, top: 30),
        child: Column(
          children: [
            // NOTE:: START CODE AND TITLE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, '/nav-bottom'),
                    child: SvgPicture.asset('assets/icon_arrow_back.svg',
                        width: 24)),
                Center(
                  child: Text(
                    'My Productivity',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Container(),
              ],
            ),
            // END CODE
            const SizedBox(height: 42),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  width: 174,
                  height: 132,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: whiteColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(7),
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: greenColor,
                            ),
                            child: SvgPicture.asset('assets/icon_check.svg'),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 80,
                            child: Text(
                              'Task Completed',
                              overflow: TextOverflow.fade,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontWeight: light,
                                      fontSize: 14,
                                      color: darkBlackColor),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        taskModelsDays.length.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: darkBlackColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  width: 174,
                  height: 132,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: whiteColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(7),
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: blueColor,
                            ),
                            child:
                                SvgPicture.asset('assets/icon_stopwatch.svg'),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 80,
                            child: Text(
                              'Time Duration',
                              overflow: TextOverflow.fade,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontWeight: light,
                                      fontSize: 14,
                                      color: darkBlackColor),
                            ),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          text: '1',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: darkBlackColor),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'h',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: darkBlackColor.withOpacity(.4),
                                      fontSize: 20,
                                    )),
                            TextSpan(
                                text: ' 46',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: darkBlackColor)),
                            TextSpan(
                                text: 'm',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: darkBlackColor.withOpacity(.4),
                                      fontSize: 20,
                                    )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // NOTE:: START CODE BUTTON
            const SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.all(4),
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: lavenderBlueColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isDay = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: isDay == true ? whiteColor : Colors.transparent,
                      ),
                      child: Text('Day',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontWeight: light,
                                  fontSize: 16,
                                  color: isDay == true
                                      ? darkBlackColor
                                      : grayColor)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isDay = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: isDay == false ? whiteColor : Colors.transparent,
                      ),
                      child: Text('Week',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontWeight: light,
                                  fontSize: 16,
                                  color: isDay == false
                                      ? darkBlackColor
                                      : grayColor)),
                    ),
                  ),
                ],
              ),
            ),
            // END CODE BUTTON
            const SizedBox(height: 32),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
                width: MediaQuery.of(context).size.width * 1.2,
                height: 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: whiteColor,
                ),
                child: LineChart(
                  mainData(),
                ),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: margin, vertical: 24),
            //   width: double.infinity,
            //   height: 312,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(16),
            //     color: whiteColor,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  List<Color> gradientColors = const [Color(0xff1CD8D2), Color(0xff93EDC7)];
  late TextStyle styleTitle;
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    styleTitle = Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 18,
          fontWeight: light,
          color: blackColor.withOpacity(.4),
        );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('8AM', style: styleTitle);
        break;
      case 1:
        text = Text('9AM', style: styleTitle);
        break;
      case 2:
        text = Text('10AM', style: styleTitle);
        break;
      case 3:
        text = Text('11AM', style: styleTitle);
        break;
      case 4:
        text = Text('12AM', style: styleTitle);
        break;
      case 5:
        text = Text('1PM', style: styleTitle);
        break;
      case 6:
        text = Text('2PM', style: styleTitle);
        break;
      default:
        text = Text('', style: styleTitle);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Container(
        margin: EdgeInsets.only(top: margin),
        width: 50,
        height: 28,
        child: Center(child: text),
      ),
    );
  }

  int number = 0;
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    styleTitle = Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 13,
          fontWeight: light,
          color: blackColor.withOpacity(.4),
        );
    String text;
    if (value.toInt() >= 0 && value.toInt() < 30) {
      text = '0h30m';
    } else if (value.toInt() >= 30 && value.toInt() < 60) {
      text = '1h0m';
    } else if (value.toInt() >= 60 && value.toInt() < 90) {
      text = '1h30m';
    } else if (value.toInt() >= 90 && value.toInt() < 120) {
      text = '2h0m';
    } else if (value.toInt() >= 120 && value.toInt() < 150) {
      text = '2h30m';
    } else if (value.toInt() >= 150 && value.toInt() <= 180) {
      text = '3h0m';
    } else {
      text = '0h0m';
    }

    return Container(
      margin: EdgeInsets.only(right: margin),
      width: 60,
      height: 30,
      child: Text(
        text,
        style: styleTitle,
        textAlign: TextAlign.left,
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
        gridData: FlGridData(
          show: false,
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              interval: 30,
              reservedSize: 70,
              showTitles: true,
              getTitlesWidget: leftTitleWidgets,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              interval: 1,
              showTitles: true,
              reservedSize: 50,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        minX: 0,
        maxX: 7,
        minY: 0,
        maxY: 180,
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            tooltipBgColor: Colors.transparent,
          ),
          getTouchedSpotIndicator:
              (LineChartBarData barData, List<int> spotIndexes) {
            return spotIndexes.map((index) {
              return TouchedSpotIndicatorData(
                FlLine(
                  color: purpleColor,
                  strokeWidth: 2,
                  dashArray: [5, 5],
                ),
                FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 4,
                      color: whiteColor,
                      strokeColor: const Color(0xff7012CE),
                      strokeWidth: 7,
                    );
                  },
                ),
              );
            }).toList();
          },
        ),
        lineBarsData: [lineChartBarData]);
  }
}

LineChartBarData lineChartBarData = LineChartBarData(
  spots: const [
    FlSpot(0, 0),
    FlSpot(1, 1),
    FlSpot(2, 69),
    FlSpot(3, 40),
    FlSpot(4, 20),
    FlSpot(5, 90),
    FlSpot(6, 150),
  ],
  dotData: FlDotData(
    show: false,
  ),
  isCurved: true,
  gradient: LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xff7012CE),
      const Color(0xff7012CE).withOpacity(.6),
    ],
  ),
  barWidth: 4,
  isStrokeCapRound: true,
);
