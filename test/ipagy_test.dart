import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ipagy/src/list/pagy.dart';
import 'package:ipagy/src/widgets/default_empty_widget.dart';
import 'package:ipagy/src/widgets/default_error_widget.dart';
import 'package:ipagy/src/widgets/default_loading_widget.dart';

void main() {
  testWidgets('Pagy renders correctly', (WidgetTester tester) async {
    final List<int> mockItems = List.generate(10, (index) => index);

    await tester.pumpWidget(MaterialApp(
      home: Pagy<int>(
        items: mockItems,
        loadMoreItems: () async {},
        itemBuilder: (BuildContext context, int index) => Text('Item $index'),
      ),
    ));

    for (int i = 0; i < mockItems.length; i++) {
      expect(find.text('Item $i'), findsOneWidget);
    }
  });

  testWidgets('Pagy renders loading widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Pagy<int>(
        items: null,
        loadMoreItems: () async {},
        itemBuilder: (BuildContext context, int index) => Text('Item $index'),
      ),
    ));

    expect(find.byType(DefaultLoadingWidget), findsOneWidget);
  });

  testWidgets('Pagy renders error widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Pagy<int>(
        items: null,
        loadMoreItems: () async {},
        itemBuilder: (BuildContext context, int index) => Text('Item $index'),
        hasError: true,
      ),
    ));

    expect(find.byType(DefaultErrorWidget), findsOneWidget);
  });

  testWidgets('Pagy renders empty widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Pagy<int>(
        items: const [],
        loadMoreItems: () async {},
        itemBuilder: (BuildContext context, int index) => Text('Item $index'),
      ),
    ));

    expect(find.byType(DefaultEmptyWidget), findsOneWidget);
  });
}
