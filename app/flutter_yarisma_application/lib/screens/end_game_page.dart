import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yarisma_application/util/constants.dart';
import 'package:flutter_yarisma_application/screens/screen.dart';
import 'package:flutter_yarisma_application/util/shared_preferences.dart';
import 'package:flutter_yarisma_application/widgets/widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class YarismaBitir extends StatefulWidget {
  const YarismaBitir({
    super.key,
    required this.eventID,
    required this.eventName,
    required this.dCevap,
    required this.yCevap,
  });
  final String eventID;
  final String eventName;
  final int dCevap;
  final int yCevap;

  @override
  State<YarismaBitir> createState() => _YarismaBitirState();
}

class _YarismaBitirState extends State<YarismaBitir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarBgColor,
        centerTitle: true,
        title: Text(
          "${widget.eventName}",
          style: ortaBoyBaslik,
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Doğru Sayısı: ${widget.dCevap}",
                        style: buyukBoyBody,
                      ),
                      Text(
                        "Yanlış Sayısı: ${widget.yCevap}",
                        style: buyukBoyBody,
                      ),
                      Text(
                        "Skor: ${((widget.dCevap / (widget.dCevap + widget.yCevap)) * 100.0).toString().length > 6 ? ((widget.dCevap / (widget.dCevap + widget.yCevap)) * 100.0).toString().substring(0, 7) : ((widget.dCevap / (widget.dCevap + widget.yCevap)) * 100.0).toString()}",
                        style: buyukBoyBody,
                      ),
                      SizedBox(height: 50),
                      MyTextButton(
                          buttonName: "Yarışmayı Bitir",
                          onTap: () {
                            postEndGame(
                              widget.eventID,
                              widget.dCevap,
                              widget.yCevap,
                              ((widget.dCevap /
                                      (widget.dCevap + widget.yCevap)) *
                                  100.0),
                            );
                          },
                          bgColor: Colors.white,
                          textColor: Colors.black)
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void postEndGame(
      String eventIDgiden, int dSayisi, int ySayisi, double score) async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        status: "Yükleniyor",
        dismissOnTap: false);
    var dio = Dio(
      BaseOptions(
        baseUrl: apiURL,
      ),
    );
    Response<Map> response = await dio.post('/end-event', data: {
      "id": Preferences.getID(),
      "eventID": eventIDgiden,
      "dSayisi": dSayisi,
      "ySayisi": ySayisi,
      "score": score,
    });
    Map? responseBody = response.data;
    EasyLoading.dismiss();
    if (responseBody!["success"] == true) {
      Fluttertoast.showToast(
        msg: responseBody["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: toastSuccessBgColor,
        textColor: toastSuccessTextColor,
        fontSize: toastFontSize,
      );
      Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(
          builder: (context) => const IndexPage(),
        ),
        (route) => false,
      );
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
