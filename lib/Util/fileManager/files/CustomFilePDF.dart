import 'package:flutter_web_desktop/Util/fileManager/fileIconManager.dart';
import 'package:flutter_web_desktop/Util/fileManager/fileNode.dart';

class CustomFilePDF extends FileNode{

  final String path;

   CustomFilePDF(String name,this.path) : super(name, FileType.PDF);

}