import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class InsightPage extends StatefulWidget {
  const InsightPage({super.key});

  @override
  State<InsightPage> createState() => _InsightPageState();
}

class _InsightPageState extends State<InsightPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
        children: [
          SizedBox(height: 100),
          SizedBox(
            width: 370,
            child: AspectRatio(
              aspectRatio: 1.2,
              child: BarChart(
                BarChartData(
                  barGroups: showingGroups(),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 35,
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                        reservedSize: 50,
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        getTitlesWidget: getTitles,
                        showTitles: true,
                        reservedSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text = switch (value.toInt()) {
      0 => 'M',
      1 => 'T',
      2 => 'W',
      3 => 'T',
      4 => 'F',
      5 => 'S',
      6 => 'S',
      _ => '',
    };
    return SideTitleWidget(
      meta: meta,
      space: 10,
      child: Text(text, style: style),
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(
    7,
    (i) => BarChartGroupData(
      x: i,
      barRods: [
        BarChartRodData(
          toY: 10,
          backDrawRodData: BackgroundBarChartRodData(show: true),
          width: 12,
        ),
        BarChartRodData(
          toY: 40,
          backDrawRodData: BackgroundBarChartRodData(show: true),
          width: 12,
          color: Colors.blueGrey,
        ),
      ],
    ),
  );
}
