import 'package:flutter_test/flutter_test.dart';
import 'package:catatan_polnes/domain/catatan.dart';

void main() {
  group('Catatan', () {
    test('constructor mengisi semua field dengan benar', () {
      final catatan = Catatan(
        id: '1',
        judul: 'Judul',
        isi: 'Isi',
        dibuatPada: DateTime(2026, 1, 1),
      );
      expect(catatan.id, '1');
      expect(catatan.judul, 'Judul');
      expect(catatan.isi, 'Isi');
    });

    test('selesai default-nya false', () {
      final catatan = Catatan(
        id: '1',
        judul: 'Judul',
        isi: 'Isi',
        dibuatPada: DateTime.now(),
      );
      expect(catatan.selesai, false);
    });

    test('copyWith mengubah field yang diminta saja', () {
      final asli = Catatan(
        id: '1',
        judul: 'Judul',
        isi: 'Isi',
        dibuatPada: DateTime.now(),
      );
      final baru = asli.copyWith(selesai: true);
      expect(baru.selesai, true);
      expect(baru.judul, asli.judul);
    });

    test('copyWith tidak mengubah objek asli', () {
      final asli = Catatan(
        id: '1',
        judul: 'Judul',
        isi: 'Isi',
        dibuatPada: DateTime.now(),
      );
      asli.copyWith(selesai: true);
      expect(asli.selesai, false);
    });

    test('dua objek dengan nilai sama dianggap ==', () {
      final tanggal = DateTime(2026, 1, 1);
      final a = Catatan(id: '1', judul: 'X', isi: 'Y', dibuatPada: tanggal);
      final b = Catatan(id: '1', judul: 'X', isi: 'Y', dibuatPada: tanggal);
      expect(a == b, true);
    });

    test('dua objek dengan status beda dianggap tidak ==', () {
      final tanggal = DateTime(2026, 1, 1);
      final a = Catatan(id: '1', judul: 'X', isi: 'Y', dibuatPada: tanggal);
      final b = a.copyWith(selesai: true);
      expect(a == b, false);
    });

    test('toMap menghasilkan semua field', () {
      final catatan = Catatan(
        id: '1',
        judul: 'Judul',
        isi: 'Isi',
        dibuatPada: DateTime(2026, 1, 1),
      );
      final map = catatan.toMap();
      expect(map['id'], '1');
      expect(map['judul'], 'Judul');
      expect(map['selesai'], false);
    });

    test('fromMap mengembalikan objek yang sama dengan toMap-nya', () {
      final asli = Catatan(
        id: '1',
        judul: 'Judul',
        isi: 'Isi',
        dibuatPada: DateTime(2026, 1, 1),
      );
      final hasil = Catatan.fromMap(asli.toMap());
      expect(hasil, asli);
    });

    test('ringkasan tidak memotong teks pendek', () {
      final catatan = Catatan(
        id: '1',
        judul: 'Judul',
        isi: 'Pendek',
        dibuatPada: DateTime.now(),
      );
      expect(catatan.ringkasan, 'Pendek');
    });

    test('ringkasan memotong teks panjang dengan elipsis', () {
      final catatan = Catatan(
        id: '1',
        judul: 'Judul',
        isi: 'A' * 50,
        dibuatPada: DateTime.now(),
      );
      expect(catatan.ringkasan.endsWith('...'), true);
      expect(catatan.ringkasan.length, 43);
    });

    test('baruSaja true untuk catatan yang baru dibuat', () {
      final catatan = Catatan(
        id: '1',
        judul: 'Judul',
        isi: 'Isi',
        dibuatPada: DateTime.now(),
      );
      expect(catatan.baruSaja, true);
    });

    test('baruSaja false untuk catatan lama', () {
      final catatan = Catatan(
        id: '1',
        judul: 'Judul',
        isi: 'Isi',
        dibuatPada: DateTime.now().subtract(const Duration(days: 2)),
      );
      expect(catatan.baruSaja, false);
    });
  });
}
