import 'dart:math';

import 'package:bookkeeping/app_theme.dart';
import 'package:flutter/material.dart';

class CustomedPieChart extends StatefulWidget {
  const CustomedPieChart({
    super.key,
    required this.label,
    required this.value,
    this.color = AppTheme.themeColor,
    this.outerBorderColor = AppTheme.themeColor,
    this.innerCircleColor = Colors.white,
    this.outerBorderWidth = 2,
    this.innerCircleRadiusRatio = 0.4,
  });

  final List<String> label;
  final List<double> value;
  final Color color;
  final Color outerBorderColor;
  final Color innerCircleColor;
  final double outerBorderWidth;
  final double innerCircleRadiusRatio;

  @override
  State<CustomedPieChart> createState() => _CustomedPieChartState();
}

class _CustomedPieChartState extends State<CustomedPieChart> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PieChartPainter(
        color: widget.color,
        outerBorderColor: widget.outerBorderColor,
        innerCircleColor: widget.innerCircleColor,
        outerBorderWidth: widget.outerBorderWidth,
        innerCircleRadiusRatio: widget.innerCircleRadiusRatio,
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  PieChartPainter({
    required this.color,
    required this.outerBorderColor,
    required this.innerCircleColor,
    required this.outerBorderWidth,
    required this.innerCircleRadiusRatio,
  });

  final Color color;
  final Color outerBorderColor;
  final Color innerCircleColor;
  final double outerBorderWidth;
  final double innerCircleRadiusRatio;
  late final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    radius = min(size.width, size.height) / 2;

    _drawRing(canvas, size);
  }

  @override
  bool shouldRepaint(PieChartPainter oldDelegate) => true;

  void _drawRing(Canvas canvas, Size size) {
    // 外圈画笔样式
    Paint outerPaint = Paint()
      ..color = outerBorderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = outerBorderWidth;

    // 圆环画笔样式
    Paint ringPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // 内圆画笔样式
    Paint innerPaint = Paint()
      ..color = innerCircleColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      radius,
      outerPaint,
    );
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      radius - outerBorderWidth / 2,
      ringPaint,
    );
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      radius * innerCircleRadiusRatio,
      innerPaint,
    );
  }
}
