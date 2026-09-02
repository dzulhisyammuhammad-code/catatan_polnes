import 'package:flutter/material.dart';

import '../domain/catatan.dart';
import 'theme/tokens.dart';

class LayarDetailCatatan extends StatelessWidget {
  final Catatan catatan;

  const LayarDetailCatatan({super.key, required this.catatan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(catatan.judul)),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(catatan.isi, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: AppSpacing.md),
            Text('Dibuat: ${catatan.dibuatPada}'),
            Text('Status: ${catatan.selesai ? "Selesai" : "Belum selesai"}'),
          ],
        ),
      ),
    );
  }
}
