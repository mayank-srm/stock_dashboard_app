import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: [FlSpot(0, 1), FlSpot(1, 3), FlSpot(2, 2)],
            isCurved: true,
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlue],
            ),
            barWidth: 4,
          ),
        ],
      ),
    );
  }
}
