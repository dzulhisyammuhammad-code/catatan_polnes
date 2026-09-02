import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/catatan_repository.dart';
import '../domain/catatan.dart';
import '../domain/hasil_catatan.dart';

final catatanRepositoryProvider = Provider((ref) => CatatanRepository());

class CatatanNotifier extends Notifier<HasilCatatan> {
  @override
  HasilCatatan build() {
    _muat();
    return HasilMemuat();
  }

  Future<void> _muat() async {
    state = HasilMemuat();
    await Future.delayed(const Duration(milliseconds: 600));

    final daftar = ref.read(catatanRepositoryProvider).semua();

    if (daftar.isEmpty) {
      state = HasilKosong();
    } else {
      state = HasilBerhasil(daftar);
    }
  }

  void tambah(Catatan catatan) {
    ref.read(catatanRepositoryProvider).tambah(catatan);
    _muat();
  }

  void hapus(String id) {
    ref.read(catatanRepositoryProvider).hapus(id);
    _muat();
  }

  void tambahKembali(Catatan catatan, int index) {
    ref.read(catatanRepositoryProvider).tambah(catatan);
    _muat();
  }
}

final catatanProvider = NotifierProvider<CatatanNotifier, HasilCatatan>(
  CatatanNotifier.new,
);
