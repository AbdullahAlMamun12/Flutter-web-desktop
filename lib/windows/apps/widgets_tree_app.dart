import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_web_desktop/Util/fileManager/consts/colors.dart';
import 'package:flutter_web_desktop/Util/fileManager/fileIconManager.dart';
import 'package:flutter_web_desktop/windows/window.dart';

import '../WindowListener.dart';

class WidgetTreeApp extends Application{
  WidgetTreeApp( { required Key key,GlobalKey? appKey,  String? title,  WindowListener? listener }) : super(key: key,appKey: appKey,title: title,listener: listener);

  @override
  double getHeight() {
    return 600;
  }

  @override
  double getWidth() {
    return 800;
  }

  @override
  FileType getFileType() {
    return FileType.WIDGET_TREE;
  }

  @override
  State<StatefulWidget> createState()=>_WidgetTreeAppState();
}


class _WidgetTreeAppState extends ApplicationState{

  var _defaultPanelWidth = 150.0;
  var _panelWidth = 150.0;

  @override
  Widget getApp() {
    return Container(
      height: widget.windowHeight,
      width: widget.windowWidth,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.lerp(Colors.blue, Colors.transparent, 0.2),
          leading: Row(
            children: [
              IconButton(onPressed:(){},icon: const Icon(Icons.arrow_back_ios))
            ],
          ),
          title: Text("Title"),
        ),
        body: Container(
          child: Row(
            children: [
              Container(

                width: _panelWidth,
                height: widget.windowHeight,
                color: Color.lerp(Colors.blue, Colors.transparent, 0.2),
                child: getPane(),
              ),
              Container(
                height: widget.windowHeight,
                width: widget.windowWidth - _panelWidth,
                color: Resources.WINDOW_BODY_COLOR,
                child: SingleChildScrollView(
                  child: Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getPane() {
    return Stack(
      children: [
        Container(),
        Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onHorizontalDragUpdate: _onHorizontalDragRight,
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeLeftRight,
                opaque: true,
                child: Container(
                  width: 4,
                ),
              ),
            )),
      ],
    );
  }
  void _onHorizontalDragRight(DragUpdateDetails details) {
    setState(() {
      if(_panelWidth<widget.windowWidth/2 || details.delta.dx<0 ) {
        _panelWidth += details.delta.dx;
      }
      if (_panelWidth < _defaultPanelWidth) {
        _panelWidth = _defaultPanelWidth;
      }
    });
  }

}