import 'dart:io';
import 'dart:isolate';

/// Copy the baseX Claude Code skill into the current project.
///
/// Run from the root of the app that depends on baseX:
/// ```sh
/// dart run baseX:install_skill
/// ```
/// Installs to `.claude/skills/basex`, replacing any previous copy.
Future<void> main() async {
  final Uri? libUri = await Isolate.resolvePackageUri(Uri.parse('package:baseX/base_x.dart'));
  if (libUri == null) {
    stderr.writeln('Could not resolve package:baseX. Run `flutter pub get` first.');
    exit(1);
  }

  final Directory packageRoot = File.fromUri(libUri).parent.parent;
  final Directory source = Directory('${packageRoot.path}/skills/basex');
  if (!source.existsSync()) {
    stderr.writeln('Skill not found at ${source.path}. Use baseX >= 0.8.0.');
    exit(1);
  }

  final Directory target = Directory('${Directory.current.path}/.claude/skills/basex');
  if (target.existsSync()) {
    target.deleteSync(recursive: true);
  }

  for (final FileSystemEntity entity in source.listSync(recursive: true)) {
    if (entity is! File) continue;
    final String relative = entity.path.substring(source.path.length + 1);
    final File destination = File('${target.path}/$relative');
    destination.parent.createSync(recursive: true);
    entity.copySync(destination.path);
  }

  stdout.writeln('Installed baseX skill to ${target.path}');
}
