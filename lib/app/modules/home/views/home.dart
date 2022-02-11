import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_web_desktop/Docker/dock.dart';
import 'package:flutter_web_desktop/Docker/dockController.dart';
import 'package:flutter_web_desktop/Docker/dockItem.dart';
import 'package:flutter_web_desktop/Util/fileManager/fileIconManager.dart';
import 'package:flutter_web_desktop/Util/fileManager/files/Folder.dart';
import 'package:flutter_web_desktop/Util/fileManager/files/fileManager.dart';
import 'package:flutter_web_desktop/windows/WindowManager.dart';
import 'package:flutter_web_desktop/windows/apps/widgets/fileTiles.dart';
import 'package:get/get.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FileManager _fileManager;
  WindowManager windowManager = Get.find<WindowManager>();

  late DockController _dockController ;

  @override
  void initState() {
    super.initState();
    _dockController = DockController(_onDockerItemClicked);

    _fileManager = Get.find<FileManager>();
    document.onContextMenu.listen((event) => event.preventDefault());
    windowManager.onUpdate = _onWindowsUpdate;
    _fileManager.subscribeToListener((){
      // When a file changes, update the screen.
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/photos/background.jpg",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
                height: 500,
                width: 500,
                child: FileTails(
                  [_fileManager.desktop],
                  onFolderOpen: (e) {
                    windowManager
                        .startFolderApp(folder: e as Folder);
                  },
                  onFileNodeDelete: (e) {
                    _fileManager.delete(e, _fileManager.desktop);
                  },
                )),
          ),
          _getBody(),
          Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                  child: Dock(controller: _dockController,)
              )),
        ],
      ),
    );
  }

  getDraggableWindows() {
    var size = MediaQuery.of(context).size;
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
  Widget _getBody() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: getDraggableWindows(),
      ),
    );
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
      } else if (item.fileType == FileType.APP_FILE_MANAGER) {
        windowManager.startFolderApp();
      } else {
        windowManager.startMazeGame();
      }
    }
  }

  void _onWindowsUpdate() {

    
    
    Set<FileType> types = Set<FileType>();

    //Get all types of apps that are currently open to update the Dock
    for(var window in windowManager.windows){
      types.add(window.childWidget.getFileType());
    }
    
    _dockController.updateActiveItems(types.toList());

    // This will rebuild the UI whenever an App is opened or moved
    setState(() {

    });
  }
}
