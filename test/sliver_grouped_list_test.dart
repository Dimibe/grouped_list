import 'package:flutter_test/flutter_test.dart';

import 'package:grouped_list/sliver_grouped_list.dart';
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
  Widget _buildApp(List elements) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          height: 550,
          child: CustomScrollView(
            slivers: [
              SliverGroupedListView(
                groupBy: (dynamic element) => element['group'],
                elements: _elements,
                order: GroupedListOrder.ASC,
                groupSeparatorBuilder: (dynamic element) =>
                    Container(height: 50, child: Text('$element')),
                itemBuilder: (_, dynamic element) => Container(
                  height: 100,
                  child: Text(element['name']),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  testWidgets('finds elemets and group separators',
      (WidgetTester tester) async {
    await tester.pumpWidget(_buildApp(_elements));

    expect(find.text('John'), findsOneWidget);
    expect(find.text('Team A'), findsOneWidget);
    expect(find.text('Team B'), findsOneWidget);
    expect(find.text('Team C'), findsWidgets);
    expect(find.text('Danny'), findsNothing);

    await tester.drag(find.byType(CustomScrollView), const Offset(0.0, -250.0));
    await tester.pump();

    expect(find.text('John'), findsNothing);
    expect(find.text('Danny'), findsOneWidget);
  });

  testWidgets('empty list', (WidgetTester tester) async {
    await tester.pumpWidget(_buildApp([]));
  });

  testWidgets('finds only one group separator per group',
      (WidgetTester tester) async {
    await tester.pumpWidget(_buildApp(_elements));
    expect(find.text('Team B'), findsOneWidget);
  });
}
