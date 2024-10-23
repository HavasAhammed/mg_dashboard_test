import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mg_dashboard/ui/widgets/customText.dart';
import 'package:mg_dashboard/utils/colorConst.dart';
import 'package:mg_dashboard/utils/colorExtentions.dart';

class GraphView extends StatefulWidget {
  GraphView({
    super.key,
  });

  final Color barBackgroundColor =
      ColorConst.contentColorWhite.darken().withOpacity(0.3);
  final Color barColor = ColorConst.contentColorWhite;
  final Color touchedBarColor = ColorConst.contentColorGreen;

  @override
  State<StatefulWidget> createState() => GraphViewState();
}

class GraphViewState extends State<GraphView> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;
  List<double> graphDataList = [];
  DateTime today = DateTime.now();

  @override
  void initState() {
    graphDataList = [
      5,
      6.5,
      5,
      7.5,
      9,
      11.5,
      6.5,
      5,
      9,
      6,
      7,
      4,
    ];
    touchedIndex = today.month - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                'Monthly Amount',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textColor: ColorConst.primaryText,
              ),
              Row(
                children: [
                  // const Image(
                  //   image: AssetImage('assets/images/money-cash.png'),
                  //   height: 20,
                  // ),
                  const Icon(Icons.attach_money_outlined),
                  Text(
                    touchedIndex == -1 ? "0" : "${graphDataList[touchedIndex]}",
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: ColorConst.primaryText,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(
            height: 150,
            child: BarChart(
              mainBarData(),
            ),
          ),
        ),
      ],
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = ColorConst.borderColor,
    double width = 10,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor.darken(80))
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: findLargest(graphDataList),
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> get showingGroups => List.generate(12, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 5, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 5, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 9, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
          case 7:
            return makeGroupData(7, 5, isTouched: i == touchedIndex);
          case 8:
            return makeGroupData(8, 9, isTouched: i == touchedIndex);
          case 9:
            return makeGroupData(9, 6, isTouched: i == touchedIndex);
          case 10:
            return makeGroupData(10, 7, isTouched: i == touchedIndex);
          case 11:
            return makeGroupData(11, 4, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      // maxY: findLargest(showingGroups.map((e) => e.x).toList()),
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.center,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String month;
            switch (group.x) {
              case 0:
                month = 'Jan';
                break;
              case 1:
                month = 'Feb';
                break;
              case 2:
                month = 'Mar';
                break;
              case 3:
                month = 'Apr';
                break;
              case 4:
                month = 'May';
                break;
              case 5:
                month = 'Jun';
                break;
              case 6:
                month = 'Jul';
                break;
              case 7:
                month = 'Aug';
                break;
              case 8:
                month = 'Sep';
                break;
              case 9:
                month = 'Oct';
                break;
              case 10:
                month = 'Nov';
                break;
              case 11:
                month = 'Dec';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$month\n',
              const TextStyle(
                color: ColorConst.primaryText,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            touchedIndex = barTouchResponse!.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups,
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    var style = const TextStyle(
      fontSize: 10,
      color: ColorConst.mainTextColor2,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.8,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('JAN', style: style);
        break;
      case 1:
        text = Text('FEB', style: style);
        break;
      case 2:
        text = Text('MAR', style: style);
        break;
      case 3:
        text = Text('APR', style: style);
        break;
      case 4:
        text = Text('MAY', style: style);
        break;
      case 5:
        text = Text('JUN', style: style);
        break;
      case 6:
        text = Text('JUL', style: style);
        break;
      case 7:
        text = Text('AUG', style: style);
        break;
      case 8:
        text = Text('SEP', style: style);
        break;
      case 9:
        text = Text('OCT', style: style);
        break;
      case 10:
        text = Text('NOV', style: style);
        break;
      case 11:
        text = Text('DEC', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  double findLargest(List<dynamic>? arr) {
    if (arr != null) {
      double largest = arr[0];
      for (int i = 1; i < arr.length; i++) {
        if (arr[i] > largest) {
          largest = arr[i];
        }
      }
      if (largest >= 140) {
        return largest + 10;
      } else {
        return 140;
      }
    } else {
      return 140;
    }
  }
}
