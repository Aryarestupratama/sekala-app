import 'package:flutter/material.dart';

/// Painter garis wavy/winding penghubung antar node tahun di roadmap
/// (Design.md §3.3 poin 1 — visual "jalur perjalanan era"). Bikin kurva
/// halus lewat titik-titik node pakai cubic bezier per segmen (bukan
/// garis lurus patah-patah), meniru gaya "jalan berkelok" di desain.
///
/// REDESIGN: tambah [progress] (0..1) supaya jalur bisa "digambar"
/// bertahap dari awal ke akhir lewat animasi (dipakai era_roadmap_screen
/// untuk efek "mengalir" saat roadmap pertama tampil). `progress = 1`
/// (default) = perilaku lama, jalur langsung penuh.
class RoadmapPathPainter extends CustomPainter {
  RoadmapPathPainter({
    required this.points,
    required this.color,
    this.progress = 1.0,
  });

  final List<Offset> points;
  final Color color;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2 || progress <= 0) return;

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

    if (progress >= 1) {
      canvas.drawPath(path, paint);
      return;
    }

    // Ambil sebagian jalur sepanjang `progress` dari total panjang path,
    // pakai PathMetrics supaya potongannya mengikuti kurva (bukan cuma
    // memotong lurus berdasarkan index titik).
    final metrics = path.computeMetrics().toList();
    final totalLength = metrics.fold<double>(0, (sum, m) => sum + m.length);
    final targetLength = totalLength * progress.clamp(0.0, 1.0);

    var consumed = 0.0;
    for (final metric in metrics) {
      if (consumed >= targetLength) break;
      final remaining = targetLength - consumed;
      final extractLength = remaining < metric.length ? remaining : metric.length;
      canvas.drawPath(metric.extractPath(0, extractLength), paint);
      consumed += metric.length;
    }
  }

  @override
  bool shouldRepaint(covariant RoadmapPathPainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.color != color ||
        oldDelegate.progress != progress;
  }
}