# Easy Cleaner

[![pub package](https://img.shields.io/pub/v/easy_cleaner.svg)](https://pub.dev/packages/easy_cleaner)
[![Coverage Status](https://coveralls.io/repos/github/<username>/easy_cleaner/badge.svg?branch=main)](https://coveralls.io/github/<username>/easy_cleaner?branch=main)

Easy Cleaner is a Dart package designed to remove unused locale keys from JSON files used with the `easy_localization` package. It helps keep your localization files clean and manageable by identifying and removing keys that are no longer in use.

## Features

- Extracts all keys from the specified abstract class (default is `LocaleKeys`).
- Searches for key usage in all Dart files within your project.
- Identifies unused keys by comparing all extracted keys with the keys found in use.
- Removes unused keys from your JSON localization files.

## Installation

Add `easy_cleaner` to your `pubspec.yaml` file:

```yaml
dependencies:
  easy_cleaner: ^1.0.0
