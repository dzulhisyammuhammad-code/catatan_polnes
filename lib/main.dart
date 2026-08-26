import 'package:flutter/material.dart';
import 'domain/catatan.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/catatan_provider.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF143D6B)),
      ),
      home: const MyHomePage(title: 'Muhammad Dzulhisyam Izbadillah - 256151053'),
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
          return ListTile(
            title: Text(catatan.judul),
            subtitle: Text(catatan.ringkasan),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}