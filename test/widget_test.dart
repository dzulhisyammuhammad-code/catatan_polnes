import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catatan_polnes/main.dart';

void main() {
  testWidgets('Aplikasi menampilkan daftar catatan awal', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    expect(find.text('Belanja bulanan'), findsOneWidget);
    expect(find.text('Tugas PPB'), findsOneWidget);
  });
}
