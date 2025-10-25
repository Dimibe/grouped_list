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
  Widget buildApp(List elements, {bool reverse = false}) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          height: 550,
          child: GroupedListView(
            groupBy: (dynamic element) => element['group'],
            elements: _elements,
            useStickyGroupSeparators: false,
            reverse: reverse,
            order: GroupedListOrder.ASC,
            groupSeparatorBuilder: (dynamic element) =>
                SizedBox(height: 50, child: Text('$element')),
            itemBuilder: (_, dynamic element, dynamic prevElement) => SizedBox(
              height: 100,
              child: Text(element['name']),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAppWithInterdependency(
    List elements, {
    bool reverse = false,
    GroupedListOrder sortOrder = GroupedListOrder.ASC,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: GroupedListView(
          groupBy: (dynamic element) => element['group'],
          elements: elements,
          useStickyGroupSeparators: false,
          reverse: false,
          order: sortOrder,
          groupSeparatorBuilder: (dynamic element) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text('$element')),
          interdependentItemBuilder: (_, dynamic previousElement,
                  dynamic currentElement, dynamic nextElement) =>
              Text(
                  '${previousElement?['name']} - ${currentElement?['name']} - ${nextElement?['name']}'),
        ),
      ),
    );
  }

  testWidgets(
      'Finds previous, current and next expected elements using interdependency builder',
      (WidgetTester widgetTester) async {
    var testCase1 = 'Tests with empty list';
    await widgetTester
        .pumpWidget(buildAppWithInterdependency(_elements.sublist(0, 0)));
    expect(find.text('null - null - null'), findsNothing, reason: testCase1);
    expect(find.text('null - John - null'), findsNothing, reason: testCase1);
    expect(find.text('Team A'), findsNothing, reason: testCase1);
    expect(find.text('Team B'), findsNothing, reason: testCase1);
    expect(find.text('Team C'), findsNothing, reason: testCase1);

    var testCase2 = 'Tests with list containing 1 element';
    await widgetTester
        .pumpWidget(buildAppWithInterdependency(_elements.sublist(0, 1)));
    expect(find.text('null - null - null'), findsNothing, reason: testCase2);
    expect(find.text('null - John - null'), findsOneWidget, reason: testCase2);
    expect(find.text('Team A'), findsOneWidget, reason: testCase2);
    expect(find.text('Team B'), findsNothing, reason: testCase1);
    expect(find.text('Team C'), findsNothing, reason: testCase1);

    var testCase3 = 'Tests with list containing 2 elements';
    await widgetTester
        .pumpWidget(buildAppWithInterdependency(_elements.sublist(0, 2)));
    expect(find.text('null - null - null'), findsNothing, reason: testCase3);
    expect(find.text('null - John - Will'), findsOneWidget, reason: testCase3);
    expect(find.text('John - Will - null'), findsOneWidget, reason: testCase3);
    expect(find.text('Team A'), findsOneWidget, reason: testCase3);
    expect(find.text('Team B'), findsOneWidget, reason: testCase3);
    expect(find.text('Team C'), findsNothing, reason: testCase3);

    var testCase4 = 'Tests with list containing 3 elements';
    await widgetTester
        .pumpWidget(buildAppWithInterdependency(_elements.sublist(0, 3)));
    expect(find.text('null - null - null'), findsNothing, reason: testCase4);
    expect(find.text('null - John - Beth'), findsOneWidget, reason: testCase4);
    expect(find.text('John - Beth - Will'), findsOneWidget, reason: testCase4);
    expect(find.text('Beth - Will - null'), findsOneWidget, reason: testCase4);
    expect(find.text('Team A'), findsOneWidget, reason: testCase3);
    expect(find.text('Team B'), findsOneWidget, reason: testCase3);
    expect(find.text('Team C'), findsNothing, reason: testCase3);

    var testCase5 = 'Tests with list containing all elements';
    await widgetTester.pumpWidget(buildAppWithInterdependency(_elements));
    expect(find.text('null - null - null'), findsNothing, reason: testCase5);
    expect(find.text('null - John - Beth'), findsOneWidget, reason: testCase5);
    expect(find.text('John - Beth - Will'), findsOneWidget, reason: testCase5);
    expect(find.text('Beth - Will - Miranda'), findsOneWidget,
        reason: testCase5);
    expect(find.text('Will - Miranda - Mike'), findsOneWidget,
        reason: testCase5);
    expect(find.text('Miranda - Mike - Danny'), findsOneWidget,
        reason: testCase5);
    expect(find.text('Mike - Danny - null'), findsOneWidget, reason: testCase5);
    expect(find.text('Team A'), findsOneWidget, reason: testCase3);
    expect(find.text('Team B'), findsOneWidget, reason: testCase3);
    expect(find.text('Team C'), findsOneWidget, reason: testCase3);

    var testCase6 = 'Tests with list containing all elements in reverse order';
    await widgetTester
        .pumpWidget(buildAppWithInterdependency(_elements, reverse: true));
    expect(find.text('null - null - null'), findsNothing, reason: testCase6);
    expect(find.text('Mike - Danny - null'), findsOneWidget, reason: testCase6);
    expect(find.text('Miranda - Mike - Danny'), findsOneWidget,
        reason: testCase6);
    expect(find.text('Will - Miranda - Mike'), findsOneWidget,
        reason: testCase6);
    expect(find.text('Beth - Will - Miranda'), findsOneWidget,
        reason: testCase6);
    expect(find.text('John - Beth - Will'), findsOneWidget, reason: testCase6);
    expect(find.text('null - John - Beth'), findsOneWidget, reason: testCase6);
    expect(find.text('Team A'), findsOneWidget, reason: testCase6);
    expect(find.text('Team B'), findsOneWidget, reason: testCase6);
    expect(find.text('Team C'), findsOneWidget, reason: testCase6);

    var testCase7 =
        'Tests with list containing all elements sorted in reverse order';
    await widgetTester.pumpWidget(buildAppWithInterdependency(_elements,
        sortOrder: GroupedListOrder.DESC));
    expect(find.text('null - null - null'), findsNothing, reason: testCase7);
    expect(find.text('null - Danny - Mike'), findsOneWidget, reason: testCase7);
    expect(find.text('Danny - Mike - Miranda'), findsOneWidget,
        reason: testCase7);
    expect(find.text('Mike - Miranda - Will'), findsOneWidget,
        reason: testCase7);
    expect(find.text('Miranda - Will - Beth'), findsOneWidget,
        reason: testCase7);
    expect(find.text('Will - Beth - John'), findsOneWidget, reason: testCase7);
    expect(find.text('Beth - John - null'), findsOneWidget, reason: testCase7);
    expect(find.text('Team A'), findsOneWidget, reason: testCase7);
    expect(find.text('Team B'), findsOneWidget, reason: testCase7);
    expect(find.text('Team C'), findsOneWidget, reason: testCase7);
  });

  testWidgets('finds elemets and group separators',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildApp(_elements));

    expect(find.text('John'), findsOneWidget);
    expect(find.text('Team A'), findsOneWidget);
    expect(find.text('Team B'), findsOneWidget);
    expect(find.text('Team C'), findsWidgets);
    expect(find.text('Danny'), findsNothing);

    await tester.drag(find.byType(GroupedListView), const Offset(0.0, -250.0));
    await tester.pump();

    expect(find.text('John'), findsNothing);
    expect(find.text('Danny'), findsOneWidget);
  });

  testWidgets('finds elemets and group separators with reverse list',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildApp(_elements, reverse: true));

    expect(find.text('John'), findsOneWidget);
    expect(find.text('Team A'), findsOneWidget);
    expect(find.text('Team B'), findsOneWidget);
    expect(find.text('Team C'), findsNothing);
    expect(find.text('Danny'), findsNothing);

    await tester.drag(find.byType(GroupedListView), const Offset(0.0, 250.0));
    await tester.pump();

    expect(find.text('John'), findsNothing);
    expect(find.text('Team C'), findsOneWidget);
    expect(find.text('Danny'), findsOneWidget);
  });

  testWidgets('empty list', (WidgetTester tester) async {
    await tester.pumpWidget(buildApp([]));
  });

  testWidgets('empty reversed list', (WidgetTester tester) async {
    await tester.pumpWidget(buildApp([], reverse: true));
  });

  testWidgets('finds only one group separator per group',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildApp(_elements));
    expect(find.text('Team B'), findsOneWidget);
  });
}
