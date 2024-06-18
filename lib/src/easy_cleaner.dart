import 'dart:io';

import 'package:args/args.dart';
import 'package:easy_cleaner/src/helpers/helpers.dart';

/// A Dart CLI package designed to remove unused locale keys from JSON files
/// used with the `easy_localization` package.
class EasyCleaner {
  /// The current path of the project, default is the current directory
  static String currentPath = Directory.current.path;

  /// The name of the generated class key, default is LocaleKeys
  static String generatedClassKey = 'LocaleKeys';

  /// The directory where the json files are located, default is assets/translations
  static String assetsDir = 'assets/translations';

  static final helpers = LocalizationHelpers();

  static void run(List<String> args) {
    if (isHelpCommand(args)) {
      help();
      return;
    }

    writeInfo('Checking for used keys in $currentPath');

    init(args);

    final generatedClassPath = helpers.generatedClassPath(generatedClassKey);

    final localeKeys =
        helpers.extractLocaleKeys(currentPath, generatedClassPath);
    final usedKeys = helpers.usedKeys(currentPath);
    final baseKeys = helpers.extractBaseKeys(currentPath, generatedClassPath);

    final unusedKeys = localeKeys.difference(usedKeys);

    writeInfo(
        'Found total locale keys: ${localeKeys.length - baseKeys.length}, used keys: ${localeKeys.length - unusedKeys.length}, base keys: ${baseKeys.length}');

    if (unusedKeys.length == baseKeys.length) {
      writeSuccess('All LocaleKeys are used.');
      return;
    } else {
      writeError('Found ${unusedKeys.length - baseKeys.length} unused keys');
    }

    helpers.removeUnusedKeysFromJson(
        currentPath, unusedKeys, baseKeys, assetsDir);
  }

  static void init(List<String> args) {
    var parser = ArgParser();

    parser.addOption('current-path',
        help:
            'The current path of the project, default is the current directory',
        defaultsTo: Directory.current.path, callback: (value) {
      currentPath = value ?? Directory.current.path;
    });

    parser.addOption('generated-class-key',
        help: 'The name of the generated class key, default is LocaleKeys',
        callback: (value) {
      generatedClassKey = value ?? 'LocaleKeys';
    });

    parser.addOption('assets-dir',
        help:
            'The directory where the json files are located, default is assets/translations',
        defaultsTo: 'assets/translations', callback: (value) {
      assetsDir = value ?? 'assets/translations';
    });

    parser.parse(args);
  }

  static bool isHelpCommand(List<String> args) {
    return args.contains('--help') || args.contains('-h');
  }

  static void help() {
    print('Usage: easy_cleaner [options]\n');
    print('Options:');
    print(
        '--current-path\t\tThe current path of the project, default is the current directory');
    print(
        '--generated-class-key\tThe name of the generated class key, default is LocaleKeys');
    print(
        '--assets-dir\t\tThe directory where the json files are located, default is assets/translations');
  }
}
