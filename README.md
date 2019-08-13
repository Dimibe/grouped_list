# grouped_list

A Flutter `ListView` in which list items can be grouped to sections.

<img src="./assets/Bildschirmfoto%202019-08-12%20um%2023.07.29.png" width="300">

## Getting Started

 Add the package to your pubspec.yaml:
 
 In your dart file, import the library: 
 
 Instead of using a `ListView` use `GroupedListView` and create your list with the builder constructor:
 
 ```Dart
  GroupedListView.builder(
    elements: _elements,
    groupBy: (element) => element['group'],
    groupSeperatorBuilder: _buildGroupSeperator,
    itemBuilder: (context, element) => Text(element['name']),
  ),
```

You can use all fields from `ListView` but you have to specify three extra fields: 

#### Required Parameters:

* `elements`: A list of the data you want to display in the list.
* `groupBy`: Function which maps an element to its grouped value. 
* `groupSeperator`: Function which returns an Widget which defines the section seperator.
* `itemBuilder`: Function which returns an Widget which defines the item.
```Dart
Widget _buildGroupSeperator(dynamic groupByValue) {
  return Text('$groupByValue');
}
```
The passed parameter is the return value of the defined `groupBy` function for that specific section.

#### Optional Parameters: 
* `seperator`: A Widget which defines a seperator between items inside a section. 

### Notice: 
 The item builder functions only creates the actual list items for the seperator items use the `seperator` parameter.
 Other than the `itemBuilder` function of the `ListView.builder` constructor the function has an element instead of the index as parameter.

