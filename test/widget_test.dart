import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:cookie_clicker/main.dart';
import 'mock_client.mocks.dart'; // Ensure this is the correct mock file name

void main() {
  // Initialize StringBuffer to store test results
  StringBuffer testResultsBuffer = StringBuffer();

  testWidgets('Click button increases cookie count', (WidgetTester tester) async {
    final mockClient = MockClient();
    when(mockClient.post(Uri.parse('http://127.0.0.1:8000/click')))
        .thenAnswer((_) async => http.Response('{"cookie_count": 1}', 200));

    await tester.pumpWidget(MyApp(client: mockClient)); // Pass mockClient here
    await tester.tap(find.text('Click!'));
    await tester.pump();

    expect(find.text('Cookies: 1'), findsOneWidget);

    // Add test result to StringBuffer
    testResultsBuffer.writeln('Click button increases cookie count: Passed');
  });

  testWidgets('Upgrade button increases click value', (WidgetTester tester) async {
    final mockClient = MockClient();
    when(mockClient.post(Uri.parse('http://127.0.0.1:8000/upgrade')))
        .thenAnswer((_) async => http.Response('{"cookie_count": 0, "click_value": 2, "upgrade_cost": 20}', 200));

    await tester.pumpWidget(MyApp(client: mockClient)); // Pass mockClient here
    await tester.tap(find.text('Upgrade (Cost: 10)'));
    await tester.pump();

    expect(find.text('Upgrade (Cost: 20)'), findsOneWidget);

    // Add test result to StringBuffer
    testResultsBuffer.writeln('Upgrade button increases click value: Passed');
  });

  testWidgets('Buy Basic Factory button adds a Basic factory', (WidgetTester tester) async {
    final mockClient = MockClient();
    when(mockClient.post(Uri.parse('http://127.0.0.1:8000/buy_basic_factory')))
        .thenAnswer((_) async => http.Response('{"cookie_count": 0, "factories": [{"production_rate": 1}]}', 200));

    await tester.pumpWidget(MyApp(client: mockClient)); // Pass mockClient here
    await tester.tap(find.text('Buy Basic Factory (Cost: 10)'));
    await tester.pump();

    expect(find.textContaining('Factories: Basic'), findsOneWidget);

    // Add test result to StringBuffer
    testResultsBuffer.writeln('Buy Basic Factory button adds a Basic factory: Passed');
  });

  testWidgets('Buy Advanced Factory button adds an Advanced factory', (WidgetTester tester) async {
    final mockClient = MockClient();
    when(mockClient.post(Uri.parse('http://127.0.0.1:8000/buy_advanced_factory')))
        .thenAnswer((_) async => http.Response('{"cookie_count": 0, "factories": [{"production_rate": 2}]}', 200));

    await tester.pumpWidget(MyApp(client: mockClient)); // Pass mockClient here
    await tester.tap(find.text('Buy Advanced Factory (Cost: 20)'));
    await tester.pump();

    expect(find.textContaining('Factories: Advanced'), findsOneWidget);

    // Add test result to StringBuffer
    testResultsBuffer.writeln('Buy Advanced Factory button adds an Advanced factory: Passed');
  });

  testWidgets('Reset Game button resets the game state', (WidgetTester tester) async {
    final mockClient = MockClient();
    when(mockClient.post(Uri.parse('http://127.0.0.1:8000/reset_game')))
        .thenAnswer((_) async => http.Response('{"cookie_count": 0, "click_value": 1, "upgrade_cost": 10, "factories": []}', 200));

    await tester.pumpWidget(MyApp(client: mockClient)); // Pass mockClient here
    await tester.tap(find.text('Reset Game'));
    await tester.pump();

    expect(find.text('Cookies: 0'), findsOneWidget);
    expect(find.text('Upgrade (Cost: 10)'), findsOneWidget);
    expect(find.textContaining('Factories: '), findsNothing);

    // Add test result to StringBuffer
    testResultsBuffer.writeln('Reset Game button resets the game state: Passed');
  });

  testWidgets('Server state updates UI every second', (WidgetTester tester) async {
    final mockClient = MockClient();
    when(mockClient.get(Uri.parse('http://127.0.0.1:8000/state')))
        .thenAnswer((_) async => http.Response('{"cookie_count": 10, "click_value": 1, "upgrade_cost": 10, "factories": []}', 200));

    await tester.pumpWidget(MyApp(client: mockClient)); // Pass mockClient here
    await tester.pump(Duration(seconds: 1));

    expect(find.text('Cookies: 10'), findsOneWidget);

    // Add test result to StringBuffer
    testResultsBuffer.writeln('Server state updates UI every second: Passed');
  });

  // Save test results to a file after all tests have run
  tearDownAll(() async {
    var testFilePath = './test_results.txt';
    var file = File(testFilePath);
    
    await file.writeAsString(testResultsBuffer.toString());

    print('Test results saved to $testFilePath');
  });
}
