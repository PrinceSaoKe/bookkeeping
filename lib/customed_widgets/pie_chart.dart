import 'dart:math';

import 'package:flutter/material.dart';

class PiePart {
  final Color color;

  /// 占据圆形的弧度值
  double sweepAngle;

  /// 起始弧度值
  final double startAngle;

  PiePart(this.startAngle, this.sweepAngle, this.color);
}

class CustomedPieChart extends StatefulWidget {
  final List<double> value;
  final List<String> label;

  final List<Color> colors;
  final Color outerBorderColor;
  final Color innerCircleColor;
  final Color textColor;

  const CustomedPieChart({
    super.key,
    required this.value,
    required this.label,
    required this.colors,
    required this.outerBorderColor,
    required this.innerCircleColor,
    this.textColor = Colors.black,
  });

  @override
  State<CustomedPieChart> createState() => _CustomedPieChartState();
}

class _CustomedPieChartState extends State<CustomedPieChart>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  List<double> animateDatas = [];
  double _total = 0.0;
  final List<PiePart> _parts = <PiePart>[];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    List<double> datas = widget.value;
    // 计算出数据总和
    _total = datas.reduce((a, b) => a + b);
    // 定义一个起始变量
    double startAngle = 0.0;

    for (int i = 0; i < datas.length; i++) {
      animateDatas.add(0.0);
      final data = datas[i];
      // 计算出每个数据所占的弧度值
      final angle = (data / _total) * -pi * 2;
      PiePart peiPart;

      if (i > 0) {
        // 下一个数据的起始弧度值等于之前的数据弧度值之和
        double lastSweepAngle = _parts[i - 1].sweepAngle;
        startAngle += lastSweepAngle;
        peiPart = PiePart(startAngle, angle, widget.colors[i]);
      } else {
        // 第一个数据的起始弧度为 0.0
        peiPart = PiePart(0.0, angle, widget.colors[i]);
      }
      // 添加到数组中
      _parts.add(peiPart);

      CurvedAnimation curvedAnimation = CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      );

      // 创建弧形的补间动画
      final partTween = Tween<double>(begin: 0.0, end: peiPart.sweepAngle);
      Animation<double> animation = partTween.animate(curvedAnimation);

      // 创建文字的补间动画
      final percentTween = Tween<double>(begin: 0.0, end: data);
      Animation<double> percentAnimation =
          percentTween.animate(curvedAnimation);

      // 在动画启动后不断改变数据值
      _controller.addListener(() {
        _parts[i].sweepAngle = animation.value;
        animateDatas[i] = double.parse(
          percentAnimation.value.toStringAsFixed(1),
        );
        setState(() {});
      });
      // 开始动画
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 300,
          height: 300,
          child: CustomPaint(
            painter: PieChartPainter(
              total: _total,
              parts: _parts,
              datas: animateDatas,
              legends: widget.label,
              textColor: widget.textColor,
            ),
          ),
        ),
      ],
    );
  }
}

class PieChartPainter extends CustomPainter {
  final double total;
  final List<double> datas;
  final List<PiePart> parts;
  final List<String> legends;
  final Color textColor;

  PieChartPainter({
    required this.total,
    required this.datas,
    required this.parts,
    required this.legends,
    this.textColor = Colors.black,
  });

  @override
  void paint(Canvas canvas, Size size) {
    drawCircle(canvas, size);
    drawLegends(canvas, size);
    drawParts(canvas, size);
  }

  void drawCircle(Canvas canvas, Size size) {
    final sw = size.width;
    final sh = size.height;
    // 确定圆的半径
    final double radius = min(sw, sh) / 2;
    // 定义中心点
    final Offset center = Offset(sw / 2, sh / 2);

    // 定义圆形的绘制属性
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.grey
      ..strokeWidth = 1.0;

    // 使用 Canvas 的 drawCircle 绘制
    canvas.drawCircle(center, radius, paint);
  }

  void drawLegends(Canvas canvas, Size size) {
    final sw = size.width;
    final sh = size.height;
    final double radius = min(sw, sh) / 2;
    const double fontSize = 12.0;

    for (int i = 0; i < datas.length; i++) {
      final PiePart part = parts[i];
      final String legend = legends[i];
      // 根据每部分的起始弧度加上自身弧度值的一半得到每部分的中间弧度值
      final radians = part.startAngle + part.sweepAngle / 2;
      // 根据三角函数计算中出标识文字的 x 和 y 位置，需要加上宽和高的一半适配 Canvas 的坐标
      double x = cos(radians) * (radius + 32) + sw / 2 - fontSize;
      double y = sin(radians) * (radius + 32) + sh / 2;
      final offset = Offset(x, y);

      // 使用 TextPainter 绘制文字标识
      TextPainter(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: legend,
          style: TextStyle(fontSize: fontSize, color: textColor),
        ),
        textDirection: TextDirection.ltr,
      )
        ..layout(minWidth: 0, maxWidth: size.width)
        ..paint(canvas, offset);
    }
  }

  void drawParts(Canvas canvas, Size size) {
    final sw = size.width;
    final sh = size.height;
    final double fontSize = 10.0;
    final double radius = min(sw, sh) / 2;
    final Offset center = Offset(sw / 2, sh / 2);

    // 创建弧形依照的矩形
    final rect = Rect.fromCenter(
      center: center,
      width: radius * 2,
      height: radius * 2,
    );
    // 设置绘制属性
    final paint = Paint()
      ..strokeWidth = 0.0
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;

    for (int i = 0; i < parts.length; i++) {
      final PiePart part = parts[i];
      // 设置每部分的颜色
      paint.color = part.color;
      // 使用 drawArc 方法画出弧形，参数依次是依照的矩形，起始弧度值，占据的弧度值，是否从中心点绘制，绘制属性
      canvas.drawArc(rect, part.startAngle, part.sweepAngle, true, paint);

      final double data = datas[i];
      // 计算每部分占比
      final String percent = (data / total * 100).toStringAsFixed(1);
      final double radians = part.startAngle + part.sweepAngle / 2;
      // 使用三角函数计算文字位置
      double x = cos(radians) * radius / 2 + sw / 2 - fontSize * 3;
      double y = sin(radians) * radius / 2 + sh / 2;
      final Offset offset = Offset(x, y);

      // 使用 TextPainter 绘制文字标识
      TextPainter(
        textAlign: TextAlign.start,
        text: TextSpan(
          text: '$data $percent%',
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )
        ..layout(
          minWidth: 0,
          maxWidth: size.width,
        )
        ..paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(PieChartPainter oldDelegate) => true;
}
