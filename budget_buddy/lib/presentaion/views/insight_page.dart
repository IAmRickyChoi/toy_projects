// lib/presentaion/views/insight_page.dart

import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:budget_buddy/data/models/expense_model.dart';
import 'package:budget_buddy/presentaion/view_models/expense_provider.dart';

class InsightPage extends ConsumerStatefulWidget {
  const InsightPage({super.key});

  @override
  ConsumerState<InsightPage> createState() => _InsightPageState();
}

class _InsightPageState extends ConsumerState<InsightPage> {
  // ✅ 1. 데이터 합산 시 비정상적인 값(NaN, 무한대) 무시
  List<double> _calculateDailyTotals(List<ExpenseModel> expenses) {
    List<double> totals = List.filled(7, 0.0);
    for (var e in expenses) {
      if (e.price.isNaN || e.price.isInfinite) continue;

      int index = e.datetime.weekday - 1; // 1(월요일) -> 0, 7(일요일) -> 6
      totals[index] += e.price;
    }
    return totals;
  }

  @override
  Widget build(BuildContext context) {
    // 이번 주(0)와 저번 주(-1) 데이터 스트림 구독
    final thisWeekState = ref.watch(weeklyExpenseListProvider(0));
    final lastWeekState = ref.watch(weeklyExpenseListProvider(-1));

    // 로딩 중 화면
    if (thisWeekState.isLoading || lastWeekState.isLoading) {
      return Scaffold(
        appBar: AppBar(backgroundColor: Colors.yellow[200]),
        backgroundColor: Colors.yellow[200],
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // 에러 발생 화면
    if (thisWeekState.hasError || lastWeekState.hasError) {
      return Scaffold(
        appBar: AppBar(backgroundColor: Colors.yellow[200]),
        backgroundColor: Colors.yellow[200],
        body: const Center(child: Text('데이터를 불러오는데 실패했습니다.')),
      );
    }

    // 데이터 안전하게 추출
    final thisWeekData = thisWeekState.value ?? [];
    final lastWeekData = lastWeekState.value ?? [];

    // ✅ 2. 여기서 변수 선언과 동시에 값을 할당(=)해야 에러가 발생하지 않습니다!
    final List<double> thisWeekTotals = _calculateDailyTotals(thisWeekData);
    final List<double> lastWeekTotals = _calculateDailyTotals(lastWeekData);

    // ✅ 3. 이번 주, 저번 주의 총 지출액(Total) 계산
    final double thisWeekSum = thisWeekTotals.fold(
      0.0,
      (prev, amount) => prev + amount,
    );
    final double lastWeekSum = lastWeekTotals.fold(
      0.0,
      (prev, amount) => prev + amount,
    );

    // 로딩 중(ローディング中) 처리
    if (thisWeekState.isLoading || lastWeekState.isLoading) {
      return Scaffold(
        appBar: AppBar(backgroundColor: Colors.yellow[200]),
        backgroundColor: Colors.yellow[200],
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // 에러(エラー) 발생 시 처리
    if (thisWeekState.hasError || lastWeekState.hasError) {
      return Scaffold(
        appBar: AppBar(backgroundColor: Colors.yellow[200]),
        backgroundColor: Colors.yellow[200],
        body: const Center(child: Text('데이터를 불러오는데 실패했습니다.')),
      );
    }

    // 차트 높이를 이쁘게 맞추기 위해 최댓값(最大値) 계산
    double maxThis = thisWeekTotals.isEmpty ? 0 : thisWeekTotals.reduce(max);
    double maxLast = lastWeekTotals.isEmpty ? 0 : lastWeekTotals.reduce(max);
    double maxY = max(maxThis, maxLast) * 1.2; // 제일 높은 값 기준 20% 여유 공간

    // ✅ 2. maxY 자체가 NaN이거나 무한대인지 확실하게 검사
    if (maxY.isNaN || maxY.isInfinite || maxY < 10.0) {
      maxY = 100.0;
    }

    double yInterval = (maxY / 5).ceilToDouble();
    // ✅ 3. yInterval도 안전하게 검사
    if (yInterval.isNaN || yInterval.isInfinite || yInterval < 1.0) {
      yInterval = 20.0;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Insight",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        surfaceTintColor: Colors.yellow[200],
        backgroundColor: Colors.yellow[200],
      ),
      backgroundColor: Colors.yellow[200],
      body: Column(
        children: [
          const SizedBox(height: 30),
          // 범례(凡例, レジェンド)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegend(Colors.grey[400]!, "Last Week", lastWeekSum),
              const SizedBox(width: 20),
              _buildLegend(Colors.blueGrey, "This Week", thisWeekSum),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              width: 500,
              padding: const EdgeInsets.only(right: 20, bottom: 20),
              child: BarChart(
                BarChartData(
                  minY: 0, // ✅ 4. 최소값을 0으로 명시
                  maxY: maxY,
                  gridData: FlGridData(
                    show: true,
                    horizontalInterval: yInterval, // 배경 가로줄 간격도 맞춰줌
                  ),
                  barGroups: _showingGroups(
                    thisWeekTotals,
                    lastWeekTotals,
                    maxY,
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 45,
                        interval: yInterval, // ✅ 5. Y축 눈금 간격 지정
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        getTitlesWidget: getTitles,
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1, // ✅ 6. X축(요일) 간격을 1칸으로 고정
                      ),
                    ),
                  ),
                  barTouchData: BarTouchData(
                    enabled: true,
                    handleBuiltInTouches: true, // 터치 및 호버(ホバー) 이벤트 기본 처리 활성화
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (group) =>
                          Colors.blueGrey.shade800, // 툴팁 배경색
                      tooltipPadding: const EdgeInsets.all(8),
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        // rodIndex가 0이면 저번 주(회색 바), 1이면 이번 주(파란색 바)
                        final weekText = rodIndex == 0
                            ? "Last Week"
                            : "This Week";

                        // 마우스를 올렸을 때 보여줄 텍스트 포맷 (예: 이번 주 \n 1500 ¥)
                        return BarTooltipItem(
                          '$weekText\n${rod.toY.toInt()} ¥',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        );
                      },
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

  // 범례(凡例) 위젯
  Widget _buildLegend(Color color, String text, double sum) {
    return Column(
      children: [
        Row(
          children: [
            Container(width: 14, height: 14, color: color),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
        Text('${sum.toStringAsFixed(0)} ¥'),
      ],
    );
  }

  // X축 타이틀 로직
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

  // 이번 주와 저번 주 데이터를 각각의 Rod(막대)로 생성
  List<BarChartGroupData> _showingGroups(
    List<double> thisWeek,
    List<double> lastWeek,
    double maxY,
  ) {
    return List.generate(
      7,
      (i) => BarChartGroupData(
        x: i,
        barRods: [
          // 저번 주 막대
          BarChartRodData(toY: lastWeek[i], color: Colors.grey[400], width: 12),
          // 이번 주 막대
          BarChartRodData(toY: thisWeek[i], color: Colors.blueGrey, width: 12),
        ],
      ),
    );
  }
}
