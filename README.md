# Grouped list package for Flutter.
[![pub package](https://img.shields.io/pub/v/grouped_list.svg)](https://pub.dev/packages/grouped_list)
[![package publisher](https://img.shields.io/pub/publisher/grouped_list.svg)](https://pub.dev/packages/grouped_list)
![build](https://github.com/Dimibe/grouped_list/actions/workflows/main.yaml/badge.svg??branch=main)
 
A flutter `ListView` in which list items can be grouped to sections.

<img src="https://raw.githubusercontent.com/Dimibe/grouped_list/main/assets/chat_example.png" width="300"><img src="https://raw.githubusercontent.com/Dimibe/grouped_list/main/assets/example.png" width="300">

#### Features
* Sound null safety support!
* Easy creation of chat dialog.
* List Items can be separated in groups.
* For the groups an individual header can be set.
* Almost all fields from `ListView.builder` available.

## Getting Started

Add the package to your pubspec.yaml:

```yaml
 grouped_list: ^6.0.0
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
    itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']), // optional
    useStickyGroupSeparators: true, // optional
    floatingHeader: true, // optional
    order: GroupedListOrder.ASC, // optional
    footer: Text("Widget at the bottom of list"), // optional
  ),
```

### Parameters:
| Name                                                                                   | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                 | Required | Default value |
|----------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----|----|
| `elements`                                                                             | A list of the data you want to display in the list                                                                                                                                                                                                                                                                                                                                                                                                          | required | - |
| `groupBy`                                                                              | Function which maps an element to its grouped value                                                                                                                                                                                                                                                                                                                                                                                                         | required | - |
| `itemBuilder` / `indexedItemBuilder` / `interdependentItemBuilder` / `grouItemBuilder` | Function which returns an Widget which defines the item. <br/> * `indexedItemBuilder` provides the current index as well. <br/> * `interdependentItemBuilder` provides the previous and next items as well.<br/> * `groupItemBuilder` provides information if the item is the first or last element inside a group. <br/>`indexedItemBuilder` is preferred over `interdependentItemBuilder` and `interdependentItemBuilder` is preferred over`itemBuilder`. | yes, either of them | - |
| `groupSeparatorBuilder` / `groupHeaderBuilder`                                         | Function which returns a Widget which defines the group headers. While `groupSeparatorBuilder` gets the `groupBy`-value as parameter `groupHeaderBuilder` gets the whole element. If both are defined `groupHeaderBuilder` is preferred                                                                                                                                                                                                                     | yes, either of them | - |
| `groupStickyHeaderBuilder`                                                             | Function which returns a Widget which defines the sticky group header, when `useStickyGroupSeparators` is `true`. If not defined `groupSeparatorBuilder` or `groupHeaderBuilder` will be used as described above.                                                                                                                                                                                                                                           | no | - |
| `useStickyGroupSeparators`                                                             | When set to true the group header of the current visible group will stick on top                                                                                                                                                                                                                                                                                                                                                                            | no | `false` |
| `floatingHeader`                                                                       | Whether the sticky group header float over the list or occupy it's own space                                                                                                                                                                                                                                                                                                                                                                                | no | `false` |
| `stickyHeaderBackgroundColor`                                                          | Defines the background color of the sticky header. Will only be used if `useStickyGroupSeparators` is used                                                                                                                                                                                                                                                                                                                                                  | no | `Color(0xffF7F7F7)` |
| `separator`                                                                            | A Widget which defines a separator between items inside a group                                                                                                                                                                                                                                                                                                                                                                                             | no | no separator |
| `groupComparator`                                                                      | Can be used to define a custom sorting for the groups. Otherwise the natural sorting order is used                                                                                                                                                                                                                                                                                                                                                          | no | - |
| `itemComparator`                                                                       | Can be used to define a custom sorting for the elements inside each group. Otherwise the natural sorting order is used                                                                                                                                                                                                                                                                                                                                      | no | - |
| `order`                                                                                | Change to `GroupedListOrder.DESC` to reverse the group sorting                                                                                                                                                                                                                                                                                                                                                                                              | no | `GroupedListOrder.ASC` |
| `footer`                                                                               | Widget at the bottom of the list                                                                                                                                                                                                                                                                                                                                                                                                                            | no | - |

**Also the fields from `ListView.builder` can be used.** 


#### Highlight - SilverGroupedList

Now supporting a grouped list based on a silver list. Just use `SilverGroupedListView` instead of `GroupedListView`. An example can be found under `example/lib/example_silver`.
Note that some options of the `GroupedListView` are currently not available in `SilverGroupedListView`.


#### Highlight - Chat Dialog

Easy creation of chat dialogs.
Just set the option `reverse` to `true` and `order` to `GroupedListOrder.DESC`. A full example can be found in the examples.
The list will be scrolled to the end in the initial state and therefore scrolling will be against redeaing direction. 


### My other packages : 

**For easy creation of chat-like dialogs:**

Check out my other package [StickyGroupedList](https://pub.dev/packages/sticky_grouped_list), which is based on the scrollable_positioned_list.

