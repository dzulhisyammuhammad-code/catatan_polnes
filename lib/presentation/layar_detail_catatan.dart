import 'package:flutter/material.dart';
import '../domain/catatan.dart';

class LayarDetailCatatan extends StatelessWidget {
  final Catatan catatan;

  const LayarDetailCatatan({super.key, required this.catatan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(catatan.judul)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(catatan.isi, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text('Dibuat: ${catatan.dibuatPada}'),
            Text('Status: ${catatan.selesai ? "Selesai" : "Belum selesai"}'),
          ],
        ),
      ),
    );
  }
}