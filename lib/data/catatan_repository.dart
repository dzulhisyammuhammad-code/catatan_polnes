import '../domain/catatan.dart';

class CatatanRepository {
  final List<Catatan> _daftar = [
    Catatan(
      id: '1',
      judul: 'Belanja bulanan',
      isi: 'Beli beras, telur, minyak goreng',
      dibuatPada: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Catatan(
      id: '2',
      judul: 'Tugas PPB',
      isi: 'Kerjakan Job Sheet 2 sampai selesai',
      dibuatPada: DateTime.now(),
    ),
  ];

  List<Catatan> semua() => List.unmodifiable(_daftar);

  void tambah(Catatan catatan) {
    _daftar.add(catatan);
  }

  void hapus(String id) {
    _daftar.removeWhere((c) => c.id == id);
  }

  void perbarui(Catatan catatan) {
    final index = _daftar.indexWhere((c) => c.id == catatan.id);
    if (index != -1) {
      _daftar[index] = catatan;
    }
  }
}