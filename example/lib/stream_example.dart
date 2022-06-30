import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

void main() => runApp(const MyApp());

class Element {
  String name;
  int index;
  Element(this.name, this.index);
}

List<Element> _elements = [];
int counter = 1;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Grouped List View Example'),
        ),
        body: StreamBuilder<List<Element>>(
          stream: _stream(),
          initialData: const [],
          builder: (ctx, snapshot) => _createList(snapshot.data!),
        ),
      ),
    );
  }

  Stream<List<Element>> _stream() async* {
    var rng = Random();
    await Future.delayed(const Duration(seconds: 2));
    for (var i = 0; i < 100; i++) {
      await Future.delayed(const Duration(seconds: 1));
      _elements.add(Element('Item ${counter++}', rng.nextInt(10) + 1));
      yield _elements;
    }
  }

  GroupedListView<dynamic, int> _createList(List<Element> elements) {
    return GroupedListView<Element, int>(
      elements: elements,
      groupBy: (element) => element.index,
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: (e1, e2) => e1.name.compareTo(e2.name),
      order: GroupedListOrder.DESC,
      useStickyGroupSeparators: true,
      groupSeparatorBuilder: (int groupValue) => _createGroupHeader(groupValue),
      itemBuilder: (ctx, element) => _createItem(element.name),
    );
  }

  Widget _createGroupHeader(int groupValue) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '$groupValue',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _createItem(String name) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: SizedBox(
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: const Icon(Icons.account_circle),
          title: Text(name),
          trailing: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
