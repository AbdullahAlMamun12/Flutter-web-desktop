import 'package:flutter_web_desktop/Util/fileManager/fileIconManager.dart';
import 'package:flutter_web_desktop/Util/fileManager/fileNode.dart';

class CustomFileImage extends FileNode{

  final String path;

   CustomFileImage(String name,this.path) : super(name, FileType.PICTURE);

}