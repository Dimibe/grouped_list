library grouped_list;

import 'package:flutter/material.dart';

class GroupedListView<T, E> extends ListView {
  /// Creates a fixed-length scrollable linear array of list "items" separated
  /// by list item "separators" and "group separators".
  GroupedListView({
    @required E Function(T element) groupBy,
    @required Widget Function(E value) groupSeparatorBuilder,
    @required Widget Function(BuildContext context, T element) itemBuilder,
    GroupedListOrder order = GroupedListOrder.ASC,
    bool sort = true,
    Widget separator = const Divider(height: 0.0),
    List<T> elements,
    Key key,
    Axis scrollDirection = Axis.vertical,
    ScrollController controller,
    bool primary,
    ScrollPhysics physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry padding,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double cacheExtent,
  }) : super.builder(
          key: key,
          scrollDirection: scrollDirection,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          itemCount: elements.length * 2,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          cacheExtent: cacheExtent,
          itemBuilder: (context, index) {
            int actualIndex = index ~/ 2;
            if (index.isEven) {
              E curr = groupBy(elements[actualIndex]);
              E prev = actualIndex - 1 < 0
                  ? null
                  : groupBy(elements[actualIndex - 1]);

              if (prev != curr) {
                return groupSeparatorBuilder(curr);
              }
              return separator;
            }
            return itemBuilder(context, elements[actualIndex]);
          },
        ) {
    if (sort && elements.isNotEmpty) {
      if (groupBy(elements[0]) is Comparable) {
        elements.sort((e1, e2) =>
            (groupBy(e1) as Comparable).compareTo(groupBy(e2) as Comparable));
        if (order == GroupedListOrder.DESC) {
          elements = elements.reversed.toList();
        }
      } else {
        elements
            .sort((e1, e2) => ('${groupBy(e1)}').compareTo('${groupBy(e2)}'));
      }
    }
  }
}

enum GroupedListOrder { ASC, DESC }
