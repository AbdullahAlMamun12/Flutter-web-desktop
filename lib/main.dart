import 'package:flutter/material.dart';
import 'package:flutter_web_desktop/app/modules/views/unknown_route_view.dart';
import 'package:flutter_web_desktop/windows/WindowManager.dart';

import 'package:get/get.dart';
// import 'package:get_it/get_it.dart';

import 'Util/fileManager/files/fileManager.dart';
import 'app/routes/app_pages.dart';

void main() {
  Get.put(FileManager());
  Get.put(WindowManager());
  // GetIt getIt = GetIt.instance;
  // getIt.registerSingleton<FileManager>(FileManager());
  // getIt.registerSingleton<WindowManager>(WindowManager());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      unknownRoute: GetPage(name: '/not-found', page: () => const UnknownRouteView()),
    ),
  );
}
