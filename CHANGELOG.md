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
