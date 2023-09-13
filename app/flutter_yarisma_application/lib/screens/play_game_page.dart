import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yarisma_application/util/constants.dart';
import 'package:flutter_yarisma_application/screens/screen.dart';
import 'package:flutter_yarisma_application/widgets/widget.dart';

class YarismaOynamaPage extends StatefulWidget {
  const YarismaOynamaPage({
    super.key,
    required this.eventID,
    required this.eventName,
    required this.eventQuestions,
  });
  final String eventID;
  final String eventName;
  final List eventQuestions;

  @override
  State<YarismaOynamaPage> createState() => _YarismaOynamaPageState();
}

class _YarismaOynamaPageState extends State<YarismaOynamaPage> {
  int currentQuestionCount = 0;
  int dogruSayisi = 0;
  int yanlisSayisi = 0;
  Color aBgColor = answerClearBgColor;
  Color aTextColor = answerClearTextColor;
  Color bBgColor = answerClearBgColor;
  Color bTextColor = answerClearTextColor;
  Color cBgColor = answerClearBgColor;
  Color cTextColor = answerClearTextColor;
  Color dBgColor = answerClearBgColor;
  Color dTextColor = answerClearTextColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarBgColor,
        centerTitle: true,
        title: Text(
          "${widget.eventName} \n(${widget.eventQuestions.length} / ${currentQuestionCount + 1})",
          style: ortaBoyBaslik,
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        widget.eventQuestions[currentQuestionCount]["question"],
                        style: buyukBoyBody,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: MyTextButton(
                        buttonName:
                            "A) ${widget.eventQuestions[currentQuestionCount]["answerOne"]}",
                        onTap: () {
                          EasyLoading.showToast("İlerleniyor...",
                              dismissOnTap: false,
                              toastPosition: EasyLoadingToastPosition.bottom,
                              maskType: EasyLoadingMaskType.black);
                          cevapla(0);
                        },
                        bgColor: aBgColor,
                        textColor: aTextColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: MyTextButton(
                        buttonName:
                            "B) ${widget.eventQuestions[currentQuestionCount]["answerTwo"]}",
                        onTap: () {
                          EasyLoading.showToast("İlerleniyor...",
                              dismissOnTap: false,
                              toastPosition: EasyLoadingToastPosition.bottom,
                              maskType: EasyLoadingMaskType.black);
                          cevapla(1);
                        },
                        bgColor: bBgColor,
                        textColor: bTextColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: MyTextButton(
                        buttonName:
                            "C) ${widget.eventQuestions[currentQuestionCount]["answerThree"]}",
                        onTap: () {
                          EasyLoading.showToast("İlerleniyor...",
                              dismissOnTap: false,
                              toastPosition: EasyLoadingToastPosition.bottom,
                              maskType: EasyLoadingMaskType.black);
                          cevapla(2);
                        },
                        bgColor: cBgColor,
                        textColor: cTextColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: MyTextButton(
                        buttonName:
                            "D) ${widget.eventQuestions[currentQuestionCount]["answerFour"]}",
                        onTap: () {
                          EasyLoading.showToast("İlerleniyor...",
                              dismissOnTap: false,
                              toastPosition: EasyLoadingToastPosition.bottom,
                              maskType: EasyLoadingMaskType.black);
                          cevapla(3);
                        },
                        bgColor: dBgColor,
                        textColor: dTextColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void cevapla(int cevap) {
    int sayi =
        int.parse(widget.eventQuestions[currentQuestionCount]["trueAnswer"]);
    setState(() {
      aBgColor = answerNoneBgColor;
      aTextColor = answerNoneTextColor;
      bBgColor = answerNoneBgColor;
      bTextColor = answerNoneTextColor;
      cBgColor = answerNoneBgColor;
      cTextColor = answerNoneTextColor;
      dBgColor = answerNoneBgColor;
      dTextColor = answerNoneTextColor;
    });
    if (sayi == cevap) {
      setState(() {
        dogruSayisi++;
      });
      switch (sayi) {
        case 0:
          setState(() {
            aBgColor = answerTrueBgColor;
            aTextColor = answerTrueTextColor;
          });
          break;
        case 1:
          setState(() {
            bBgColor = answerTrueBgColor;
            bTextColor = answerTrueTextColor;
          });
          break;
        case 2:
          setState(() {
            cBgColor = answerTrueBgColor;
            cTextColor = answerTrueTextColor;
          });
          break;
        case 3:
          setState(() {
            dBgColor = answerTrueBgColor;
            dTextColor = answerTrueTextColor;
          });
          break;
      }
    } else {
      yanlisSayisi++;
      switch (sayi) {
        case 0:
          setState(() {
            aBgColor = answerTrueBgColor;
            aTextColor = answerTrueTextColor;
          });
          break;
        case 1:
          setState(() {
            bBgColor = answerTrueBgColor;
            bTextColor = answerTrueTextColor;
          });
          break;
        case 2:
          setState(() {
            cBgColor = answerTrueBgColor;
            cTextColor = answerTrueTextColor;
          });
          break;
        case 3:
          setState(() {
            dBgColor = answerTrueBgColor;
            dTextColor = answerTrueTextColor;
          });
      }
      switch (cevap) {
        case 0:
          setState(() {
            aBgColor = answerFalseBgColor;
            aTextColor = answerFalseTextColor;
          });
          break;
        case 1:
          setState(() {
            bBgColor = answerFalseBgColor;
            bTextColor = answerFalseTextColor;
          });
          break;
        case 2:
          setState(() {
            cBgColor = answerFalseBgColor;
            cTextColor = answerFalseTextColor;
          });
          break;
        case 3:
          setState(() {
            dBgColor = answerFalseBgColor;
            dTextColor = answerFalseTextColor;
          });
          break;
      }
    }
    Timer(const Duration(seconds: 1), () {
      EasyLoading.dismiss();
      if (widget.eventQuestions.length == currentQuestionCount + 1) {
        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (context) => YarismaBitir(
                eventID: widget.eventID,
                eventName: widget.eventName,
                dCevap: dogruSayisi,
                yCevap: yanlisSayisi,
              ),
            ),
            (route) => false);
      } else {
        setState(() {
          currentQuestionCount++;
          aBgColor = answerClearBgColor;
          aTextColor = answerClearTextColor;
          bBgColor = answerClearBgColor;
          bTextColor = answerClearTextColor;
          cBgColor = answerClearBgColor;
          cTextColor = answerClearTextColor;
          dBgColor = answerClearBgColor;
          dTextColor = answerClearTextColor;
        });
      }
    });
  }
}
