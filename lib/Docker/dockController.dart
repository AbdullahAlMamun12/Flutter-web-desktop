import 'package:flutter_web_desktop/Util/fileManager/fileIconManager.dart';
import 'package:flutter_web_desktop/windows/WindowManager.dart';
import 'package:get/get.dart';

import 'dockItem.dart';

class DockController{

  Function (DockItem item) callback;
  late List<DockItem> items;

  WindowManager windowManager = Get.find<WindowManager>();

  DockController.fromList(this.items,this.callback);
  DockController(this.callback){
    items = _getFixedItems();
    items.retainWhere((element) => element.alwaysVisible);
  }

  List<DockItem> _getFixedItems(){
    return [
      DockItem("Calculator", FileType.APP_CALCULATOR,true),
      DockItem("File Manager", FileType.APP_FILE_MANAGER,true),
      DockItem("Painter", FileType.APP_PAINTER,true),
      DockItem("Game", FileType.APP_MAZE_GAME,true),
      DockItem("Image Preview", FileType.APP_IMAGE_PREVIEW,false),
      DockItem("Video Player", FileType.APP_VIDEO_PLAYER,false),
      DockItem("PDF Reader", FileType.APP_PDF_READER,false),
      DockItem("HTML Reader", FileType.APP_HTML_READER,false),
      DockItem("File Tree App", FileType.WIDGET_TREE,true),
    ];
  }


  void updateActiveItems(List<FileType> activeWindows){

    items = _getFixedItems();
    for(var item in items){
      item.isActive = activeWindows.contains(item.fileType);
    }
    items.retainWhere((element) => element.isActive || element.alwaysVisible);

  }

  void openOfType(FileType fileType) => windowManager.openOfType(fileType);

  void showAllOfType(FileType fileType) => windowManager.showAllOfType(fileType);

  void hideAllOfType(FileType fileType) => windowManager.hideAllOfType(fileType);

  void closeAllOfType(FileType fileType) => windowManager.closeAllOfType(fileType);



}