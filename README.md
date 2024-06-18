# Easy Cleaner

[![pub package](https://img.shields.io/pub/v/easy_cleaner.svg)](https://pub.dev/packages/easy_cleaner)
[![codecov](https://codecov.io/gh/hasankarli/easy_cleaner/branch/feature_actions/graph/badge.svg?token=JCT4XQ5A47)](https://codecov.io/gh/hasankarli/easy_cleaner)

Easy Cleaner is a Dart CLI package designed to remove unused locale keys from JSON files used with the `easy_localization` package. It helps keep your localization files clean and manageable by identifying and removing keys that are no longer in use.

## Features

- Extracts all keys from the specified abstract class (default is `LocaleKeys`).
- Searches for key usage in all Dart files within your project.
- Identifies unused keys by comparing all extracted keys with the keys found in use.
- Removes unused keys from your JSON localization files.

## Installation

You can globally install `easy_cleaner` using the Dart package manager:

```sh
dart pub global activate easy_cleaner
```

## Command Line Options

You can customize the behavior of easy_cleaner using the following options:

- `--current-path`: The current path of the project, default is the current directory.
- `--generated-class-key`: The name of the generated class key, default is `LocaleKeys`.
- `--assets-dir`: The directory where the JSON files are located, default is `assets/translations`.

## Example Usage with Options:

```sh
dart run easy_cleaner --current-path /path/to/project --generated-class-key MyCustomKeys --assets-dir path/translations-files
```

## Contributing

Contributions are welcome! Please submit issues and pull requests.

- Fork the repository.
- Create a new branch:
- Make your changes.
- Commit your changes:
- Push to the branch:
- Create a new Pull Request
  
