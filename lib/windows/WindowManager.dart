import 'dart:async';
import 'dart:typed_data';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_desktop/Util/fileManager/AnalyticsService.dart';
import 'package:flutter_web_desktop/Util/fileManager/fileIconManager.dart';
import 'package:flutter_web_desktop/Util/fileManager/files/Folder.dart';
import 'package:flutter_web_desktop/Util/fileManager/files/fileManager.dart';
import 'package:flutter_web_desktop/windows/apps/MazeGameApp.dart';
import 'package:flutter_web_desktop/windows/apps/PhotoPreview.dart';
import 'package:flutter_web_desktop/windows/apps/VideoPlayer.dart';
import 'package:flutter_web_desktop/windows/apps/FilesApp.dart';
import 'package:flutter_web_desktop/windows/apps/htmlReader.dart';
import 'package:flutter_web_desktop/windows/apps/pdfReader.dart';
import 'package:flutter_web_desktop/windows/apps/widgets_tree_app.dart';
import 'package:flutter_web_desktop/windows/draggableWindow.dart';
import 'package:flutter_web_desktop/windows/window.dart';
import 'package:get/get.dart';
// import 'package:get_it/get_it.dart';

import 'WindowListener.dart';
import 'apps/calculator.dart';
import 'apps/painter.dart';

class WindowManager{



   VoidCallback? _onUpdate;
   late FileManager _fileManager;
   // late AnalyticsService _analytics = GetIt.instance.get<AnalyticsService>();

   set onUpdate(VoidCallback callback) {
    _onUpdate = callback;
  }


  WindowManager(){
    _fileManager = Get.find<FileManager>();
  }

  List<DraggableWindow> windows = List.empty(growable: true);


   
   

  void startFolderApp({Folder? folder}){
    var key = UniqueKey();
    var appKey = GlobalKey();
    // folder ??= _fileManager.root;
    generateSimpleDraggableWindow(FilesApp(title: "File Manager",appKey: appKey, key: key,currentFolder: folder??_fileManager.root));

  }
  void startWidgetTreeApp({Folder? folder}){
    var key = UniqueKey();
    var appKey = GlobalKey();
    // folder ??= _fileManager.root;
    generateSimpleDraggableWindow(WidgetTreeApp(title: "File Manager(New)",appKey: appKey, key: key));

  }
  void startCalculatorApp(){
    var key = UniqueKey();
    var appKey = GlobalKey();
    generateSimpleDraggableWindow(CalculatorApp(key: key,appKey: appKey, title: "Calculator"));
  }
  void startPdfApp(String path){
    var key = UniqueKey();
    var appKey = GlobalKey();
    generateSimpleDraggableWindow(PdfReaderApp(title: "PDF Reader",appKey: appKey,key: key,path: path,));
  }
  void startMazeGame(){
    var key = UniqueKey();
    var appKey = GlobalKey();
    generateSimpleDraggableWindow(MazeGameApp(title: "Game",appKey: appKey,key: key));
  }
  void startHtmlReader(String path){
    var key = UniqueKey();
    var appKey = GlobalKey();
    generateSimpleDraggableWindow(HtmlReaderApp(title: "HTML Reader",appKey: appKey,key: key,path: path,));
  }
  void startPainterApp(){
    var key = UniqueKey();
    var appKey = GlobalKey();
    generateSimpleDraggableWindow(PainterApp(title: "Painter",appKey: appKey, key: key,));

  }
  void startVideoApp(String url){
    var key = UniqueKey();
    var appKey = GlobalKey();
    generateSimpleDraggableWindow(VideoPlayerApp(title: "Video Player",appKey: appKey, key: key,videoUrl: url));
  }
  void startPhotoPreviewApp(String? path,Uint8List? memory){
    var key = UniqueKey();
    var appKey = GlobalKey();
    generateSimpleDraggableWindow(PhotoPreviewApp(title: "Photos",appKey: appKey, key: key ,path: path,memory: memory,));
  }



  void generateSimpleDraggableWindow(Application application){

 
     // _analytics.sendAnalyticsOpenApp(application.title??"");
    final draggableWindow =  DraggableWindow(
      key: application.key,
      childWidget: application, feedback: () {  },);

    var timer = Timer(Duration(milliseconds: 1), () {

    });

    draggableWindow.setListener((){

      if(!timer.isActive && draggableWindow.isCrashed){
        timer = Timer(Duration(milliseconds: 50), () {
          draggableWindow.getScreenShotWidget().then((value)
          {
            windows.insert(1,value);
            _onUpdate!();
          }
          );
        });
      }


      windows.remove(draggableWindow);

      windows.insert(0, draggableWindow);

      _onUpdate!();

    });


    draggableWindow.childWidget.setListener(WindowListener(
      onClose: (window){
        windows.remove(draggableWindow);
        _onUpdate!();
      },
      onHide: (_){
        draggableWindow.isVisible = false;
        _onUpdate!();
      },
      onAppCrash: (window){
        draggableWindow.isCrashed= true;
        draggableWindow.childWidget.canResize = false;
        draggableWindow.getScreenShotWidget().then((value)
        {

          windows.insert(1,value);
          _onUpdate!();
        }
        );
        final assetsAudioPlayer = AssetsAudioPlayer();
        assetsAudioPlayer.open(
          Audio("assets/erro.mp3"),
        );
        assetsAudioPlayer.play();
        // _analytics.sendWindowsXPCrash(window.title??"");
      },

    ));


    windows.insert(0,draggableWindow);


    _onUpdate!();

  }

  void showAllOfType(FileType fileType){
    for(var window in windows){
      if(window.childWidget.getFileType()==fileType){
        window.isVisible = true;
      }
    }
    _onUpdate!();
  }

   void openOfType(FileType fileType){
      switch(fileType){
        case FileType.APP_CALCULATOR: startCalculatorApp(); break;
        case FileType.APP_PAINTER: startPainterApp(); break;
        case FileType.APP_FILE_MANAGER: startFolderApp(); break;
        case FileType.APP_MAZE_GAME: startMazeGame(); break;
        default:
      }
   }

   void hideAllOfType(FileType fileType){
       windows.forEach((element) { if(element.childWidget.getFileType() == fileType)
         element.childWidget.listener!.onHide!(element.childWidget);
       });
   }

   void closeAllOfType(FileType fileType){

    List<Application> temp = List.empty(growable: true);
     windows.forEach((element) { if(element.childWidget.getFileType() == fileType)
       temp.add(element.childWidget);
     });
     temp.forEach((element) => element.listener!.onClose!(element));
   }

}