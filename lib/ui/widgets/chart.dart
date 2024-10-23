import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mg_dashboard/models/chartModel.dart';
import 'package:mg_dashboard/ui/widgets/customText.dart';
import 'package:mg_dashboard/utils/colorConst.dart';
import 'package:mg_dashboard/utils/colorExtentions.dart';

class ChartView extends StatefulWidget {
  ChartView({
    super.key,
    required this.dataList,
  });

  final List<ChartModel> dataList;

  final Color barBackgroundColor =
      ColorConst.contentColorWhite.darken().withOpacity(0.3);
  final Color barColor = ColorConst.indigo;
  final Color touchedBarColor = ColorConst.primaryFont;

  @override
  State<StatefulWidget> createState() => ChartViewState();
}

class ChartViewState extends State<ChartView> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  List<double> graphDataList = [];
  DateTime today = DateTime.now();

  @override
  void initState() {
    graphDataList = widget.dataList.map((e) => e.amount ?? 0).toList();
    touchedIndex = today.month - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
                  const Image(
                    image: AssetImage('assets/images/money.jpg'),
                    height: 20,
                  ),
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
    Color? barColor,
    double width = 10,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
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

  List<BarChartGroupData> showingGroups() => List.generate(12, (i) {
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
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.center,
          tooltipMargin: -10,
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
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: const TextStyle(
                    color: Colors.white,
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
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
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
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
      letterSpacing: 0.8,
      color: ColorConst.indigo,
      fontWeight: FontWeight.w400,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('JAN', style: style);
        break;
      case 1:
        text = const Text('FEB', style: style);
        break;
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 3:
        text = const Text('APR', style: style);
        break;
      case 4:
        text = const Text('MAY', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 6:
        text = const Text('JUL', style: style);
        break;
      case 7:
        text = const Text('AUG', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      case 9:
        text = const Text('OCT', style: style);
        break;
      case 10:
        text = const Text('NOV', style: style);
        break;
      case 11:
        text = const Text('DEC', style: style);
        break;
      default:
        text = const Text('', style: style);
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
      if (largest >= 20) {
        return largest + 10;
      } else {
        return 20;
      }
    } else {
      return 20;
    }
  }
}
