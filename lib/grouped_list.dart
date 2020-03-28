library grouped_list;

import 'package:flutter/material.dart';

class GroupedListView<T, E> extends StatefulWidget {
  final E Function(T element) groupBy;
  final Widget Function(E value) groupSeparatorBuilder;
  final Widget Function(BuildContext context, T element) itemBuilder;
  final GroupedListOrder order;
  final bool sort;
  final bool useStickyGroupSeparators;
  final Widget separator;
  final List<T> elements;
  final Key key;
  final ScrollController controller;
  final Axis scrollDirection;
  final bool primary;
  final ScrollPhysics physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry padding;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double cacheExtent;

  GroupedListView({
    @required this.groupBy,
    @required this.groupSeparatorBuilder,
    @required this.itemBuilder,
    @required this.elements,
    this.order = GroupedListOrder.ASC,
    this.sort = true,
    this.useStickyGroupSeparators = false,
    this.separator = const Divider(height: 0.0, color: Color.fromRGBO(0, 0, 0, 0)),
    this.key,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GroupedLisdtViewState<T, E>();
}

class _GroupedLisdtViewState<T, E> extends State<GroupedListView<T, E>> {
  ScrollController _controller;
  Map<String, GlobalKey> _keys = Map<String, GlobalKey>();
  List<T> _sortedElements = [];
  GlobalKey _key = GlobalKey();
  int _topElementIndex = 0;

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this._sortedElements = _sortElements();
    return Column(
      key: _key,
      children: <Widget>[
        showFixedGroupHeader(),
        Expanded(
          child: ListView.builder(
            scrollDirection: widget.scrollDirection,
            controller: _getController(),
            primary: widget.primary,
            physics: widget.physics,
            shrinkWrap: widget.shrinkWrap,
            padding: widget.padding,
            itemCount: _sortedElements.length * 2,
            addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
            addRepaintBoundaries: widget.addRepaintBoundaries,
            addSemanticIndexes: widget.addSemanticIndexes,
            cacheExtent: widget.cacheExtent,
            itemBuilder: (context, index) {
              int actualIndex = index ~/ 2;
              if (index == 0) {
                if (widget.useStickyGroupSeparators) {
                  return buildEmptySeparator(actualIndex);
                }
                return _buildGroupSeparator(actualIndex);
              }
              if (index.isEven) {
                E curr = widget.groupBy(_sortedElements[actualIndex]);
                E prev = widget.groupBy(_sortedElements[actualIndex - 1]);
                if (prev != curr) {
                  return _buildGroupSeparator(actualIndex);
                }
                return widget.separator;
              }
              return widget.itemBuilder(context, _sortedElements[actualIndex]);
            },
          ),
        ),
      ],
    );
  }

  Widget buildEmptySeparator(int actualIndex) {
    GlobalKey key = GlobalKey();
    _keys['$actualIndex'] = key;
    return Divider(key: key, color: Color.fromARGB(0, 0, 0, 0));
  }

  Container _buildGroupSeparator(int actualIndex) {
    GlobalKey key = GlobalKey();
    _keys['$actualIndex'] = key;
    return Container(
        key: key,
        child: widget.groupSeparatorBuilder(
            widget.groupBy(_sortedElements[actualIndex])));
  }

  ScrollController _getController() {
    _controller =
        widget.controller == null ? ScrollController() : widget.controller;
    if (widget.useStickyGroupSeparators) {
      _controller.addListener(_scrollListener);
    }
    return _controller;
  }

  _scrollListener() {
    RenderBox listBox = _key.currentContext.findRenderObject();
    double listPos = listBox.localToGlobal(Offset.zero).dy;
    for (var entry in _keys.entries) {
      var key = entry.value;
      if (key.currentContext != null &&
          key.currentContext.findRenderObject() != null) {
        RenderBox itemBox = key.currentContext.findRenderObject();
        var itemHeight = itemBox.size.height;
        double y = itemBox.localToGlobal(Offset(0, -listPos - itemHeight)).dy;
        if (y <= 0) {
          setState(() {
            _topElementIndex = int.parse(entry.key);
          });
        }
      }
    }
  }

  List<T> _sortElements() {
    List<T> elements = widget.elements;
    if (widget.sort && elements.isNotEmpty) {
      if (widget.groupBy(elements[0]) is Comparable) {
        elements.sort((e1, e2) => (widget.groupBy(e1) as Comparable)
            .compareTo(widget.groupBy(e2) as Comparable));
      } else {
        elements.sort((e1, e2) =>
            ('${widget.groupBy(e1)}').compareTo('${widget.groupBy(e2)}'));
      }
      if (widget.order == GroupedListOrder.DESC) {
        elements = elements.reversed.toList();
      }
    }
    return elements;
  }

  Widget showFixedGroupHeader() {
    if (widget.useStickyGroupSeparators && widget.elements.length > 0) {
      return Container(
        child: widget.groupSeparatorBuilder(
            widget.groupBy(_sortedElements[_topElementIndex])),
      );
    }
    return Container();
  }
}

enum GroupedListOrder { ASC, DESC }
