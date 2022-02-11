import 'package:flutter/material.dart';
import 'package:flutter_web_desktop/app/modules/login/views/mobile_mode.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import 'desktop_mode.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth <= 1024) {
          return MobileMode();
        } else {
          return DesktopMode();
        }
      },
    );
  }
}
