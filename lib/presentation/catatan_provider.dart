import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/catatan_repository.dart';
import '../domain/catatan.dart';

final catatanRepositoryProvider = Provider((ref) => CatatanRepository());

class CatatanNotifier extends Notifier<List<Catatan>> {
  @override
  List<Catatan> build() {
    return ref.read(catatanRepositoryProvider).semua();
  }

  void tambah(Catatan catatan) {
    ref.read(catatanRepositoryProvider).tambah(catatan);
    state = ref.read(catatanRepositoryProvider).semua();
  }

  void hapus(String id) {
    ref.read(catatanRepositoryProvider).hapus(id);
    state = ref.read(catatanRepositoryProvider).semua();
  }
}

final catatanProvider = NotifierProvider<CatatanNotifier, List<Catatan>>(
  CatatanNotifier.new,
);