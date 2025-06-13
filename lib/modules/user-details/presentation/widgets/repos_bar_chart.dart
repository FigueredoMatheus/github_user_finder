import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:github_user_finder/modules/user-details/domain/entities/git_repo.dart';

class ReposBarChart extends StatelessWidget {
  final List<GitRepo> repos;

  const ReposBarChart({super.key, required this.repos});

  @override
  Widget build(BuildContext context) {
    final sorted = [...repos]
      ..sort((a, b) => b.commitCount.compareTo(a.commitCount));

    final List<Color> barColors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Visibility(
        visible: sorted.isNotEmpty,
        replacement: Align(
          alignment: Alignment.center,
          child: Text(
            'Nenhum repositório encontrado',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Repositórios atualizados recentemente',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 15),
            AspectRatio(
              aspectRatio: 1.4,
              child: BarChart(
                BarChartData(
                  barGroups: List.generate(sorted.length, (index) {
                    final data = sorted[index];
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: data.commitCount.toDouble(),
                          width: 20,
                          color: barColors[index % barColors.length],
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ],
                    );
                  }),
                  titlesData: FlTitlesData(
                    leftTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(sorted.length, (index) {
                final data = sorted[index];
                final color = barColors[index % barColors.length];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${data.repoName} | ${data.commitCount} commits',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
