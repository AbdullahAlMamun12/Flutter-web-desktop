import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/registration_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RegistrationView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RegistrationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
