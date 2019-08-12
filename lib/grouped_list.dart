library grouped_list;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GroupedListView<T, E> extends ListView {
  final Widget seperator;
  final Widget Function(E element) groupSeperatorBuilder;

  GroupedListView.builder({
    E Function(T groupedElement) groupBy,
    List<T> elements,
    Key key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController controller,
    bool primary,
    ScrollPhysics physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry padding,
    double itemExtent,
    @required IndexedWidgetBuilder itemBuilder,
    @required this.groupSeperatorBuilder,
    this.seperator = const Divider(height: 0.0),
    int itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double cacheExtent,
    int semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
  }) : super.builder(
          key: key,
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          itemExtent: itemExtent,
          itemCount: itemCount * 2,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          cacheExtent: cacheExtent,
          semanticChildCount: semanticChildCount,
          dragStartBehavior: dragStartBehavior,
          itemBuilder: (context, index) {
            int actualIndex = index ~/ 2;
            if (index.isEven) {
              E curr = groupBy(elements[actualIndex]);
              E prev = actualIndex - 1 < 0
                  ? null
                  : groupBy(elements[actualIndex - 1]);

              if (prev != curr) {
                return groupSeperatorBuilder(curr);
              }
              return seperator;
            }
            return itemBuilder(context, actualIndex);
          },
        );
}
