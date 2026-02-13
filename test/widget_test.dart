import 'package:flutter_test/flutter_test.dart';
import 'package:ultima_application/main.dart';

void main() {
  testWidgets('Check if app starts correctly', (WidgetTester tester) async {
    // Nabniw l-app (Ama mouch bch n-tap-iw counter khater tna77a)
    await tester.pumpWidget(const MyApp());
    
    // Nthabbto elli l-App bdét b-s7i7 men ghir Crash
    expect(find.byType(MyApp), findsOneWidget);
  });
}