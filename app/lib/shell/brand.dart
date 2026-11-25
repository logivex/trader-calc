import 'package:flutter/material.dart';

import '../theme/tokens.dart';

/// Logivex mark: an "L" whose crossbar carries a rising price line.
/// Drawn in code so it follows the theme. Swap for your own logo file whenever
/// you have one (put it in assets/ and replace this widget's body).
class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 28});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _MarkPainter(context.colors.accent)),
    );
  }
}

class _MarkPainter extends CustomPainter {
  _MarkPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size s) {
    final p = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = s.width * 0.09
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    Offset o(double x, double y) => Offset(s.width * x, s.height * y);

    // The "L".
    canvas.drawPath(
      Path()
        ..moveTo(o(0.18, 0.12).dx, o(0.18, 0.12).dy)
        ..lineTo(o(0.18, 0.86).dx, o(0.18, 0.86).dy)
        ..lineTo(o(0.86, 0.86).dx, o(0.86, 0.86).dy),
      p,
    );
    // The price line.
    canvas.drawPath(
      Path()
        ..moveTo(o(0.18, 0.68).dx, o(0.18, 0.68).dy)
        ..lineTo(o(0.44, 0.46).dx, o(0.44, 0.46).dy)
        ..lineTo(o(0.60, 0.60).dx, o(0.60, 0.60).dy)
        ..lineTo(o(0.86, 0.22).dx, o(0.86, 0.22).dy),
      p,
    );
  }

  @override
  bool shouldRepaint(_MarkPainter old) => old.color != color;
}

/// Mark + wordmark.
class BrandLockup extends StatelessWidget {
  const BrandLockup({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const BrandMark(size: 26),
        const SizedBox(width: Gap.sm + 2),
        Text(
          'LOGIVEX',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.6,
            color: c.text,
          ),
        ),
      ],
    );
  }
}
