# Change Log for bash-it
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased][unreleased]
### Changed

## [0.1.5] - 2015-08-04
### Changed
- Added a user and group attribute to `bash_it_instance`. User attribute defaults
to name attribute if not specified.  Group will default to root.  Used to set the owner and group of files created


## [0.1.4] - 2015-06-23
### Changed
- Fixed a potential security problem in the bashrc template where the .exports file could exist outside the user's home directory and an unexpected .exports file could be sourced upon reload

## [0.1.3] - 2015-06-17
### Changed
- The bashrc template to check if there are any files matching ~/.bashrc_* before iterating

### Removed
- Docker from the default list of plugins and aliasses

## [0.1.2] - 2015-06-15
### Removed
- An unnessesary only_if guard

## [0.1.1] - 2015-06-15
### Changed
- Fixed Issue #3 where items that were previously enabled were not being disabled

## [0.1.0] - 2015-06-15
### Added
- Global bash-it installation support
- CentOS Platform to TK
- Coveralls.io integration to repo

### Changed

### Removed

## [0.0.2] - 2015-06-09
### Added
- templates_cookbook attribute to bash_it_instance LWRP for wrapper cookbooks

### Changed
- Fixed [Issue #1](https://github.com/edhurtig/bash-it-cookbook/issues/1) where a stateful bug caused convergence failures

### Removed

## 0.0.1 - 2015-06-06
### Added
- Initial Release w/ bash_it_instance LWRP

[unreleased]: https://github.com/edhurtig/bash-it-cookbook/compare/v0.0.2...HEAD
[0.1.0]: https://github.com/edhurtig/bash-it-cookbook/compare/v0.0.2...v0.1.0
[0.0.2]: https://github.com/edhurtig/bash-it-cookbook/compare/v0.0.1...v0.0.2
