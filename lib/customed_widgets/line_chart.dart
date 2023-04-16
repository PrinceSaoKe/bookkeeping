import 'package:bookkeeping/app_theme.dart';
import 'package:flutter/material.dart';

class CustomedLineChart extends StatefulWidget {
  const CustomedLineChart({
    super.key,
    required this.label,
    required this.value,
    this.color = AppTheme.themeColor,
    this.barWidth = 15,
    this.barsSpacing = 20,
    required this.maxY,
    this.xOffset = 20,
    this.fontSize = 12,
    this.textOffset = 0,
  });

  final List<String> label;
  final List<double> value;
  final Color color;
  final double barWidth;
  final double barsSpacing;
  final double maxY;
  final double xOffset;
  final double fontSize;
  final double textOffset;

  @override
  State<CustomedLineChart> createState() => _CustomedLineChartState();
}

class _CustomedLineChartState extends State<CustomedLineChart>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final _animations = <double>[];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();

    for (var i = 0; i < widget.label.length; i++) {
      Tween<double> tween = Tween(begin: 0, end: widget.value[i]);
      _animations.add(0);

      Animation<double> animation = tween.animate(
        CurvedAnimation(parent: _controller, curve: Curves.ease),
      );

      _controller.addListener(() {
        setState(() {
          _animations[i] = animation.value;
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LineChartPainter(
        animationController: _controller,
        label: widget.label,
        // value: widget.value,
        value: _animations,
        color: widget.color,
        barsWidth: widget.barWidth,
        barsSpacing: widget.barsSpacing,
        maxY: widget.maxY,
        xOffset: widget.xOffset,
        fontSize: widget.fontSize,
        textOffset: widget.textOffset,
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  LineChartPainter({
    required this.label,
    required this.value,
    required this.color,
    required this.barsWidth,
    required this.barsSpacing,
    required this.maxY,
    required this.xOffset,
    required this.fontSize,
    required this.textOffset,
    required this.animationController,
  });

  final List<String> label;
  final List<double> value;
  final Color color;
  final double barsWidth;
  final double barsSpacing;
  final double maxY;
  final double xOffset;
  final double fontSize;
  final double textOffset;
  AnimationController animationController;

  @override
  void paint(Canvas canvas, Size size) {
    _drawAxis(canvas, size);
    _drawBars(canvas, size);
    _drawLabel(canvas, size);
    _drawValue(canvas, size);
  }

  @override
  bool shouldRepaint(LineChartPainter oldDelegate) => true;

  /// 画横坐标轴
  void _drawAxis(Canvas canvas, Size size) {
    // 画笔样式
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    Path path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  /// 画折线
  void _drawBars(Canvas canvas, Size size) {
    // 画笔样式
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < label.length; i++) {
      Path path = Path()
        ..moveTo(xOffset + 0.5 * barsWidth,
            size.height - value[0] * size.height / maxY);
      for (var i = 1; i < label.length; i++) {
        path.lineTo(xOffset + 0.5 * barsWidth + i * (barsWidth + barsSpacing),
            size.height - value[i] * size.height / maxY);
      }

      canvas.drawPath(path, paint);
    }
  }

  /// x轴标签
  void _drawLabel(Canvas canvas, Size size) {
    for (var i = 0; i < label.length; i++) {
      TextPainter(
        text: TextSpan(
          text: label[i].toString(),
          style: TextStyle(fontSize: fontSize, color: color),
        ),
        textDirection: TextDirection.ltr,
      )
        ..layout(minWidth: xOffset, maxWidth: size.width)
        ..paint(
          canvas,
          Offset(
            i * (barsWidth + barsSpacing) + xOffset + textOffset,
            size.height + fontSize - 5,
          ),
        );
    }
  }

  /// 柱上的值
  void _drawValue(Canvas canvas, Size size) {
    for (var i = 0; i < label.length; i++) {
      TextPainter(
        text: TextSpan(
          text: value[i].toStringAsFixed(2),
          style: TextStyle(fontSize: fontSize, color: color),
        ),
        textDirection: TextDirection.ltr,
      )
        ..layout(minWidth: xOffset, maxWidth: size.width)
        ..paint(
          canvas,
          Offset(
            i * (barsWidth + barsSpacing) + xOffset + textOffset,
            size.height - value[i] * size.height / maxY - fontSize - 5,
          ),
        );
    }
  }
}
