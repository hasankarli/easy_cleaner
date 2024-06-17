import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

class LocaleKeysVisitor extends GeneralizingAstVisitor<void> {
  final keys = <String>{};

  /// Visit variable declarations to extract locale keys
  /// e.g LocaleKeys.home to extract 'home'

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    keys.add(node.name.lexeme);

    super.visitVariableDeclaration(node);
  }
}
