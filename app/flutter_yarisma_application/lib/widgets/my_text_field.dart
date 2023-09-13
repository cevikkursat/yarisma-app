import 'package:flutter/material.dart';
import 'package:flutter_yarisma_application/util/constants.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    Key? key,
    required this.hintText,
    required this.inputType,
    required this.myController,
  }) : super(key: key);
  final String hintText;
  final TextInputType inputType;
  var myController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: myController,
        style: ortaBoyBody,
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          labelText: hintText,
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
