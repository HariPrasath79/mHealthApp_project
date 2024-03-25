import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:project_cdm/features/home/ui/bar_graph/bar_data.dart';

class WeeklyGraph extends StatelessWidget {
  final double? maxY;
  final double monValue;
  final double tueValue;
  final double wedValue;
  final double thurValue;
  final double friValue;
  final double satValue;
  final double sunValue;

  const WeeklyGraph({
    super.key,
    required this.maxY,
    required this.monValue,
    required this.tueValue,
    required this.wedValue,
    required this.thurValue,
    required this.friValue,
    required this.satValue,
    required this.sunValue,
  });

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunValue: sunValue,
      monValue: monValue,
      tueValue: tueValue,
      wedValue: wedValue,
      thurValue: thurValue,
      friValue: friValue,
      satValue: satValue,
    );
    myBarData.initilizeBarData();

    return BarChart(BarChartData(
        maxY: maxY,
        barTouchData: BarTouchData(
          enabled: true,
          allowTouchBarBackDraw: true,
          touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                String label = "";
                String datay = group.barRods[rodIndex].toY.toInt().toString();
                switch (group.x) {
                  case 0:
                    label = '$datay %';
                  case 1:
                    label = '$datay %';
                  case 2:
                    label = '$datay %';
                  case 3:
                    label = '$datay %';
                  case 4:
                    label = '$datay %';
                  case 5:
                    label = '$datay %';
                  case 6:
                    label = '$datay %';
                }
                return BarTooltipItem(label, const TextStyle(fontSize: 15));
              },
              tooltipBgColor: Colors.white,
              tooltipRoundedRadius: 10,
              direction: TooltipDirection.top),
        ),
        minY: 0,
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
              reservedSize: 28,
            ),
          ),
        ),
        gridData: const FlGridData(
            drawHorizontalLine: false, drawVerticalLine: false),
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Colors.blueGrey,
                    width: 25,
                    borderRadius: BorderRadius.circular(20),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      color: Colors.grey[300],
                      toY: maxY,
                    ),
                  )
                ],
              ),
            )
            .toList()));
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );

  Widget text;

  switch (value.toInt()) {
    case 0:
      text = const Text('Mon', style: style);

    case 1:
      text = const Text('Tue', style: style);

    case 2:
      text = const Text('Wed', style: style);

    case 3:
      text = const Text('Thur', style: style);

    case 4:
      text = const Text('Fri', style: style);

    case 5:
      text = const Text('Sat', style: style);

    case 6:
      text = const Text('Sun', style: style);

    default:
      text = const Text('');
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}
