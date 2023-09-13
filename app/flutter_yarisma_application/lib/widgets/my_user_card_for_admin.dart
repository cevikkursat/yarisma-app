import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yarisma_application/util/constants.dart';
import 'package:flutter_yarisma_application/util/shared_preferences.dart';
import 'package:flutter_yarisma_application/widgets/admin_usere_card_yarisma.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyUserCardforAdmin extends StatefulWidget {
  const MyUserCardforAdmin({
    Key? key,
    required this.user,
    required this.postMethod,
    required this.username,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.email,
    required this.earnedAwards,
    required this.accountStatus,
    required this.role,
  }) : super(key: key);

  final String username;
  final String fName;
  final String lName;
  final String phone;
  final String email;
  final List earnedAwards;
  final String accountStatus;
  final String role;
  final user;
  final postMethod;

  @override
  State<MyUserCardforAdmin> createState() => _MyUserCardforAdminState();
}

class _MyUserCardforAdminState extends State<MyUserCardforAdmin> {
  List events = [];
  String username = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        color: cardColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                widget.username,
                style: buyukBoyBaslik.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                '${widget.fName} ${widget.lName}',
                style: buyukBoyBody.copyWith(color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Telefon: ${widget.phone}",
                    style: ortaBoyBody.copyWith(color: Colors.black),
                  ),
                  Text(
                    "Email: ${widget.email}",
                    style: ortaBoyBody.copyWith(color: Colors.black),
                  ),
                  Text(
                    "Hesap Durumu: ${widget.accountStatus}",
                    style: ortaBoyBody.copyWith(color: Colors.black),
                  ),
                  Text(
                    "Hesap Rolü: ${widget.role}",
                    style: ortaBoyBody.copyWith(color: Colors.black),
                  ),
                  Text(
                    "Kazanılanlar;",
                    style: ortaBoyBody.copyWith(color: Colors.black),
                  ),
                  kazanilanlarWidget(),
                  Text(
                    "\nYarışmaları; ",
                    style: ortaBoyBody.copyWith(color: Colors.black),
                  ),
                  MyAdminUserCardYarisma(
                    events: events,
                    username: widget.username,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    child: const Text('Hesabı Banla'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      postChangeAccStatus("banned");
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    child: const Text('Hesaba Admin Yetkisi Ver'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      postChangeAccRole("admin");
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    child: const Text('Hesabı User Yetkisine Düşür'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple),
                    onPressed: () {
                      postChangeAccRole("user");
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    child: const Text('Hesabı Aç'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      postChangeAccStatus("active");
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    child: const Text('Hesabı Kapat'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                    onPressed: () {
                      postChangeAccStatus("deactivated");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget kazanilanlarWidget() {
    String data = "";
    if (widget.earnedAwards.length == 0) {
      data = "\nKazanılan Yarışma Yok";
    }
    for (var i = 0; i < widget.earnedAwards.length; i++) {
      data +=
          "\nKazanılan ${i + 1}.Yarışma: ${widget.earnedAwards[i]["eventName"]} \n    Ödül: ${events[i]["award"]}";
    }
    return Text(
      "$data",
      style: ortaBoyKalinBody.copyWith(color: Colors.black),
    );
  }

  void postChangeAccStatus(
    String accStatus,
  ) async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        status: "Yükleniyor",
        dismissOnTap: false);
    var dio = Dio(
      BaseOptions(
        baseUrl: apiURL,
      ),
    );
    Response<Map> response = await dio.post('/change-account-stattus', data: {
      "id": Preferences.getID(),
      "updateingUserId": widget.user[0]["_id"],
      "accountStatus": accStatus,
    });
    Map? responseBody = response.data;
    EasyLoading.dismiss();
    if (responseBody!["success"] == true) {
      Fluttertoast.showToast(
        msg: "Hesap Durumu Değiştirildi!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: toastSuccessBgColor,
        textColor: toastSuccessTextColor,
        fontSize: toastFontSize,
      );
      widget.postMethod();
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

  void postChangeAccRole(
    String accRole,
  ) async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        status: "Yükleniyor",
        dismissOnTap: false);
    var dio = Dio(
      BaseOptions(
        baseUrl: apiURL,
      ),
    );
    Response<Map> response = await dio.post('/change-account-role', data: {
      "id": Preferences.getID(),
      "updateingUserId": widget.user[0]["_id"],
      "role": accRole,
    });
    Map? responseBody = response.data;
    EasyLoading.dismiss();
    if (responseBody!["success"] == true) {
      Fluttertoast.showToast(
        msg: "Hesap Rolü Değiştirildi!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: toastSuccessBgColor,
        textColor: toastSuccessTextColor,
        fontSize: toastFontSize,
      );
      widget.postMethod();
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
