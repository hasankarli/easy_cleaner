void writeSuccess(String text) {
  print('✅ \x1B[32m$text\x1B[0m');
}

void writeError(String text) {
  print('❌ \x1B[31m$text\x1B[0m');
}

void writeInfo(String text) {
  print('🚀 \x1B[34m$text\x1B[0m');
}
