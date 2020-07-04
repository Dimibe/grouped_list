# Grouped list package for Flutter.
[![Pub](https://img.shields.io/pub/v/grouped_list.svg)](https://pub.dev/packages/grouped_list)
![CI](https://github.com/Dimibe/grouped_list/workflows/CI/badge.svg?branch=master)
 
A flutter `ListView` in which list items can be grouped to sections.

<img src="https://raw.githubusercontent.com/Dimibe/grouped_list/master/assets/screenshot-for-readme.png" width="300">

#### Features
* List Items can be separated in groups.
* For the groups an individual header can be set.
* Almost all fields from `ListView.builder` available.

## Getting Started

 Add the package to your pubspec.yaml:

 ```yaml
 grouped_list: ^3.2.3
 ```
 
 In your dart file, import the library:

 ```Dart
import 'package:grouped_list/grouped_list.dart';
 ``` 
 
 Instead of using a `ListView` create a `GroupedListView` Widget:
 
 ```Dart
  GroupedListView<dynamic, String>(
    elements: _elements,
    groupBy: (element) => element['group'],
    groupSeparatorBuilder: (String groupByValue) => Text(groupByValue),
    itemBuilder: (context, dynamic element) => Text(element['name']),
    order: GroupedListOrder.ASC,
  ),
```

### Parameters:
| Name | Description | Required | Default value |
|----|----|----|----|
|`elements`| A list of the data you want to display in the list | required | - |
|`groupBy` |Function which maps an element to its grouped value | required | - |
|`itemBuilder` / `indexedItemBuilder`| Function which returns an Widget which defines the item. `indexedItemBuilder` provides the current index as well. If both are defined `indexedItemBuilder` is preferred| yes, either of them | - |
|`groupSeparatorBuilder`| Function which gets the `groupBy`-value and returns an Widget which defines the group header separator | required | - |
|`separator` | A Widget which defines a separator between items inside a group | no | no separator |
| `order` | Change to `GroupedListOrder.DESC` to reverse the group sorting | no | `GroupedListOrder.ASC` |

**Also the fields from `ListView.builder` can be used.** 


### Other packages : 
Check out my other package [StickyGroupedList](https://pub.dev/packages/sticky_grouped_list), which is based on the [scrollable_positioned_list](https://pub.dev/packages/scrollable_positioned_list) and comes with sticky headers!

