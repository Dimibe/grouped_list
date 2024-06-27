## [6.0.0] - 27.06.2024
### Features: 
* feat: interdependent items builder [GH-175](https://github.com/Dimibe/grouped_list/pull/175)
* feat: add groupStickyHeaderBuilder [GH-126](https://github.com/Dimibe/grouped_list/pull/126)
* feat: added footer widget [GH-189](https://github.com/Dimibe/grouped_list/pull/189)
* feat: group section style [GH-206](https://github.com/Dimibe/grouped_list/pull/206)

### Bugfixes:
* fix: distinct key parent child [GH-171](https://github.com/Dimibe/grouped_list/pull/171)
* fix RangeError when _sortedElements is empty [GH-164](https://github.com/Dimibe/grouped_list/pull/164)
* fix: wrong initial sticky header [GH-198](https://github.com/Dimibe/grouped_list/pull/198)

## [5.1.3] - 09.04.2023

* Prepare for dart 3

## [5.1.2] - 18.06.2022

* Documentation improvements

## [5.1.1] - 28.05.2022

* Support older sdk versions

## [5.1.0] - 28.05.2022

* Make package backwards compatible to Flutter < 3.0.0 
* Bugfix: package does not modify passed element list anymore

## [5.0.1] - 18.05.2022

* Bugfix: Fix lint error 

## [5.0.0] - 18.05.2022

* Feature: Upgrade to flutter 3.0 and use flutter_lints [Pull Request #148](https://github.com/Dimibe/grouped_list/pull/148) 
* Bugfix: Fixes update to version 3.0 of flutter [Pull Request #147](https://github.com/Dimibe/grouped_list/pull/147) 
* Bugfix: Resolve out of range error [Pull Request #138](https://github.com/Dimibe/grouped_list/pull/138) 

## [4.2.0] - 04.02.2022

* Bugfixes: Fix bug where item is rebuild every time state changes [Pull Request #132](https://github.com/Dimibe/grouped_list/pull/132) 

## [4.1.0] - 22.07.2021

* New feature: Silver support [Pull Request #112](https://github.com/Dimibe/grouped_list/pull/112) 
* Bugfixes: Fix bug where a out of range error could appear [Pull Request #110](https://github.com/Dimibe/grouped_list/pull/110) 

## [4.0.0] - 27.03.2021

* Null safety

## [4.0.0-nullsafety.1] - 20.11.2020

* Update example to support null safety
* Add pedantic for code analysis
* Bugfixes: Fix bug where removeListener is called on null [Issue #64](https://github.com/Dimibe/grouped_list/issues/64) 

## [4.0.0-nullsafety.0] - 20.11.2020

* New feature: Add support for null safety.

## [3.7.0] - 15.11.2020

* New feature: Add new options from ListView.
* Bug fixes: reverse option works with empty list

## [3.6.0] - 14.11.2020

* New feature: Add `reverse` option from ListView.

## [3.5.0] - 19.09.2020

* New feature custom sorting. Added two new options `groupComparator` and `itemComparator`which can be used for comparison between two groups and items. If used the functions will be used for sorting the list.

## [3.4.0] - 06.09.2020

* New option `groupHeaderBuilder`: Same as `groupSeparatorBuilder` but will get the whole element instead of just the groupBy value.
* New option `stickyHeaderBackgroundColor`: If `useStickyGroupSeparators` used a custom background color can be set.

## [3.3.0] - 24.07.2020

* Fix performance issue: Don't rebuild widget when sticky header changes.

## [3.2.3] - 04.07.2020

* Add code documentation

## [3.2.2] - 26.06.2020

* Fixed readme

## [3.2.1] - 26.06.2020

* Improved documentation
* Improved example

## [3.2.0] - 23.06.2020

* Fixed performance issue when sticky group headers are actived. Widget now rebuilds only when necessary

## [3.1.0] - 21.05.2020

* Sticky Headers now by default disabled.

## [3.0.1] - 18.05.2020

* Bugfix: error when groupby value not comparable. 
* Bugfix: only set state when needed.

## [3.0.0] - 05.05.2020

* New Feature: Floating Header - Sticky Headers can now float over the list. Set `floatingHeader` to `true`. 
* Sticky Headers now by default active. Can be disabled by setting `useStickyGroupSeparators` to `false`. 
* Bugfix: The Widget can now be used in `SliverChildListDelegate`.

## [2.3.1] - 04.05.2020

* Bugfix: dispose controller only if not set throgh the widet. 

## [2.3.0] - 06.04.2020

* New Feature: Indexed item builder. You can now define `indexedItemBuilder` instead of `itemBuilder`. The new method additionally provides the the current index as attribute. 

## [2.2.0] - 04.04.2020

* Sorting items inside groups according to its comparable implmentation or alphabetical order.
* Fixed bug where items rendered wrong

## [2.1.0] - 02.04.2020

* Fixed bug where wrong headers are displayed while using sticky headers.

## [2.0.2] - 28.03.2020

* Documentation

## [2.0.1] - 28.03.2020

* Bugfix: If no `separator` was specified a divider was rendered.
* Bugfix: Adding items dynamically to an existing group led to a new group to be created.

## [2.0.0] - 18.03.2020

* New Feature: Sticky Headers!
** To use the sticky header set `useStickyGroupSeparators` to `true`.
** The parameter `elements` is now required.
* Due to potential beaking changes the feature comes with a new major release.

## [1.3.1] - 12.03.2020

* Bugfix: The `order` option also works for groups which aren't comparable.

## [1.3.0] - 10.03.2020

* Add `order` option to the widget. With this the sorting of the groups can be reversed.

## [1.2.1] - 18.08.2019

* Improved documentary

## [1.2.0] - 15.08.2019

* Widget sort the list elements now according the `groupBy`value. Can be switched off through the parameter `sort`

## [1.1.0] - 14.08.2019

* Added example
* Edited readme and package description

## [1.0.0] - 13.08.2019

* Initial release