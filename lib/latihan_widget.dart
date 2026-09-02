import 'package:flutter/material.dart';
import 'package:catatan_polnes/presentation/theme/tokens.dart';

class KartuJudul extends StatelessWidget {
  final String judul;

  const KartuJudul({super.key, required this.judul});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Text(judul, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}

class TandaiSelesai extends StatefulWidget {
  const TandaiSelesai({super.key});

  @override
  State<TandaiSelesai> createState() => _TandaiSelesaiState();
}

class _TandaiSelesaiState extends State<TandaiSelesai> {
  bool _selesai = false;

  void _toggleSelesai() {
    setState(() {
      _selesai = !_selesai;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(_selesai ? 'Selesai' : 'Belum selesai'),
      value: _selesai,
      onChanged: (_) => _toggleSelesai(),
    );
  }
}
