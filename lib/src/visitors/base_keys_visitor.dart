import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

class BaseKeysVisitor extends GeneralizingAstVisitor<void> {
  final baseKeys = <String>{};

  /// Visit variable declarations to extract base keys
  /// e.g. currencies_usd = currencies.usd to extract 'currencies'
  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    final name = node.name.lexeme;
    final parts = name.split('_');
    if (parts.length > 1 && node.initializer.toString().contains('.')) {
      baseKeys.add(parts[0]);
    }
    super.visitVariableDeclaration(node);
  }
}
