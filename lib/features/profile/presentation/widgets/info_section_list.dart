import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Satu kartu konten statis (judul + ikon + isi).
class InfoSection {
  const InfoSection({required this.icon, required this.title, required this.body});

  final IconData icon;
  final String title;

  /// Teks isi. Baris yang diawali "• " dirender sebagai butir dengan
  /// indentasi gantung (baris lanjutan rata dengan teks, bukan dengan butir);
  /// baris kosong = jarak antarparagraf.
  final String body;
}

/// Daftar kartu konten statis — dipakai `AboutSekalaScreen` dan
/// `PanduanBelajarScreen` (dulu keduanya menyalin kode yang sama).
///
/// Perbaikan dari versi lama:
/// - Isi 14sp -> 16sp, line-height 1.55 (ini bahan bacaan, bukan caption).
/// - Butir "• " yang dibungkus dalam satu `Text` membuat baris lanjutan
///   menempel di bawah butir; sekarang indentasi gantung.
/// - Judul kartu ditandai header untuk screen reader.
/// - Animasi masuk mengikuti "reduce motion"; animasi dibuat sekali.
class InfoSectionList extends StatefulWidget {
  const InfoSectionList({super.key, required this.sections});

  final List<InfoSection> sections;

  @override
  State<InfoSectionList> createState() => _InfoSectionListState();
}

class _InfoSectionListState extends State<InfoSectionList> with SingleTickerProviderStateMixin {
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 400 + widget.sections.length * 100),
  );
  late final List<Animation<double>> _slots = [
    for (var i = 0; i < widget.sections.length; i++) _slot(i),
  ];
  bool _started = false;

  Animation<double> _slot(int index) {
    final n = widget.sections.length;
    final start = (index / n * 0.7).clamp(0.0, 0.85);
    final end = (start + 0.35).clamp(0.15, 1.0);
    return CurvedAnimation(
      parent: _entrance,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    if (MediaQuery.disableAnimationsOf(context)) {
      _entrance.value = 1;
    } else {
      _entrance.forward();
    }
  }

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: widget.sections.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final animation = _slots[index];
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Opacity(
              opacity: animation.value.clamp(0.0, 1.0),
              child: Transform.translate(
                offset: Offset(0, (1 - animation.value) * 14),
                child: child,
              ),
            );
          },
          child: _InfoCard(section: widget.sections[index]),
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.section});

  final InfoSection section;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.ink.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(section.icon, size: 20, color: AppColors.ink),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Semantics(
                  header: true,
                  child: Text(
                    section.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w800, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _RichBody(text: section.body),
        ],
      ),
    );
  }
}

class _RichBody extends StatelessWidget {
  const _RichBody({required this.text});

  final String text;

  static const _style = TextStyle(color: AppColors.textSecondary, fontSize: 16, height: 1.55);

  @override
  Widget build(BuildContext context) {
    final lines = text.split('\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final line in lines)
          if (line.trim().isEmpty)
            const SizedBox(height: 8)
          else if (line.startsWith('• '))
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 20, child: Text('•', style: _style)),
                  Expanded(child: Text(line.substring(2), style: _style)),
                ],
              ),
            )
          else
            Text(line, style: _style),
      ],
    );
  }
}