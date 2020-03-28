# Grouped list package for Flutter 

A Flutter `ListView` in which list items can be grouped to sections.

<img src="https://raw.githubusercontent.com/Dimibe/grouped_list/master/assets/screenshot-for-readme.png" width="300">

#### Features
* All fields from `ListView.builder` constructor available.
* List Items can be separated in groups.
* For the groups an individual header can be set.
* Sticky Headers. Option to stick top header at the top.
* Option to sort the groups.

## Getting Started

 Add the package to your pubspec.yaml:

 ```yaml
 grouped_list: ^2.0.1
 ```
 
 In your dart file, import the library:

 ```Dart
import 'package:grouped_list/grouped_list.dart';
 ``` 
 
 Instead of using a `ListView` create a `GroupedListView` Widget:
 
 ```Dart
  GroupedListView(
    elements: _elements,
    groupBy: (element) => element['group'],
    groupSeparatorBuilder: _buildGroupSeparator,
    itemBuilder: (context, element) => Text(element['name']),
    order: GroupedListOrder.ASC,
  ),
```

You can also use most fields from the `ListView.builder` constructor.

#### Required Parameters:

* `elements`: A list of the data you want to display in the list.
* `groupBy`: Function which maps an element to its grouped value. 
* `itemBuilder`: Function which returns an Widget which defines the item.
* `groupSeparator`: Function which returns an Widget which defines the section separator.
```Dart
Widget _buildGroupSeparator(dynamic groupByValue) {
  return Text('$groupByValue');
}
```
The parameter `groupByValue` has the return type of the defined `groupBy` function.

#### Optional Parameters: 
* `useStickyGroupSeparators`. If set to true the top `groupSeparator` will stick on top. Default is `false`.
* `order`: By default it's `GroupedListOrder.ASC`. Change to `GroupedListOrder.DESC` for reversing the group sorting.
* `separator`: A Widget which defines a separator between items inside a section. 
* `sort`: A bool which defines if the passed data should be sorted by the widget. By default it's `true`.

### Notice: 
 * The item builder functions only creates the actual list items. For seperator items use the `separator` parameter.
 * Other than the `itemBuilder` function of the `ListView.builder` constructor the function provides the specific element instead of the index as parameter.
 * The elements need to be sorted according to the `groupBy` return value. The Widgets sorts the elements by default. Disable the sorting only if your list is sorted beforehand.

