import 'dart:html';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_web_desktop/Docker/dockController.dart';
import 'package:flutter_web_desktop/Docker/dockItem.dart';
import 'package:flutter_web_desktop/Util/fileManager/fileIconManager.dart';
import 'package:flutter_web_desktop/Util/fileManager/files/fileManager.dart';
import 'package:flutter_web_desktop/windows/WindowManager.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  var deskTopRefreshVar = 0.obs;

  late FileManager fileManager;
  WindowManager windowManager = Get.find<WindowManager>();
  late DockController dockController ;
  var bgImage;

  @override
  void onInit() {
    super.onInit();
    var rng = Random();
    bgImage = [
      "assets/images/bg1.png",
      "assets/images/bg2.png",
      "assets/images/bg3.jpg",
    ][rng.nextInt(3)];

    dockController = DockController(_onDockerItemClicked);
    // Getting the instance of FileManager
    fileManager = Get.find<FileManager>();
    document.onContextMenu.listen((event) => event.preventDefault());
    windowManager.onUpdate = _onWindowsUpdate;
    fileManager.subscribeToListener((){
      // When a file changes, update the screen.
      //TODO: set state implement
    });

  }

  _onDockerItemClicked(DockItem item) {

    // if the app is already opened and hidden
    if(windowManager.windows.any((element) => element.childWidget.getFileType()==item.fileType )){
      windowManager.showAllOfType(item.fileType);
    }else {

      // Start a new new App

      if (item.fileType == FileType.APP_CALCULATOR) {
        windowManager.startCalculatorApp();
      } else if (item.fileType == FileType.APP_PAINTER) {
        windowManager.startPainterApp();
      } else if (item.fileType == FileType.WIDGET_TREE) {
        windowManager.startWidgetTreeApp();
      }else if (item.fileType == FileType.APP_FILE_MANAGER) {
        windowManager.startFolderApp();
      } else {
        windowManager.startMazeGame();
      }
    }
  }

  void _onWindowsUpdate() {
    Set<FileType> types = <FileType>{};

    //Get all types of apps that are currently open to update the Dock
    for(var window in windowManager.windows){
      types.add(window.childWidget.getFileType());
    }

    dockController.updateActiveItems(types.toList());

    // This will rebuild the UI whenever an App is opened or moved
    //TODO: setState((){}) implement
    deskTopRefreshVar.value++;
  }
  getDraggableWindows(Size size) {
    return windowManager.windows.reversed.map((e) {
      if (e.x == -1) {
        // Put new windows in the Center of the screen
        e.x = (size.width - e.childWidget.getWidth()) / 2;
        e.y = (size.height - e.childWidget.getHeight()) / 2;
      }
      return Positioned(key: e.key, left: e.x, top: e.y, child: Visibility(
        maintainState: true,
        visible: e.isVisible,
        child: e,
      ));
    }).toList();
  }
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
