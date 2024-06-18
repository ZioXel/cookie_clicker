import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:cookie_clicker/main.dart'; // Update this path as per your project structure

class MockClient extends Mock implements http.Client {}

void main() {
  testWidgets('Integration test: full game flow', (WidgetTester tester) async {
    final mockClient = MockClient();

    // Mocking responses for different HTTP requests
    when(mockClient.post(Uri.parse('http://127.0.0.1:8000/click')))
        .thenAnswer((_) async => http.Response('{"cookie_count": 1}', 200));

    when(mockClient.post(Uri.parse('http://127.0.0.1:8000/upgrade')))
        .thenAnswer((_) async => http.Response('{"cookie_count": 0, "click_value": 2, "upgrade_cost": 20}', 200));

    when(mockClient.post(Uri.parse('http://127.0.0.1:8000/buy_basic_factory')))
        .thenAnswer((_) async => http.Response('{"cookie_count": 0, "factories": [{"production_rate": 1}]}', 200));

    await tester.pumpWidget(MyApp());

    // Click
    await tester.tap(find.text('Click!'));
    await tester.pump();
    expect(find.text('Cookies: 1'), findsOneWidget);

    // Upgrade
    await tester.tap(find.text('Upgrade (Cost: 10)'));
    await tester.pump();
    expect(find.text('Upgrade (Cost: 20)'), findsOneWidget);

    // Buy Basic Factory
    await tester.tap(find.text('Buy Basic Factory (Cost: 10)'));
    await tester.pump();
    expect(find.text('Factories: Basic'), findsOneWidget);
  });
}
