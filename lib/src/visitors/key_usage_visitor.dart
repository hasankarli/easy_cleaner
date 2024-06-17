import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:easy_cleaner/easy_cleaner.dart';

class KeyUsageVisitor extends GeneralizingAstVisitor<void> {
  final usedKeys = <String>{};

  /// Check for method invocations that might use localization keys
  /// e.g., 'key'.tr(), tr('key'), 'key'.plural(1),
  /// plural('key', 1), LocaleKeys.key.tr(), Text('key').tr()
  @override
  void visitMethodInvocation(MethodInvocation node) {
    final methodName = node.methodName.name;
    if (methodName == 'tr' || methodName == 'plural') {
      _extractKeyFromTarget(node.target);
      _extractKeyFromArgument(node.argumentList);
    }
    super.visitMethodInvocation(node);
  }

  void _extractKeyFromTarget(Expression? target) {
    if (target is SimpleStringLiteral) {
      /// Extract key from the target of a method invocation (e.g., 'key'.tr())
      usedKeys.add(target.value);
    } else if (target is MethodInvocation) {
      if (target.methodName.name == 'Text') {
        /// Handle nested method invocations like Text('key').tr(), Text(LocaleKeys.key).tr()
        _extractKeyFromArgument(target.argumentList);
      }
    } else if (target is PrefixedIdentifier) {
      if (target.prefix.name == EasyCleaner.generatedClassKey) {
        /// Handle cases like LocaleKeys.key.tr() or LocaleKeys.key.plural(1) or Text(LocaleKeys.key.plural(1))
        usedKeys.add(target.identifier.name);
      }
    }
  }

  void _extractKeyFromArgument(ArgumentList argumentList) {
    for (var argument in argumentList.arguments) {
      if (argument is SimpleStringLiteral) {
        /// Handle cases like tr('key') or Text('key').tr() or plural('key', 1) or tr('key), context.tr('key')
        usedKeys.add(argument.value);
      } else if (argument is PrefixedIdentifier &&
          argument.prefix.name == EasyCleaner.generatedClassKey) {
        /// Handle cases like Text(LocaleKeys.key).tr()
        usedKeys.add(argument.identifier.name);
      }
    }
  }
}
