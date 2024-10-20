import 'dart:math' as math;
import 'package:flutter/material.dart';

class CircularCountdownPainter extends CustomPainter {
  final double progress;
  bool isDarkMode;

  CircularCountdownPainter(this.progress, this.isDarkMode);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final backgroundPaint = Paint()
      ..color = isDarkMode ? Colors.grey[500]! : Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final foregroundPaint = Paint()
      ..color = isDarkMode ? Colors.white : Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, math.pi * 1.5, math.pi * 2, false, backgroundPaint);

    canvas.drawArc(
        rect, math.pi * 1.5, math.pi * 2 * progress, false, foregroundPaint);

    final double angle = (math.pi * 1.5) + (math.pi * 2 * progress);
    final offset = Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );

    final dotPaint = Paint()..color = isDarkMode ? Colors.white : Colors.black;
    canvas.drawCircle(offset, 6, dotPaint);
  }

  @override
  bool shouldRepaint(CircularCountdownPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
