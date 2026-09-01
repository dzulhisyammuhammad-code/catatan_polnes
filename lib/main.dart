import 'package:flutter/material.dart';

import 'domain/catatan.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/catatan_provider.dart';
import 'presentation/layar_tambah_catatan.dart';
import 'presentation/router.dart'; // Tambahan import untuk peta navigasi
import 'presentation/theme/app_theme.dart'; // Tambahan import untuk tema

import 'package:go_router/go_router.dart'; // Tambahan import untuk context.push
import 'presentation/theme/tokens.dart';
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
      themeMode: ThemeMode.system, // Otomatis mengikuti mode HP pengguna
      routerConfig: router, // Menggunakan konfigurasi router.dart
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
    final daftarCatatan = ref.watch(catatanProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: daftarCatatan.length,
        itemBuilder: (context, index) {
          final catatan = daftarCatatan[index];
          return Dismissible(
            key: Key(catatan.id),
            background: Container(
              color: Theme.of(context).colorScheme.error,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Icon(Icons.delete, color: Theme.of(context).colorScheme.onError),
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
}
