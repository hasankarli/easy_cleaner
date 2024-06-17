import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:easy_cleaner/src/helpers/console.dart';
import 'package:easy_cleaner/src/visitors/visitors.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';

final class LocalizationHelpers {
  String generatedClassPath(String generatedClassKey) {
    return convertToSnakeCase(generatedClassKey);
  }

  String convertToSnakeCase(String input) {
    final regex = RegExp(r'(?<!^)(?=[A-Z])');
    return input.replaceAll(regex, '_').toLowerCase();
  }

  Set<String> extractLocaleKeys(String currentPath, String generatedClassPath) {
    final localeKeys = <String>{};
    final glob = Glob('$currentPath/lib/**/$generatedClassPath.g.dart');

    for (var file in glob.listSync()) {
      if (file is File) {
        final content = File(file.path).readAsStringSync();
        final result = parseString(content: content);
        final visitor = LocaleKeysVisitor();
        result.unit.visitChildren(visitor);
        localeKeys.addAll(visitor.keys);
      }
    }

    return localeKeys;
  }

  Set<String> extractBaseKeys(String currentPath, String generatedClassPath) {
    final baseKeys = <String>{};
    final visitor = BaseKeysVisitor();

    final dartFiles =
        Glob('$currentPath/lib/**/$generatedClassPath.g.dart').listSync();
    for (var file in dartFiles) {
      if (file is File) {
        final content = File(file.path).readAsStringSync();
        final result = parseString(content: content);
        result.unit.visitChildren(visitor);
      }
    }

    baseKeys.addAll(visitor.baseKeys);
    return baseKeys;
  }

  Set<String> usedKeys(String currentPath) {
    final usedKeys = <String>{};
    final visitor = KeyUsageVisitor();

    final dartFiles = Glob('$currentPath/lib/**.dart').listSync();
    for (var file in dartFiles) {
      if (file is File) {
        final content = File(file.path).readAsStringSync();
        final result = parseString(content: content);
        result.unit.visitChildren(visitor);
      }
    }

    usedKeys.addAll(visitor.usedKeys);
    return usedKeys;
  }

  void removeUnusedKeysFromJson(String currentPath, Set<String> unusedKeys,
      Set<String> baseKeys, String assetsDir) {
    final jsonFiles = Glob('$currentPath/$assetsDir/**.json').listSync();

    for (var file in jsonFiles) {
      if (file is File) {
        final jsonString = File(file.path).readAsStringSync();
        final jsonMap = jsonDecode(jsonString);

        for (final key in unusedKeys) {
          if (baseKeys.contains(key)) continue;
          removeKey(jsonMap, key);
        }

        final updatedJsonString = JsonEncoder.withIndent('  ').convert(jsonMap);
        File(file.path).writeAsStringSync(updatedJsonString);

        writeSuccess('Updated ${file.path}');
      }
    }
  }

  void removeKey(Map<String, dynamic> map, String key) {
    final keyParts = key.split('_');
    removeNestedKey(map, keyParts);
  }

  void removeNestedKey(Map<String, dynamic> map, List<String> keys) {
    if (keys.isEmpty) return;
    final key = keys.removeAt(0);

    if (keys.isEmpty) {
      map.remove(key);
    } else {
      if (map[key] is Map<String, dynamic>) {
        removeNestedKey(map[key], keys);
        if ((map[key] as Map<String, dynamic>).isEmpty) {
          map.remove(key);
        }
      }
    }
  }
}
