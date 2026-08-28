import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/catatan.dart';
import 'catatan_provider.dart';

class LayarTambahCatatan extends ConsumerStatefulWidget {
  const LayarTambahCatatan({super.key});

  @override
  ConsumerState<LayarTambahCatatan> createState() => _LayarTambahCatatanState();
}

class _LayarTambahCatatanState extends ConsumerState<LayarTambahCatatan> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _isiController = TextEditingController();

  @override
  void dispose() {
    _judulController.dispose();
    _isiController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (_formKey.currentState!.validate()) {
      final catatanBaru = Catatan(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        judul: _judulController.text,
        isi: _isiController.text,
        dibuatPada: DateTime.now(),
      );
      ref.read(catatanProvider.notifier).tambah(catatanBaru);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Catatan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(labelText: 'Judul'),
                validator: (value) {
                  if (value == null || value.trim().length < 3) {
                    return 'Judul minimal 3 karakter';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _isiController,
                decoration: const InputDecoration(labelText: 'Isi'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Isi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _simpan, child: const Text('Simpan')),
            ],
          ),
        ),
      ),
    );
  }
}
