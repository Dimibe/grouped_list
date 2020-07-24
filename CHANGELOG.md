## [1.0.0] - 13.08.2019

* Initial release

## [1.1.0] - 14.08.2019

* Added example
* Edited readme and package description

## [1.2.0] - 15.08.2019

* Widget sort the list elements now according the `groupBy`value. Can be switched off through the parameter `sort`

## [1.2.1] - 18.08.2019

* Improved documentary

## [1.3.0] - 10.03.2020

* Add `order` option to the widget. With this the sorting of the groups can be reversed.

## [1.3.1] - 12.03.2020

* Bugfix: The `order` option also works for groups which aren't comparable.

## [2.0.0] - 18.03.2020

* New Feature: Sticky Headers!
** To use the sticky header set `useStickyGroupSeparators` to `true`.
** The parameter `elements` is now required.
* Due to potential beaking changes the feature comes with a new major release.

## [2.0.1] - 28.03.2020

* Bugfix: If no `separator` was specified a divider was rendered.
* Bugfix: Adding items dynamically to an existing group led to a new group to be created.

## [2.0.2] - 28.03.2020

* Documentation

## [2.1.0] - 02.04.2020

* Fixed bug where wrong headers are displayed while using sticky headers.

## [2.2.0] - 04.04.2020

* Sorting items inside groups according to its comparable implmentation or alphabetical order.
* Fixed bug where items rendered wrong

## [2.3.0] - 06.04.2020

* New Feature: Indexed item builder. You can now define `indexedItemBuilder` instead of `itemBuilder`. The new method additionally provides the the current index as attribute. 

## [2.3.1] - 04.05.2020

* Bugfix: dispose controller only if not set throgh the widet.   

## [3.0.0] - 05.05.2020

* New Feature: Floating Header - Sticky Headers can now float over the list. Set `floatingHeader` to `true`. 
* Sticky Headers now by default active. Can be disabled by setting `useStickyGroupSeparators` to `false`. 
* Bugfix: The Widget can now be used in `SliverChildListDelegate`.

## [3.0.1] - 18.05.2020

* Bugfix: error when groupby value not comparable. 
* Bugfix: only set state when needed.

## [3.1.0] - 21.05.2020

* Sticky Headers now by default disabled.

## [3.2.0] - 23.06.2020

* Fixed performance issue when sticky group headers are actived. Widget now rebuilds only when necessary

## [3.2.1] - 26.06.2020

* Improved documentation
* Improved example

## [3.2.2] - 26.06.2020

* Fixed readme

## [3.2.3] - 04.07.2020

* Add code documentation

## [3.3.0] - 24.07.2020

* Fix performance issue: Don't rebuild widget when sticky header changes.