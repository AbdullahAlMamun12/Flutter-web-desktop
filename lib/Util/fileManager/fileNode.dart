import 'dart:collection';
import 'package:flutter_web_desktop/Util/fileManager/fileIconManager.dart';

abstract class FileNode extends LinkedListEntry<FileNode> {

  final String name;
  final FileType fileType;
  bool canBeDeleted;
   FileNode(this.name, this.fileType, {this.canBeDeleted = true});
}