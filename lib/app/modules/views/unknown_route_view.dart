import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_desktop/app/routes/app_pages.dart';

import 'package:get/get.dart';

class UnknownRouteView extends GetView {
  const UnknownRouteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(size.height*.04,),
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/404_not_found.jpg"),
            fit: BoxFit.cover,
          ),
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Page not found",style: TextStyle(fontSize: size.width*.05   ,color: Colors.white,fontWeight: FontWeight.w400)),
              SizedBox(height: size.height*.02,),
              MaterialButton(
                color: Colors.white.withOpacity(.2),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                onPressed: () {Get.toNamed(Routes.LOGIN);},
                child: Text("Home",style: TextStyle(fontSize: size.width*.03 ,color: Colors.white ),),
        ),
            ],
          ),
      ),
    );
  }
}
