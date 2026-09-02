import 'package:flutter/material.dart';

/// Painter garis wavy/winding penghubung antar node tahun di roadmap
/// (Design.md §3.3 poin 1 — visual "jalur perjalanan era"). Bikin kurva
/// halus lewat titik-titik node pakai cubic bezier per segmen (bukan
/// garis lurus patah-patah), meniru gaya "jalan berkelok" di desain.
class RoadmapPathPainter extends CustomPainter {
  RoadmapPathPainter({required this.points, required this.color});

  final List<Offset> points;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final path = Path()..moveTo(points.first.dx, points.first.dy);

    for (var i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];
      final midY = (current.dy + next.dy) / 2;
      // Control point y ditaruh di tengah antar 2 titik, x ikut titik
      // masing-masing -> hasilnya kurva S yang halus antar node.
      path.cubicTo(current.dx, midY, next.dx, midY, next.dx, next.dy);
    }

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant RoadmapPathPainter oldDelegate) {
    return oldDelegate.points != points || oldDelegate.color != color;
  }
}