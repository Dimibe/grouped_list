import 'dart:async';
import 'dart:collection';
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'src/GroupedListOrder.dart';

export 'src/GroupedListOrder.dart';

/// A groupable list of widgets similar to [ListView], execpt that the
/// items can be sectioned into groups.
///
/// See [ListView.builder]
class GroupedListView<T, E> extends StatefulWidget {
  /// Items of which [itemBuilder] or [indexedItemBuilder] produce the list.
  final List<T> elements;

  /// Defines which elements are grouped together.
  ///
  /// Function is called for each element in the list, when equal for two
  /// elements, those two belong to the same group.
  final E Function(T element) groupBy;

  /// Can be used to define a custom sorting for the groups.
  ///
  /// If not set groups will be sorted with their natural sorting order or their
  /// specific [Comparable] implementation.
  final int Function(E value1, E value2)? groupComparator;

  /// Can be used to define a custom sorting for the elements inside each group.
  ///
  /// If not set elements will be sorted with their natural sorting order or
  /// their specific [Comparable] implementation.
  final int Function(T element1, T element2)? itemComparator;

  /// Called to build group separators for each group.
  /// Value is always the groupBy result from the first element of the group.
  ///
  /// Will be ignored if [groupHeaderBuilder] is used.
  final Widget Function(E value)? groupSeparatorBuilder;

  /// Same as [groupSeparatorBuilder], will be called to build group separators
  /// for each group.
  /// The passed element is always the first element of the group.
  ///
  /// If defined [groupSeparatorBuilder] wont be used.
  final Widget Function(T element)? groupHeaderBuilder;

  /// Called to build children for the list with
  /// 0 <= element < elements.length.
  final Widget Function(BuildContext context, T element)? itemBuilder;

  /// Called to build children for the list with
  /// 0 <= element, index < elements.length
  final Widget Function(BuildContext context, T element, int index)?
      indexedItemBuilder;

  /// Whether the order of the list is ascending or descending.
  ///
  /// Defaults to ASC.
  final GroupedListOrder order;

  /// Whether the elements will be sorted or not. If not it must be done
  ///  manually.
  ///
  /// Defauts to true.
  final bool sort;

  /// When set to true the group header of the current visible group will stick
  ///  on top.
  final bool useStickyGroupSeparators;

  /// Called to build separators for between each item in the list.
  final Widget separator;

  /// Whether the group headers float over the list or occupy their own space.
  final bool floatingHeader;

  /// Background color of the sticky header.
  /// Only used if [floatingHeader] is false.
  final Color stickyHeaderBackgroundColor;

  /// An object that can be used to control the position to which this scroll
  /// view is scrolled.
  ///
  /// See [ScrollView.controller]
  final ScrollController? controller;

  /// The axis along which the scroll view scrolls.
  ///
  /// Defaults to [Axis.vertical].
  final Axis scrollDirection;

  /// Whether this is the primary scroll view associated with the parent
  /// [PrimaryScrollController].
  ///
  /// See [ScrollView.primary]
  final bool? primary;

  /// How the scroll view should respond to user input.
  ///
  /// See [ScrollView.physics].
  final ScrollPhysics? physics;

  /// Whether the extent of the scroll view in the [scrollDirection] should be
  /// determined by the contents being viewed.
  ///
  /// See [ScrollView.shrinkWrap]
  final bool shrinkWrap;

  /// The amount of space by which to inset the children.
  final EdgeInsetsGeometry? padding;

  /// Whether the view scrolls in the reading direction.
  ///
  /// Defaults to false.
  ///
  /// See [ScrollView.reverse].
  final bool reverse;

  /// Whether to wrap each child in an [AutomaticKeepAlive].
  ///
  /// See [SliverChildBuilderDelegate.addAutomaticKeepAlives].
  final bool addAutomaticKeepAlives;

  /// Whether to wrap each child in a [RepaintBoundary].
  ///
  /// See [SliverChildBuilderDelegate.addRepaintBoundaries].
  final bool addRepaintBoundaries;

  /// Whether to wrap each child in an [IndexedSemantics].
  ///
  /// See [SliverChildBuilderDelegate.addSemanticIndexes].
  final bool addSemanticIndexes;

  /// Creates a scrollable, linear array of widgets that are created on demand.
  ///
  /// See [ScrollView.cacheExtent]
  final double? cacheExtent;

  /// {@macro flutter.widgets.Clip}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// [ScrollViewKeyboardDismissBehavior] the defines how this [ScrollView] will
  /// dismiss the keyboard automatically.
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// {@macro flutter.widgets.scrollable.restorationId}
  final String? restorationId;

  /// The number of children that will contribute semantic information.
  ///
  /// Some subtypes of [ScrollView] can infer this value automatically. For
  /// example [ListView] will use the number of widgets in the child list,
  /// while the [ListView.separated] constructor will use half that amount.
  ///
  /// For [CustomScrollView] and other types which do not receive a builder
  /// or list of widgets, the child count must be explicitly provided. If the
  /// number is unknown or unbounded this should be left unset or set to null.
  ///
  /// See also:
  ///
  ///  * [SemanticsConfiguration.scrollChildCount], the corresponding semantics property.
  final int? semanticChildCount;

  /// If non-null, forces the children to have the given extent in the scroll
  /// direction.
  ///
  /// Specifying an [itemExtent] is more efficient than letting the children
  /// determine their own extent because the scrolling machinery can make use of
  /// the foreknowledge of the children's extent to save work, for example when
  /// the scroll position changes drastically.
  final double? itemExtent;

  /// Creates a [GroupedListView]
  GroupedListView({
    Key? key,
    required this.elements,
    required this.groupBy,
    this.groupComparator,
    this.groupSeparatorBuilder,
    this.groupHeaderBuilder,
    this.itemBuilder,
    this.indexedItemBuilder,
    this.itemComparator,
    this.order = GroupedListOrder.ASC,
    this.sort = true,
    this.useStickyGroupSeparators = false,
    this.separator = const SizedBox.shrink(),
    this.floatingHeader = false,
    this.stickyHeaderBackgroundColor = const Color(0xffF7F7F7),
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.reverse = false,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.clipBehavior = Clip.hardEdge,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.dragStartBehavior = DragStartBehavior.start,
    this.restorationId,
    this.semanticChildCount,
    this.itemExtent,
  })  : assert(itemBuilder != null || indexedItemBuilder != null),
        assert(groupSeparatorBuilder != null || groupHeaderBuilder != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _GroupedListViewState<T, E>();
}

class _GroupedListViewState<T, E> extends State<GroupedListView<T, E>> {
  final StreamController<int> _streamController = StreamController<int>();
  final LinkedHashMap<String, GlobalKey> _keys = LinkedHashMap();
  final GlobalKey _key = GlobalKey();
  late final ScrollController _controller;
  GlobalKey? _groupHeaderKey;
  List<T> _sortedElements = [];
  int _topElementIndex = 0;
  RenderBox? _headerBox;
  RenderBox? _listBox;

  @override
  void initState() {
    _controller = widget.controller ?? ScrollController();
    if (widget.useStickyGroupSeparators) {
      _controller.addListener(_scrollListener);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.useStickyGroupSeparators) {
      _controller.removeListener(_scrollListener);
    }
    if (widget.controller == null) {
      _controller.dispose();
    }
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _sortedElements = _sortElements();
    var hiddenIndex = widget.reverse ? _sortedElements.length * 2 - 1 : 0;
    var _isSeparator =
        widget.reverse ? (int i) => i.isOdd : (int i) => i.isEven;

    if (widget.reverse) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollListener();
      });
    }

    return Stack(
      key: _key,
      alignment: Alignment.topCenter,
      children: <Widget>[
        ListView.builder(
          key: widget.key,
          scrollDirection: widget.scrollDirection,
          controller: _controller,
          primary: widget.primary,
          physics: widget.physics,
          shrinkWrap: widget.shrinkWrap,
          padding: widget.padding,
          reverse: widget.reverse,
          clipBehavior: widget.clipBehavior,
          dragStartBehavior: widget.dragStartBehavior,
          itemExtent: widget.itemExtent,
          restorationId: widget.restorationId,
          keyboardDismissBehavior: widget.keyboardDismissBehavior,
          semanticChildCount: widget.semanticChildCount,
          itemCount: _sortedElements.length * 2,
          addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
          addRepaintBoundaries: widget.addRepaintBoundaries,
          addSemanticIndexes: widget.addSemanticIndexes,
          cacheExtent: widget.cacheExtent,
          itemBuilder: (context, index) {
            var actualIndex = index ~/ 2;
            if (index == hiddenIndex) {
              return Opacity(
                opacity: widget.useStickyGroupSeparators ? 0 : 1,
                child: _buildGroupSeparator(_sortedElements[actualIndex]),
              );
            }
            if (_isSeparator(index)) {
              var curr = widget.groupBy(_sortedElements[actualIndex]);
              var prev = widget.groupBy(
                  _sortedElements[actualIndex + (widget.reverse ? 1 : -1)]);
              if (prev != curr) {
                return _buildGroupSeparator(_sortedElements[actualIndex]);
              }
              return widget.separator;
            }
            return _buildItem(context, actualIndex);
          },
        ),
        StreamBuilder<int>(
            stream: _streamController.stream,
            initialData: _topElementIndex,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _showFixedGroupHeader(snapshot.data!);
              }
              return Container();
            }),
      ],
    );
  }

  Widget _buildItem(context, int index) {
    final key = _keys.putIfAbsent('$index', () => GlobalKey());
    final value = _sortedElements[index];
    return KeyedSubtree(
      key: key,
      child: widget.indexedItemBuilder != null
          ? widget.indexedItemBuilder!(context, value, index)
          : widget.itemBuilder!(context, value),
    );
  }

  void _scrollListener() {
    _listBox ??= _key.currentContext?.findRenderObject() as RenderBox?;
    var listPos = _listBox?.localToGlobal(Offset.zero).dy ?? 0;
    _headerBox ??=
        _groupHeaderKey?.currentContext?.findRenderObject() as RenderBox?;
    var headerHeight = _headerBox?.size.height ?? 0;
    var max = double.negativeInfinity;
    var topItemKey = widget.reverse ? '${_sortedElements.length - 1}' : '0';
    for (var entry in _keys.entries) {
      var key = entry.value;
      if (_isListItemRendered(key)) {
        var itemBox = key.currentContext!.findRenderObject() as RenderBox;
        // position of the item's top border inside the list view
        var y = itemBox.localToGlobal(Offset(0, -listPos - headerHeight)).dy;
        if (y <= headerHeight && y > max) {
          topItemKey = entry.key;
          max = y;
        }
      }
    }
    var index = math.max(int.parse(topItemKey), 0);
    if (index != _topElementIndex) {
      var curr = widget.groupBy(_sortedElements[index]);
      var prev = widget.groupBy(_sortedElements[_topElementIndex]);

      if (prev != curr) {
        _topElementIndex = index;
        _streamController.add(_topElementIndex);
      }
    }
  }

  List<T> _sortElements() {
    var elements = widget.elements;
    if (widget.sort && elements.isNotEmpty) {
      elements.sort((e1, e2) {
        var compareResult;
        // compare groups
        if (widget.groupComparator != null) {
          compareResult =
              widget.groupComparator!(widget.groupBy(e1), widget.groupBy(e2));
        } else if (widget.groupBy(e1) is Comparable) {
          compareResult = (widget.groupBy(e1) as Comparable)
              .compareTo(widget.groupBy(e2) as Comparable);
        }
        // compare elements inside group
        if ((compareResult == null || compareResult == 0)) {
          if (widget.itemComparator != null) {
            compareResult = widget.itemComparator!(e1, e2);
          } else if (e1 is Comparable) {
            compareResult = e1.compareTo(e2);
          }
        }
        return compareResult;
      });
      if (widget.order == GroupedListOrder.DESC) {
        elements = elements.reversed.toList();
      }
    }
    return elements;
  }

  Widget _showFixedGroupHeader(int topElementIndex) {
    _groupHeaderKey = GlobalKey();
    if (widget.useStickyGroupSeparators && widget.elements.isNotEmpty) {
      T topElement;

      try {
        topElement = _sortedElements[topElementIndex];
      } on RangeError catch (_) {
        topElement = _sortedElements[0];
      }

      return Container(
        key: _groupHeaderKey,
        color:
            widget.floatingHeader ? null : widget.stickyHeaderBackgroundColor,
        width: widget.floatingHeader ? null : MediaQuery.of(context).size.width,
        child: _buildGroupSeparator(topElement),
      );
    }
    return Container();
  }

  bool _isListItemRendered(GlobalKey<State<StatefulWidget>> key) {
    return key.currentContext != null &&
        key.currentContext!.findRenderObject() != null;
  }

  Widget _buildGroupSeparator(T element) {
    if (widget.groupHeaderBuilder == null) {
      return widget.groupSeparatorBuilder!(widget.groupBy(element));
    }
    return widget.groupHeaderBuilder!(element);
  }
}
