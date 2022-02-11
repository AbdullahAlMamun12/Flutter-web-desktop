import 'package:flutter/material.dart';
import 'package:flutter_web_desktop/Docker/dock.dart';
import 'package:flutter_web_desktop/Util/fileManager/files/Folder.dart';
import 'package:flutter_web_desktop/windows/apps/widgets/fileTiles.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
        // To refresh the desktop
        controller.deskTopRefreshVar.value;
        return Stack(
          children: [
            // Background wallpaper
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                controller.bgImage,
                fit: BoxFit.fill,
              ),
            ),
            // Desktop icons
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                  height: size.height,
                  // width: 500,
                  child: FileTails(
                    [controller.fileManager.desktop],
                    onFolderOpen: (e) {
                      controller.windowManager
                          .startFolderApp(folder: e as Folder);
                    },
                    onFileNodeDelete: (e) {
                      controller.fileManager.delete(e, controller.fileManager.desktop);
                    },
                  )),
            ),
            // Desktop Body content
            _getBody(size),
            // Docker Widget
            Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                    child: Dock(controller: controller.dockController,)
                )),
          ],
        );
      }),
    );
  }

  Widget _getBody(Size size) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        children: controller.getDraggableWindows(size),
      ),
    );
  }

}
