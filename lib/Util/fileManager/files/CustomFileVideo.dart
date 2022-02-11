import 'package:flutter_web_desktop/Util/fileManager/fileIconManager.dart';
import 'package:flutter_web_desktop/Util/fileManager/fileNode.dart';

class CustomFileVideo extends FileNode{

  final String path;
  final String thumbnail;

   CustomFileVideo(String name,this.path,this.thumbnail) : super(name, FileType.VIDEO);

}