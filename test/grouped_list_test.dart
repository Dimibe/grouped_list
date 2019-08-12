import 'package:flutter_test/flutter_test.dart';

import 'package:grouped_list/grouped_list.dart';
import 'package:flutter/material.dart';

final _elements = [
  {'group': 'a', 'name': 'x'},
  {'group': 'a', 'name': 'y'},
  {'group': 'b', 'name': 'z'},
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

  testWidgets('finds a Text widget', (WidgetTester tester) async {
    // Build an app with a Text widget that displays the letter 'H'.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GroupedListView.builder(
            groupBy: (element) => element['group'],
            elements: _elements,
            groupSeperatorBuilder: _buildGroupSeperator,
            itemCount: _elements.length,
            itemBuilder: (context, i) => Text(_elements[i]['name']),
          ),
        ),
      ),
    );

    // Find a widget that displays the letter 'H'.
    expect(find.text('a'), findsOneWidget);
    expect(find.text('b'), findsOneWidget);
    expect(find.text('x'), findsOneWidget);
    expect(find.text('y'), findsOneWidget);
    expect(find.text('z'), findsOneWidget);
  });
}
