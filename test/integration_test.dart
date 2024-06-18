import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:cookie_clicker/main.dart';
import 'mock_client.mocks.dart'; 
import 'dart:convert';

void main() {
  testWidgets('Integration test: full game flow', (WidgetTester tester) async {
    final mockClient = MockClient();

    when(mockClient.get(Uri.parse('http://127.0.0.1:8000/state')))
        .thenAnswer((_) async => http.Response(jsonEncode({
          'cookie_count': 0,
          'click_value': 1,
          'upgrade_cost': 10,
          'factories': []
        }), 200));


    when(mockClient.post(Uri.parse('http://127.0.0.1:8000/click')))
        .thenAnswer((_) async => http.Response(jsonEncode({'cookie_count': 1}), 200));

    when(mockClient.post(Uri.parse('http://127.0.0.1:8000/upgrade')))
        .thenAnswer((_) async => http.Response(jsonEncode({
          'cookie_count': 0,
          'click_value': 2,
          'upgrade_cost': 20
        }), 200));

    when(mockClient.post(Uri.parse('http://127.0.0.1:8000/buy_basic_factory')))
        .thenAnswer((_) async => http.Response(jsonEncode({
          'cookie_count': 0,
          'factories': [{'production_rate': 1}]
        }), 200));


    await tester.pumpWidget(MyApp(client: mockClient));


    await tester.pumpAndSettle(Duration(seconds: 2));


    expect(find.text('Cookies: 0'), findsOneWidget);

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
