import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const SekalaApp());
}

class SekalaApp extends StatelessWidget {
  const SekalaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SEKALA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const _ThemePreview(),
    );
  }
}

// Widget sementara buat ngecek tema — nanti diganti router (core/router)
class _ThemePreview extends StatelessWidget {
  const _ThemePreview();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SEKALA Theme Preview')),
      body: const Center(child: Text('Tema berhasil dimuat')),
    );
  }
}