import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_desktop/app/modules/home/views/home.dart';
import 'package:flutter_web_desktop/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_web_desktop/app/routes/app_pages.dart';
import 'package:get/get.dart';

class LoginForm extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final paddingTopForm, fontSizeTextField, fontSizeTextFormField, spaceBetweenFields, iconFormSize;
  final spaceBetweenFieldAndButton, widthButton, fontSizeButton, fontSizeForgotPassword, fontSizeSnackBar, errorFormMessage;

  LoginForm(
    this.paddingTopForm, this.fontSizeTextField, this.fontSizeTextFormField, this.spaceBetweenFields, this.iconFormSize, this.spaceBetweenFieldAndButton,
    this.widthButton, this.fontSizeButton, this.fontSizeForgotPassword, this.fontSizeSnackBar, this.errorFormMessage
  );

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height; 
    
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(left: widthSize * 0.05, right: widthSize * 0.05, top: heightSize * paddingTopForm),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text('User Name', style: TextStyle(
                fontSize: widthSize * fontSizeTextField,
                color: Colors.white)
              )
            ),
            TextFormField(
              controller: _usernameController,
              validator: (value) {
                if(value!.isEmpty) {
                  return 'Please enter user name!';
                }
              },
              cursorColor: Colors.white,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.white,
                hintText: "admin",
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2)
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2)
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2)
                ),
                labelStyle: const TextStyle(color: Colors.white),
                errorStyle: TextStyle(color: Colors.white, fontSize: widthSize * errorFormMessage),
                prefixIcon: Icon(
                  Icons.person,
                  size: widthSize * iconFormSize,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white, fontSize: fontSizeTextFormField)
            ),
            SizedBox(height: heightSize * spaceBetweenFields),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Password', style: TextStyle(
                fontSize: widthSize * fontSizeTextField,
                color: Colors.white)
              )
            ),
            TextFormField(
              controller: _passwordController,
              validator: (value) {
                if(value!.isEmpty) {
                  return 'Please enter password!';
                }
              },
              cursorColor: Colors.white,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                fillColor: Colors.white,
                hintText: "admin",
                border: const UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2)
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2)
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2)
                ),
                labelStyle: const TextStyle(color: Colors.white),
                errorStyle: TextStyle(color: Colors.white, fontSize: widthSize * errorFormMessage),
                prefixIcon: Icon(
                  Icons.lock,
                  size: widthSize * iconFormSize,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white, fontSize: fontSizeTextFormField)
            ),
            SizedBox(height: heightSize * spaceBetweenFieldAndButton),
            MaterialButton(
              onPressed: () async {
                if(_formKey.currentState!.validate()) {
                  Get.toNamed(Routes.HOME);
                }

                // Get.to(const HomeScreen());
              },
              child: Text('Login', style: TextStyle(
                fontSize: widthSize * fontSizeButton,
                color: const Color.fromRGBO(41, 187, 255, 1))
              ),
              color: Colors.white,
            ),
            SizedBox(height: heightSize * 0.01),
            Text('Forgot Password!', style: TextStyle(
              fontSize: widthSize * fontSizeForgotPassword,
              fontFamily: 'Poppins',
              color: Colors.white)
            )
          ]
        )
      )
    );
  }
}
