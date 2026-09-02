import 'package:flutter/material.dart';

import 'domain/catatan.dart';
import 'domain/hasil_catatan.dart'; // Tambahan import

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/catatan_provider.dart';
import 'presentation/layar_tambah_catatan.dart';
import 'presentation/router.dart';
import 'presentation/theme/app_theme.dart';
import 'presentation/theme/tokens.dart';

import 'presentation/widget/keadaan_kosong.dart'; // Tambahan import
import 'presentation/widget/skeleton_daftar.dart'; // Tambahan import

import 'package:go_router/go_router.dart';

const String namaAplikasi = 'Catatan Polnes';

void main() {
  debugPrint('Aplikasi dimulai!');

  final contoh = Catatan(
    id: '1',
    judul: 'Belanja bulanan',
    isi: 'Beli beras, telur, minyak goreng, gula, dan kebutuhan dapur lainnya untuk sebulan',
    dibuatPada: DateTime.now(),
  );
  debugPrint('Map: ${contoh.toMap()}');
  debugPrint('Ringkasan: ${contoh.ringkasan}');
  debugPrint('Baru saja: ${contoh.baruSaja}');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Catatan POLNES',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.terang(),
      darkTheme: AppTheme.gelap(),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    super.initState();
    debugPrint('Halaman utama dibuat!');
  }

  @override
  Widget build(BuildContext context) {
    final hasil = ref.watch(catatanProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: switch (hasil) {
        HasilMemuat() => const SkeletonDaftar(),
        HasilKosong() => const KeadaanKosong(
          ikon: Icons.note_add_outlined,
          judul: 'Belum ada catatan',
          penjelasan: 'Ketuk tombol + untuk menambah catatan pertamamu.',
        ),
        HasilGalat(pesan: final pesan) => KeadaanKosong(
          ikon: Icons.error_outline,
          judul: 'Terjadi kesalahan',
          penjelasan: pesan,
          labelAksi: 'Coba lagi',
          // Komentari sementara karena belum ada method muatUlang()
          // onAksi: () => ref.read(catatanProvider.notifier).muatUlang(),
        ),
        HasilSebagian(data: final data, peringatan: final peringatan) =>
          _daftarCatatan(context, data, peringatan: peringatan),
        HasilBerhasil(data: final data) => _daftarCatatan(context, data),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LayarTambahCatatan()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _daftarCatatan(
    BuildContext context,
    List<Catatan> daftarCatatan, {
    String? peringatan,
  }) {
    return Column(
      children: [
        if (peringatan != null)
          Container(
            width: double.infinity,
            color: Theme.of(context).colorScheme.errorContainer,
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Text(peringatan),
          ),
        Expanded(
          child: ListView.builder(
            itemCount: daftarCatatan.length,
            itemBuilder: (context, index) {
              final catatan = daftarCatatan[index];
              return Dismissible(
                key: Key(catatan.id),
                background: Container(
                  color: Theme.of(context).colorScheme.error,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
                onDismissed: (direction) {
                  ref.read(catatanProvider.notifier).hapus(catatan.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${catatan.judul} dihapus'),
                      action: SnackBarAction(
                        label: 'Urungkan',
                        onPressed: () {
                          ref
                              .read(catatanProvider.notifier)
                              .tambahKembali(catatan, index);
                        },
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(catatan.judul),
                  subtitle: Text(catatan.ringkasan),
                  onTap: () {
                    context.push('/detail', extra: catatan);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
