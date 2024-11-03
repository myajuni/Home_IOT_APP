import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:project/resources/app_colors.dart';
import 'package:project/utils/extensions/color_ext.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<double> dailyUsage = [3, 2, 3, 5, 1, 4, 4];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
            child: Text(
              '10월 리포트',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
            child: Column(
              children: [
                Card(
                  color: Colors.black,
                  elevation: 16.0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        const Text(
                          '요일별 에너지 사용량',
                          style: TextStyle(color: Colors.white),
                        ),
                        _WeeklyBarChart(dailyUsage: dailyUsage),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Card(
                  color: Colors.black,
                  elevation: 16.0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        const Text(
                          '일주일 사용량 비교',
                          style: TextStyle(color: Colors.white),
                        ),
                        _CompareBarChart(dailyUsage: dailyUsage),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                const SizedBox(height: 12.0),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _WeeklyBarChart extends StatelessWidget {
  final List<double> dailyUsage;

  const _WeeklyBarChart({required this.dailyUsage, Key? key}) : super(key: key);

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          AppColors.contentColorBlue.darken(20),
          AppColors.contentColorCyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Adjusted height for better layout
      child: BarChart(
        BarChartData(
          maxY: 25,
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  );
                  String text;
                  // Map the x value to day names
                  switch (value.toInt()) {
                    case 0:
                      text = 'Mon';
                      break;
                    case 1:
                      text = 'Tue';
                      break;
                    case 2:
                      text = 'Wed';
                      break;
                    case 3:
                      text = 'Thu';
                      break;
                    case 4:
                      text = 'Fri';
                      break;
                    case 5:
                      text = 'Sat';
                      break;
                    case 6:
                      text = 'Sun';
                      break;
                    default:
                      text = '';
                      break;
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 4,
                    child: Text(text, style: style),
                  );
                },
              ),
            ),
          ),
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => Colors.transparent,
              tooltipPadding: EdgeInsets.zero,
              tooltipMargin: 8,
              getTooltipItem: (
                BarChartGroupData group,
                int groupIndex,
                BarChartRodData rod,
                int rodIndex,
              ) {
                return BarTooltipItem(
                  rod.toY.round().toString(),
                  const TextStyle(
                    color: AppColors.contentColorCyan,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          // Generate barGroups dynamically based on dailyUsage
          barGroups: List.generate(dailyUsage.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: dailyUsage[index],
                  gradient: _barsGradient,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _CompareBarChart extends StatelessWidget {
  final List<double> dailyUsage;

  const _CompareBarChart({required this.dailyUsage, Key? key})
      : super(key: key);

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          AppColors.contentColorBlue.darken(20),
          AppColors.contentColorCyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  @override
  Widget build(BuildContext context) {
    // Calculate total and average usage dynamically
    double totalUsage =
        dailyUsage.isNotEmpty ? dailyUsage.reduce((a, b) => a + b) : 0;
    double averageUsage =
        dailyUsage.isNotEmpty ? totalUsage / dailyUsage.length : 0;

    return SizedBox(
      height: 200, // Adjusted height for better layout
      child: BarChart(
        BarChartData(
          maxY: 25, // Adjust maxY as needed
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  );
                  String text;
                  switch (value.toInt()) {
                    case 0:
                      text = '일주일 총 사용량';
                      break;
                    case 1:
                      text = '일주일 평균 사용량';
                      break;
                    default:
                      text = '';
                      break;
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 4,
                    child: Text(text, style: style),
                  );
                },
              ),
            ),
          ),
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => Colors.transparent,
              tooltipPadding: EdgeInsets.zero,
              tooltipMargin: 8,
              getTooltipItem: (
                BarChartGroupData group,
                int groupIndex,
                BarChartRodData rod,
                int rodIndex,
              ) {
                return BarTooltipItem(
                  rod.toY.round().toString(),
                  const TextStyle(
                    color: AppColors.contentColorCyan,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          // Define barGroups for total and average usage
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: totalUsage,
                  gradient: _barsGradient,
                ),
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                  toY: averageUsage,
                  gradient: _barsGradient,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
