import 'package:flutter_test/flutter_test.dart';
import 'package:personal_info_app/main.dart';

void main() {
  testWidgets('App loads test', (WidgetTester tester) async {
    await tester.pumpWidget(const ModernPersonalInfoApp());
  });
}