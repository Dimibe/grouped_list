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

#### Required Parameters:

* `elements`: A list of the data you want to display in the list.
* `groupBy`: Function which maps an element to its grouped value. 
* `groupSeperator`: Function which returns an Widget which is used as an section seperator.

```Dart
Widget _buildGroupSeperator(dynamic groupByValue) {
  return Text('$groupByValue');
}
```
The passed parameter is the return value of the defined `groupBy` function for that specific section.

#### Optional Parameters: 
* `seperator`: A Widget which is used as a seperator between items inside a section. 

### Notic: 
 The item count is the count of the actual items. Seperators and group seperators do not count in here.
 The item builder functions only creates the actual list items for the seperator items use the `seperator` parameter.
