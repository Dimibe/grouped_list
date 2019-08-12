# grouped_list

A Flutter ListView in which ListItems can be grouped to sections.

## Getting Started

 Add the package to your pubspec.yaml:
 
 In your dart file, import the library: 
 
 Instead of using a `ListView` use `GroupedListView` and create your list with the builder constructor:
 
 ```Dart
  GroupedListView.builder(
    elements: _elements,
    groupBy: (element) => element['group'],
    groupSeperatorBuilder: _buildGroupSeperator,
    itemCount: _elements.length,
    itemBuilder: (context, i) => Text(_elements[i]['name']),
  ),
```

You can use all fields from `ListView` but you have to specify three extra fields: 

* The first one is `elements`. Here you need to pass the data you want to group.
* After that you need to specify the `groupBy` function. All elements which share the same value are displayed in the same section. 
* Last you need to specify the `groupSeperator`. This is a Widget which is used as an section seperator.

```Dart
Widget _buildGroupSeperator(dynamic groupByValue) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Text('$element'),
    ],
  );
}
```
The passed parameter is the return value of the defined `groupBy` function for that specific section.
