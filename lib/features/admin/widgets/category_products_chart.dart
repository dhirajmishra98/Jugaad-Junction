import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../models/sales.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> salesList;

  const CategoryProductsChart({
    Key? key,
    required this.salesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const LinearGradient barsGradient = LinearGradient(
      colors: [
        Color.fromARGB(255, 66, 87, 224),
        Color.fromARGB(255, 10, 14, 236),
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );
    return Padding(
      padding: const EdgeInsets.all(30),
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(
            border: const Border(
              top: BorderSide.none,
              right: BorderSide.none,
              left: BorderSide(width: 1),
              bottom: BorderSide(width: 1),
            ),
          ),
          groupsSpace: 1,
          barGroups: salesList.asMap().entries.map((e) {
            final index = e.key;
            final sales = e.value;
            return BarChartGroupData(
              x: index + 1,
              barRods: [
                BarChartRodData(
                  toY: double.parse(sales.totalEarnings.toString()),
                  gradient: barsGradient,
                ),
              ],
              // showingTooltipIndicators: [0],
            );
          }).toList(),
        ),
      ),
    );
  }
}
