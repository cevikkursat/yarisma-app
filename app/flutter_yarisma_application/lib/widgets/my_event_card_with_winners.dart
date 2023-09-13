import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yarisma_application/util/constants.dart';
import 'package:flutter_yarisma_application/screens/screen.dart';
import 'package:flutter_yarisma_application/util/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyEventCardforWinners extends StatefulWidget {
  MyEventCardforWinners({Key? key}) : super(key: key);
  @override
  State<MyEventCardforWinners> createState() => _MyEventCardforWinnersState();
}

class _MyEventCardforWinnersState extends State<MyEventCardforWinners> {
  List events = [];
  String username = "";

  @override
  void initState() {
    getUserEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Column(
        children: usercards(events),
      ),
    );
  }

  List<Widget> usercards(var eventler) {
    List<Widget> dondurulecekListe = [];
    Widget w;
    for (var i = 0; i < eventler.length; i++) {
      w = InkWell(
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) =>
                EventDetailPage(event: eventler[i], owner: username),
          ));
        },
        child: Card(
          color: cardColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  eventler[i]["eventName"],
                  style: ortaBoyBaslik.copyWith(color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Yarışma Bitiş Tarihi: ${DateTime.parse(eventler[i]["eventFinishDate"]).day}/${DateTime.parse(eventler[i]["eventFinishDate"]).month}/${DateTime.parse(eventler[i]["eventFinishDate"]).year}",
                      style: ortaBoyBody.copyWith(color: Colors.black),
                    ),
                    Text(
                      "Ödül: ${eventler[i]["award"]}",
                      style: ortaBoyBody.copyWith(color: Colors.black),
                    ),
                    Text(
                      "Oynanabilir: ${eventler[i]["isActive"]}",
                      style: ortaBoyBody.copyWith(color: Colors.black),
                    ),
                    Text(
                      "Kazananlar;",
                      style: ortaBoyBody.copyWith(color: Colors.black),
                    ),
                    kazananlarWidget(
                        eventler[i]["awardCount"], eventler[i]["contestants"]),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      dondurulecekListe.add(w);
    }

    return dondurulecekListe;
  }

  Widget kazananlarWidget(int kazananSayisi, var yarismacilar) {
    String data = "";

    if (kazananSayisi == 0) {
      data = "\nKazanan Yok";
    }
    if (yarismacilar.length > kazananSayisi) {
      for (var i = 0; i < kazananSayisi; i++) {
        if (yarismacilar[i]["score"].toString().length > 6) {
          data +=
              "${i + 1}.Kazanan: ${yarismacilar[i]["username"]} Skor: ${yarismacilar[i]["score"].toString().substring(0, 7)}\n";
        } else {
          data +=
              "${i + 1}.Kazanan: ${yarismacilar[i]["username"]} Skor: ${yarismacilar[i]["score"]}\n";
        }
      }
    } else {
      for (var i = 0; i < yarismacilar.length; i++) {
        if (yarismacilar[i]["score"].toString().length > 6) {
          data +=
              "${i + 1}.Kazanan: ${yarismacilar[i]["username"]} Skor: ${yarismacilar[i]["score"].toString().substring(0, 7)}\n";
        } else {
          data +=
              "${i + 1}.Kazanan: ${yarismacilar[i]["username"]} Skor: ${yarismacilar[i]["score"]}\n";
        }
      }
    }

    return Text(
      "$data",
      style: ortaBoyKalinBody.copyWith(
          color: Colors.black, fontWeight: FontWeight.bold),
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
    });
    Map? responseBody = response.data;
    EasyLoading.dismiss();
    if (responseBody!["success"] == true) {
      setState(() {
        events = responseBody["userEvents"];
        username = responseBody["username"];
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
