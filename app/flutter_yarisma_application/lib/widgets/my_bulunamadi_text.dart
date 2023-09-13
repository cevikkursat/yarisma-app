import 'package:flutter/material.dart';
import 'package:flutter_yarisma_application/util/constants.dart';

class MyBulunamadiText extends StatelessWidget {
  const MyBulunamadiText({
    Key? key,
    required this.firstTimeBool,
    required this.data,
  }) : super(key: key);

  final bool firstTimeBool;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            firstTimeBool ? "$data Bulunamadı" : "",
            style: ortaBoyBaslik,
          ),
        ],
      ),
    );
  }
}
