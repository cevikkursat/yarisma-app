import 'package:flutter/material.dart';
import 'package:flutter_yarisma_application/util/constants.dart';

class MyPasswordField extends StatelessWidget {
  MyPasswordField({
    Key? key,
    required this.isPasswordVisible,
    required this.onTop,
    required this.myController,
  }) : super(key: key);

  final bool isPasswordVisible;
  final VoidCallback onTop;
  var myController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: myController,
        style: ortaBoyBody,
        obscureText: isPasswordVisible,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: onTop,
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.white60,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.all(20),
          labelText: "Şifre",
          labelStyle: ortaBoyBody,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white30, width: 1),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white30, width: 1),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
