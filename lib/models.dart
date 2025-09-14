import "dart:io";

import "package:flutter/material.dart";

///[Stream] which returns [List] of [FSE] from [path]
Stream<List<FSE>> listEntities(String path) async* {
  try {
    final dir = Directory(path);
    if (!dir.existsSync()) {
      throw Exception("Dir does not exist: $path");
    }
    final entities = dir.listSync();
    final result = <FSE>[];
    for (final entity in entities) {
      final p = entity.path.substring(path.length);
      if (entity is File) {
        result.add(FileEntry(name: p, size: await entity.length()));
      } else if (entity is Directory) {
        result.add(DirEntry(name: p));
      } else {
        debugPrint("Other: ${entity.path}");
      }
    }
    result.sort((a, b) {
      if (a is DirEntry && b is FileEntry) {
        return -1;
      }
      if (a is FileEntry && b is DirEntry) {
        return 1;
      }
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    yield result;
  } catch (e) {
    debugPrint(e.toString());
    rethrow;
  }
}

///[FSE] only for [Directory]
class DirEntry extends FSE {
  ///
  DirEntry({required super.name, super.icon = Icons.folder});
}

///[FSE] only for [Directory]

class FileEntry extends FSE {
  ///
  FileEntry({
    required super.name,
    required int size,
    super.icon = Icons.file_copy_outlined,
  }) : _size = size;

  final int _size;

  ///The [size] of the file in bytes
  int get size => _size;
}

///Base object for [File] and [Directory]
abstract class FSE {
  ///
  FSE({required String name, required IconData icon})
    : _name = name,
      _icon = icon;
  final IconData _icon;
  final String _name;

  ///Returns the [IconData]
  IconData get icon => _icon;

  ///Returns the [String] representing the [name]
  String get name => _name;
}
