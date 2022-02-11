import 'package:flutter/material.dart';
import 'package:flutter_web_desktop/Util/fileManager/fileIconManager.dart';
import 'package:flutter_web_desktop/windows/WindowManager.dart';
import 'package:flutter_web_desktop/windows/window.dart';
import 'package:get/get.dart';
// import 'package:get_it/get_it.dart';
import '../WindowListener.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:painter/painter.dart';



class PainterApp extends Application {



   PainterApp( { required Key key,GlobalKey? appKey,  String? title,  WindowListener? listener }) : super(key: key,appKey: appKey,title: title,listener: listener);

   @override
   double getHeight() {
     return 600;
   }

   @override
   double getWidth() {
     return 600;
   }
   @override
   FileType getFileType() {
     return FileType.APP_PAINTER;
   }


  @override
  _PainterAppState createState() => _PainterAppState();
}

class _PainterAppState extends ApplicationState {





  @override
  Widget getApp(){
    return SizedBox(
      height: widget.windowHeight,
      width: widget.windowWidth,
      child: const PainterPage(),
    );
  }

}



class PainterPage extends StatefulWidget {
  const PainterPage({Key? key}) : super(key: key);

  @override
  _PainterPageState createState() => _PainterPageState();
}

class _PainterPageState extends State<PainterPage> {
  late bool _finished;
  late PainterController _controller;

  @override
  void initState() {
    super.initState();
    _finished = false;
    _controller = _newController();
  }

  PainterController _newController() {
    PainterController controller = PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.white;
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions;
    if (_finished) {
      actions = <Widget>[
        IconButton(
          icon: const Icon(Icons.content_copy),
          tooltip: 'New Painting',
          onPressed: () => setState(() {
            _finished = false;
            _controller = _newController();
          }),
        ),
      ];
    } else {
      actions = <Widget>[
        IconButton(
            icon: const Icon(
              Icons.undo,
            ),
            tooltip: 'Undo',
            onPressed: () {
              if (_controller.isEmpty) {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) =>
                    const Text('Nothing to undo'));
              } else {
                _controller.undo();
              }
            }),
        IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Clear',
            onPressed: _controller.clear),
        IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => _show(_controller.finish(), context)),
      ];
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
          title: const Text(""),
          actions: actions,
          bottom: PreferredSize(
            child: DrawBar(_controller),
            preferredSize: Size(MediaQuery.of(context).size.width, 70.0),
          )),
      body: Center(
          child: Painter(_controller)),
    );
  }

  void _show(PictureDetails picture, BuildContext context) {
    setState(() {
      _finished = true;
    });

    picture.toPNG().then((value) => Get.find<WindowManager>().startPhotoPreviewApp(null,value));

  }
}

class DrawBar extends StatelessWidget {
  final PainterController _controller;

   const DrawBar(this._controller);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Slider(
                value: _controller.thickness,
                onChanged: (double value) => setState(() {
                  _controller.thickness = value;
                }),
                min: 1.0,
                max: 20.0,
                activeColor: Colors.white,
              );
            })),
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return IconButton(
                iconSize: 24,
                  icon: Icon(_controller.eraseMode ? Icons.remove:Icons.app_registration,color: Colors.white,
                  ),
                  tooltip: (_controller.eraseMode ? 'Disable' : 'Enable') +
                      ' eraser',
                  onPressed: () {
                    setState(() {
                      _controller.eraseMode = !_controller.eraseMode;
                    });
                  });
            }),
        SizedBox(
            height: 70,
            child: ColorPickerButton(_controller, false)),
       // new ColorPickerButton(_controller, true),
      ],
    );
  }
}

class ColorPickerButton extends StatefulWidget {
  final PainterController _controller;
  final bool _background;

  ColorPickerButton(this._controller, this._background);

  @override
  _ColorPickerButtonState createState() => _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  @override
  Widget build(BuildContext context) {
    Color pickerColor = _color;

    return SizedBox(
      height: 15,
      width: 300,

      child: BlockPicker(

        layoutBuilder: defaultLayoutBuilder,
        pickerColor: pickerColor,
        itemBuilder: defaultItemBuilder,
        onColorChanged: (Color c){
          setState(() {
            pickerColor = c;
            _color = pickerColor;
          });
        },
      ),
    );
  }

  static Widget defaultItemBuilder(
      Color color, bool isCurrentColor, void Function() changeColor) {
    return GestureDetector(
      onTap: changeColor,
      child: Container(
        height: 12,
        width: 12,
        decoration: BoxDecoration(
            border: Border.all(color: isCurrentColor? Colors.white : Colors.transparent,width: 2)
        ),
        child: Card(
          color: color,
        ),
      ),
    );
  }

  static Widget defaultLayoutBuilder(
      BuildContext context, List<Color> colors, PickerItem child) {

    return SizedBox(
      width:  700.0,
      height: 300.0,
      child: GridView.count(
        crossAxisCount: 10,
        crossAxisSpacing: 3.0,
        mainAxisSpacing: 3.0,
        children: colors.map((Color color) => child(color)).toList(),
      ),
    );
  }


  Color get _color => widget._background
      ? widget._controller.backgroundColor
      : widget._controller.drawColor;

  IconData get _iconData =>
      widget._background ? Icons.format_color_fill : Icons.brush;

  set _color(Color color) {
    if (widget._background) {
      widget._controller.backgroundColor = color;
    } else {
      widget._controller.drawColor = color;
    }
  }
}