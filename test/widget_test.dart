import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catatan_polnes/main.dart';

void main() {
  testWidgets('Aplikasi menampilkan daftar catatan awal', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    expect(find.text('Belanja bulanan'), findsOneWidget);
    expect(find.text('Tugas PPB'), findsOneWidget);
  });

  testWidgets('Memenuhi pedoman aksesibilitas', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    await expectLater(tester, meetsGuideline(textContrastGuideline));
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    handle.dispose();
  });
}
