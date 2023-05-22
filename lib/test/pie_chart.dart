import 'package:bookkeeping/app_theme.dart';
import 'package:bookkeeping/customed_widgets/pie_chart.dart';
import 'package:flutter/material.dart';

class PieChartTestPage extends StatefulWidget {
  const PieChartTestPage({super.key});

  @override
  State<PieChartTestPage> createState() => _PieChartTestPageState();
}

class _PieChartTestPageState extends State<PieChartTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 300,
          color: Colors.black,
          child: CustomedPieChart(
            value: const [80, 50, 30],
            label: const ['一月', '二月', '三月'],
            colors: [
              AppTheme.themeColor[900]!,
              AppTheme.themeColor[800]!,
              AppTheme.themeColor[700]!,
            ],
            outerBorderColor: Colors.grey,
            innerCircleColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}
