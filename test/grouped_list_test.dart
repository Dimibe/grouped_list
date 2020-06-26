import 'package:flutter_test/flutter_test.dart';

import 'package:grouped_list/grouped_list.dart';
import 'package:flutter/material.dart';

final List _elements = [
  {'name': 'John', 'group': 'Team A'},
  {'name': 'Will', 'group': 'Team B'},
  {'name': 'Beth', 'group': 'Team A'},
  {'name': 'Miranda', 'group': 'Team B'},
  {'name': 'Mike', 'group': 'Team C'},
  {'name': 'Danny', 'group': 'Team C'},
];

void main() {
  Widget _buildGroupSeperator(dynamic element) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('$element'),
      ],
    );
  }

  testWidgets('finds elemets and group separators',
      (WidgetTester tester) async {
    // Build an app with a Text widget that displays the letter 'H'.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GroupedListView(
            groupBy: (element) => element['group'],
            elements: _elements,
            sort: true,
            useStickyGroupSeparators: true,
            order: GroupedListOrder.DESC,
            groupSeparatorBuilder: _buildGroupSeperator,
            itemBuilder: (context, element) => Text(element['name']),
          ),
        ),
      ),
    );

    // Find a widget that displays the letter 'H'.
    expect(find.text('John'), findsOneWidget);
    expect(find.text('Danny'), findsOneWidget);
    expect(find.text('Team A'), findsOneWidget);
    expect(find.text('Team B'), findsOneWidget);
    expect(find.text('Team C'), findsWidgets);
  });

  testWidgets('empty list', (WidgetTester tester) async {
    // Build an app with a Text widget that displays the letter 'H'.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GroupedListView(
            groupBy: (element) => element['group'],
            elements: [],
            useStickyGroupSeparators: true,
            groupSeparatorBuilder: _buildGroupSeperator,
            itemBuilder: (context, element) => Text(element['name']),
          ),
        ),
      ),
    );
  });

  testWidgets('finds only one group separator per group',
      (WidgetTester tester) async {
    // Build an app with a Text widget that displays the letter 'H'.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GroupedListView(
            groupBy: (element) => element['group'],
            elements: _elements,
            useStickyGroupSeparators: true,
            groupSeparatorBuilder: _buildGroupSeperator,
            itemBuilder: (context, element) => Text(element['name']),
          ),
        ),
      ),
    );
    expect(find.text("Team B"), findsOneWidget);
  });
}
