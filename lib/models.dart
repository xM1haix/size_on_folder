import "dart:io";

import "package:flutter/material.dart";

Stream<List<FSE>> listEntities(String path) async* {
  try {
    final dir = Directory(path);
    if (!await dir.exists()) {
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

class DirEntry extends FSE {
  DirEntry({required super.name}) : super(icon: Icons.folder);
}

class FileEntry extends FSE {
  FileEntry({required super.name, required int size})
    : _size = size,
      super(icon: Icons.file_copy_outlined);

  final int _size;

  int get size => _size;
}

abstract class FSE {
  FSE({required String name, required IconData icon})
    : _name = name,
      _icon = icon;
  final IconData _icon;
  final String _name;
  IconData get icon => _icon;

  String get name => _name;
}
