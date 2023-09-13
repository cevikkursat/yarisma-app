import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yarisma_application/util/constants.dart';
import 'package:flutter_yarisma_application/screens/play_game_page.dart';
import 'package:flutter_yarisma_application/util/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EventDetailPage extends StatefulWidget {
  const EventDetailPage({required this.event, super.key, required this.owner});
  final event;
  final owner;

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarBgColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.resolveWith((states) => 0),
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => appBarBgColor)),
              onPressed: () {
                postPlayEvent(widget.event["_id"]);
              },
              child: Row(
                children: const [
                  Text(
                    "Yarışmaya Başla ",
                    style: ortaBoyBody,
                  ),
                  Icon(Icons.start),
                ],
              ))
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Card(
                  color: cardColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          widget.event["eventName"],
                          style: buyukBoyBaslik.copyWith(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          widget.owner,
                          style: buyukBoyBody.copyWith(color: Colors.black38),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bitiş Tarihi: ${DateTime.parse(widget.event["eventFinishDate"]).day}/${DateTime.parse(widget.event["eventFinishDate"]).month}/${DateTime.parse(widget.event["eventFinishDate"]).year}',
                              style: ortaBoyBody.copyWith(color: Colors.black),
                            ),
                            Text(
                              "Ödül: ${widget.event["award"]}",
                              style: ortaBoyBody.copyWith(color: Colors.black),
                            ),
                            Text(
                              "Ödül Sayısı: ${widget.event["awardCount"]}",
                              style: ortaBoyBody.copyWith(color: Colors.black),
                            ),
                            Text(
                              "Katılan Yarışmacılar;",
                              style: ortaBoyBody.copyWith(color: Colors.black),
                            ),
                            katilanlarWidget(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget katilanlarWidget() {
    String data = "";
    if (widget.event["contestants"].length == 0) {
      data = "\nYarışmaya Katılan Kullanıcı Yok";
    }
    for (var i = 0; i < widget.event["contestants"].length; i++) {
      if (widget.event["contestants"][i]["score"].toString().length > 6) {
        data +=
            "\n${i + 1}.Kişi: ${widget.event["contestants"][i]["username"]} Skor: ${widget.event["contestants"][i]["score"].toString().substring(0, 7)}";
      } else {
        data +=
            "\n${i + 1}.Kişi: ${widget.event["contestants"][i]["username"]} Skor: ${widget.event["contestants"][i]["score"]}";
      }
    }
    return Text(
      "$data",
      style: ortaBoyKalinBody.copyWith(
          color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  void postPlayEvent(String eventID) async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        status: "Yükleniyor",
        dismissOnTap: false);
    var dio = Dio(
      BaseOptions(
        baseUrl: apiURL,
      ),
    );
    Response<Map> response = await dio.post('/play-event', data: {
      "id": Preferences.getID(),
      "eventID": eventID,
    });
    Map? responseBody = response.data;
    EasyLoading.dismiss();
    if (responseBody!["success"] == true) {
      Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(
            builder: (context) => YarismaOynamaPage(
              eventID: widget.event["_id"],
              eventName: widget.event["eventName"],
              eventQuestions: widget.event["questions"],
            ),
          ),
          (route) => false);
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
