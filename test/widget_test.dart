import 'package:flutter_test/flutter_test.dart';
import 'package:utp_prakmola/main.dart';

void main() {
  testWidgets('Aplikasi Pinterest tampil dengan benar', (tester) async {
    await tester.pumpWidget(const PinterestApp());

    expect(find.text('Pinterest'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}