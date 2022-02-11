import 'package:flutter_web_desktop/Util/fileManager/fileIconManager.dart';
import 'package:flutter_web_desktop/Util/fileManager/fileNode.dart';

class CustomFileHTML extends FileNode{

  final String fileName;

   CustomFileHTML(String name,this.fileName) : super(name, FileType.HTML);

}