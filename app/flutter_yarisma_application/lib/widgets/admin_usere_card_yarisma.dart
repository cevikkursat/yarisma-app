import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yarisma_application/util/constants.dart';
import 'package:flutter_yarisma_application/util/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyAdminUserCardYarisma extends StatefulWidget {
  MyAdminUserCardYarisma(
      {super.key, required this.events, required this.username});
  List events = [];
  String username = "";
  @override
  State<MyAdminUserCardYarisma> createState() => _MyAdminUserCardYarismaState();
}

class _MyAdminUserCardYarismaState extends State<MyAdminUserCardYarisma> {
  @override
  void initState() {
    super.initState();
    getUserEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: yarismalarWidget()),
        Expanded(
          child: ElevatedButton(
              onPressed: () {
                getUserEvents();
              },
              child: Text("Yarışmaları Getir")),
        )
      ],
    );
  }

  Widget yarismalarWidget() {
    String data = "";
    if (widget.events.length == 0) {
      data = "";
    } else {
      for (var i = 0; i < widget.events.length; i++) {
        data +=
            "\n${i + 1}.Yarışma: ${widget.events[i]["eventName"]} \n    Aktif Mi: ${widget.events[i]["isActive"]}";
      }
    }
    return Text(
      "$data",
      style: ortaBoyKalinBody.copyWith(color: Colors.black),
    );
  }

  void getUserEvents() async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        status: "Yükleniyor",
        dismissOnTap: false);
    var dio = Dio(
      BaseOptions(
        baseUrl: apiURL,
      ),
    );
    Response<Map> response = await dio.post('/get-user-events', data: {
      "id": Preferences.getID(),
      "username": widget.username,
    });
    Map? responseBody = response.data;
    EasyLoading.dismiss();
    if (responseBody!["success"] == true) {
      setState(() {
        widget.events = responseBody["userEvents"];
        widget.username = responseBody["username"];
      });
    } else {
      Fluttertoast.showToast(
        msg: responseBody["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: toastunSuccessBgColor,
        textColor: toastunSuccessTextColor,
        fontSize: toastFontSize,
      );
    }
  }
}
