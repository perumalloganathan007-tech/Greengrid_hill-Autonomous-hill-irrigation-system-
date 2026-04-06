import 'dart:io';

void main() async {
  final libDir = Directory('lib');
  final testFile = File('test_firebase.dart');

  final files = [
    ...await libDir
        .list(recursive: true)
        .where((e) => e is File && e.path.endsWith('.dart'))
        .cast<File>()
        .toList(),
    testFile,
  ];

  for (final file in files) {
    if (!await file.exists()) continue;
    String content = await file.readAsString();
    bool changed = false;

    if (content.contains('.withOpacity(')) {
      content = content.replaceAllMapped(
        RegExp(r'\.withOpacity\(([^)]+)\)'),
        (match) => '.withValues(alpha: ${match.group(1)})',
      );
      changed = true;
    }

    if (content.contains('print(') && !file.path.endsWith('main.dart')) {
      content = content.replaceAll('print(', 'debugPrint(');
      if (!content.contains("import 'package:flutter/foundation.dart';") &&
          !content.contains('import "package:flutter/foundation.dart";')) {
        content = "import 'package:flutter/foundation.dart';\n$content";
      }
      changed = true;
    } else if (content.contains('print(') && file.path.endsWith('main.dart')) {
      content = content.replaceAll('print(', 'debugPrint(');
      changed = true;
    }

    if (changed) {
      await file.writeAsString(content);
      stdout.writeln('Updated \${file.path}');
    }
  }
}
