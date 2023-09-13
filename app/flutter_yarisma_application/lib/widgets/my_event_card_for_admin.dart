import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yarisma_application/util/constants.dart';
import 'package:flutter_yarisma_application/util/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyEventCardforAdmin extends StatelessWidget {
  const MyEventCardforAdmin({
    Key? key,
    required this.postMethod,
    required this.id,
    required this.owner,
    required this.isActive,
    required this.eventFinishDate,
    required this.eventName,
    required this.award,
    required this.awardCount,
    required this.contestants,
    required this.questions,
  }) : super(key: key);

  final String owner;
  final bool isActive;
  final String eventFinishDate;
  final String eventName;
  final String award;
  final String awardCount;
  final List contestants;
  final List questions;
  final VoidCallback postMethod;
  final String id;

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
                eventName,
                style: ortaBoyBaslik.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                owner,
                style: buyukBoyBody.copyWith(color: Colors.black38),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    child: const Text('Yarışmayı Kapat'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      postChangeEventStatus(false);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    child: const Text('Yarışmayı Aç'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      postChangeEventStatus(true);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Aktif mi: $isActive",
                    style: ortaBoyBody.copyWith(color: Colors.black),
                  ),
                  Text(
                    "Yarışma Bitiş Tarihi: ${DateTime.parse(eventFinishDate).day}/${DateTime.parse(eventFinishDate).month}/${DateTime.parse(eventFinishDate).year}",
                    style: ortaBoyBody.copyWith(color: Colors.black),
                  ),
                  Text(
                    "Ödül: $award",
                    style: ortaBoyBody.copyWith(color: Colors.black),
                  ),
                  Text(
                    "Ödül Sayısı: $awardCount",
                    style: ortaBoyBody.copyWith(color: Colors.black),
                  ),
                  Text(
                    "Katılanlar: ",
                    style: ortaBoyBody.copyWith(color: Colors.black),
                  ),
                  katilanlarWidget(),
                  Text(
                    "\nSorular: ",
                    style: ortaBoyBody.copyWith(color: Colors.black),
                  ),
                  sorularWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void postChangeEventStatus(
    bool eventStatus,
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
    Response<Map> response = await dio.post('/change-event-status', data: {
      "id": Preferences.getID(),
      "updateingEventId": id,
      "eventStatus": eventStatus,
    });
    Map? responseBody = response.data;
    EasyLoading.dismiss();
    if (responseBody!["success"] == true) {
      Fluttertoast.showToast(
        msg: "Yarışmanın Durumu Değiştirildi!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: toastSuccessBgColor,
        textColor: toastSuccessTextColor,
        fontSize: toastFontSize,
      );
      postMethod();
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

  Widget katilanlarWidget() {
    String data = "";
    if (contestants.length == 0) {
      data = "\nYarışmaya Katılan Kullanıcı Yok";
    }
    for (var i = 0; i < contestants.length; i++) {
      data +=
          "\n${i + 1}.Kişi: ${contestants[i]["username"]} Skor: ${contestants[i]["score"]}";
    }
    return Text(
      "$data",
      style: ortaBoyKalinBody.copyWith(color: Colors.black),
    );
  }

  Widget sorularWidget() {
    String data = "";
    if (questions.length == 0) {
      data = "\nYarışmaya Sorusu Yok";
    }
    for (var i = 0; i < questions.length; i++) {
      data +=
          "${i + 1}.Soru: ${questions[i]["question"]} \nA): ${questions[i]["answerOne"]}\nB): ${questions[i]["answerTwo"]}\nC): ${questions[i]["answerThree"]}\nD): ${questions[i]["answerFour"]}\nCevap: ${questions[i]["trueAnswer"]}\n";
    }
    return Text(
      "$data",
      style: ortaBoyKalinBody.copyWith(color: Colors.black),
    );
  }
}
