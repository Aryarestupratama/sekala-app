import 'package:flutter/material.dart';

/// Render teks isi konten (blok teks section, soal & penjelasan kuis)
/// dengan dukungan:
/// - paragraf: baris kosong di antara teks = jarak antar paragraf,
///   Enter tunggal = pindah baris biasa (teks lama tidak menyatu).
/// - list bernomor: baris yang diawali `1.` / `2)` (1-2 digit) + spasi.
///   Angka 3+ digit (mis. "1974. Program...") SENGAJA tidak dianggap list.
/// - list bullet: baris yang diawali `- `, `* `, atau `• `.
/// - lanjutan item: baris berikutnya yang diawali spasi/tab menyambung
///   ke item di atasnya.
///
/// Teks disimpan apa adanya di DB (tidak ada tag) — widget ini hanya
/// mengatur tampilan. Bold/italic belum didukung; kalau nanti dibutuhkan,
/// cukup ubah widget ini (semua pemakai ikut berubah).
class RichBodyText extends StatelessWidget {
  const RichBodyText(
    this.text, {
    super.key,
    this.style,
    this.paragraphSpacing = 10,
    this.listItemSpacing = 4,
  });

  final String text;
  final TextStyle? style;
  final double paragraphSpacing;
  final double listItemSpacing;

  static final _orderedRe = RegExp(r'^\s*(\d{1,2})[.)]\s+(.*)$');
  static final _bulletRe = RegExp(r'^\s*[-*•]\s+(.*)$');

  @override
  Widget build(BuildContext context) {
    final effective = style ?? DefaultTextStyle.of(context).style;
    final blocks = _parse(text);

    if (blocks.isEmpty) return const SizedBox.shrink();

    final children = <Widget>[];
    for (var i = 0; i < blocks.length; i++) {
      if (i > 0) children.add(SizedBox(height: paragraphSpacing));
      final block = blocks[i];
      if (block is _Paragraph) {
        children.add(Text(block.text, style: effective));
      } else if (block is _ListBlock) {
        children.add(_buildList(block, effective));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _buildList(_ListBlock block, TextStyle effective) {
    final fontSize = effective.fontSize ?? 14;
    final maxMarkerLen = block.items.fold<int>(1, (m, e) => e.marker.length > m ? e.marker.length : m);
    final markerWidth = fontSize * 0.62 * maxMarkerLen + 8;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < block.items.length; i++) ...[
          if (i > 0) SizedBox(height: listItemSpacing),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: markerWidth, child: Text(block.items[i].marker, style: effective)),
              Expanded(child: Text(block.items[i].text, style: effective)),
            ],
          ),
        ],
      ],
    );
  }

  static List<Object> _parse(String raw) {
    final lines = raw.replaceAll('\r\n', '\n').replaceAll('\r', '\n').trim().split('\n');
    final blocks = <Object>[];
    final paragraph = <String>[];
    _ListBlock? list;

    void flushParagraph() {
      if (paragraph.isNotEmpty) {
        blocks.add(_Paragraph(paragraph.join('\n')));
        paragraph.clear();
      }
    }

    void flushList() {
      if (list != null) {
        blocks.add(list!);
        list = null;
      }
    }

    for (final line in lines) {
      if (line.trim().isEmpty) {
        flushParagraph();
        flushList();
        continue;
      }

      final ordered = _orderedRe.firstMatch(line);
      final bullet = ordered == null ? _bulletRe.firstMatch(line) : null;

      if (ordered != null || bullet != null) {
        flushParagraph();
        list ??= _ListBlock();
        if (ordered != null) {
          list!.items.add(_ListItem('${ordered.group(1)}.', ordered.group(2)!.trim()));
        } else {
          list!.items.add(_ListItem('•', bullet!.group(1)!.trim()));
        }
        continue;
      }

      final isContinuation = list != null && (line.startsWith(' ') || line.startsWith('\t'));
      if (isContinuation) {
        final last = list!.items.last;
        list!.items[list!.items.length - 1] = _ListItem(last.marker, '${last.text} ${line.trim()}');
        continue;
      }

      flushList();
      paragraph.add(line.trimRight());
    }

    flushParagraph();
    flushList();
    return blocks;
  }
}

class _Paragraph {
  _Paragraph(this.text);
  final String text;
}

class _ListBlock {
  final List<_ListItem> items = [];
}

class _ListItem {
  const _ListItem(this.marker, this.text);
  final String marker;
  final String text;
}