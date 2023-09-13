import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yarisma_application/util/constants.dart';
import 'package:flutter_yarisma_application/util/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/widget.dart';

class EventCreatePage extends StatefulWidget {
  const EventCreatePage({super.key});

  @override
  State<EventCreatePage> createState() => _EventCreatePageState();
}

class _EventCreatePageState extends State<EventCreatePage> {
  int dropdownValueIndex = 0;
  List questions = [];
  String textValueEventName = "";
  String textValueAward = "";
  String textValueAwardCount = "";
  String textValueQuestion = "";
  String textValueAnswerOne = "";
  String textValueAnswerTwo = "";
  String textValueAnswerThree = "";
  String textValueAnswerFour = "";
  final controllerEventName = TextEditingController();
  final controllerAward = TextEditingController();
  final controllerAwardCount = TextEditingController();
  final controllerQuestion = TextEditingController();
  final controllerAnswerOne = TextEditingController();
  final controllerAnswerTwo = TextEditingController();
  final controllerAnswerThree = TextEditingController();
  final controllerAnswerFour = TextEditingController();
  final _dateC = TextEditingController();
  String textDate = "";

  DateTime selected = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day + 2,
  );
  DateTime initial = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day + 2,
  );
  DateTime last = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month + 1,
    DateTime.now().day,
  );

  @override
  void initState() {
    super.initState();
    controllerEventName
        .addListener(() => {textValueEventName = controllerEventName.text});
    controllerAward.addListener(() => {textValueAward = controllerAward.text});
    controllerAwardCount
        .addListener(() => {textValueAwardCount = controllerAwardCount.text});
    controllerQuestion
        .addListener(() => {textValueQuestion = controllerQuestion.text});
    controllerAnswerOne
        .addListener(() => {textValueAnswerOne = controllerAnswerOne.text});
    controllerAnswerTwo
        .addListener(() => {textValueAnswerTwo = controllerAnswerTwo.text});
    controllerAnswerThree
        .addListener(() => {textValueAnswerThree = controllerAnswerThree.text});
    controllerAnswerFour
        .addListener(() => {textValueAnswerFour = controllerAnswerFour.text});
    _dateC.addListener(() => {textDate = _dateC.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyTextField(
                            hintText: "Yarışma Adı",
                            inputType: TextInputType.text,
                            myController: controllerEventName,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                onPressed: () => displayDatePicker(context),
                                child: const Text("Event Bitiş Tarihi Seç"),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  textDate,
                                  style: ortaBoyBody,
                                ),
                              ),
                            ],
                          ),
                          MyTextField(
                            hintText: "Ödül",
                            inputType: TextInputType.text,
                            myController: controllerAward,
                          ),
                          MyTextField(
                            hintText: "Ödül Miktarı",
                            inputType: TextInputType.number,
                            myController: controllerAwardCount,
                          ),
                          MyTextField(
                            hintText: "Soru",
                            inputType: TextInputType.multiline,
                            myController: controllerQuestion,
                          ),
                          MyTextField(
                            hintText: "Cevap 1",
                            inputType: TextInputType.multiline,
                            myController: controllerAnswerOne,
                          ),
                          MyTextField(
                            hintText: "Cevap 2",
                            inputType: TextInputType.multiline,
                            myController: controllerAnswerTwo,
                          ),
                          MyTextField(
                            hintText: "Cevap 3",
                            inputType: TextInputType.multiline,
                            myController: controllerAnswerThree,
                          ),
                          MyTextField(
                            hintText: "Cevap 4",
                            inputType: TextInputType.multiline,
                            myController: controllerAnswerFour,
                          ),
                          DropdownButton(
                            isExpanded: true,
                            dropdownColor: appBgColor,
                            value: dropdownValueIndex,
                            items: const [
                              DropdownMenuItem(
                                value: 0,
                                child: Text(
                                  "Doğru Cevap: Cevap 1",
                                  style: ortaBoyKalinBody,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: Text(
                                  "Doğru Cevap: Cevap  2",
                                  style: ortaBoyKalinBody,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text(
                                  "Doğru Cevap: Cevap  3",
                                  style: ortaBoyKalinBody,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 3,
                                child: Text(
                                  "Doğru Cevap: Cevap  4",
                                  style: ortaBoyKalinBody,
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                dropdownValueIndex = value!;
                              });
                            },
                          ),
                          MyTextButton(
                            buttonName: "Soruyu Ekle",
                            onTap: () {
                              setState(() {
                                questions.add(
                                  {
                                    "question": textValueQuestion,
                                    "answerOne": textValueAnswerOne,
                                    "answerTwo": textValueAnswerTwo,
                                    "answerThree": textValueAnswerThree,
                                    "answerFour": textValueAnswerFour,
                                    "trueAnswer": dropdownValueIndex,
                                  },
                                );
                              });
                            },
                            bgColor: textButtonInfoBgColor,
                            textColor: textButtonInfoTextColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                const Text(
                                  "Sorular",
                                  style: ortaBoyBaslik,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: getQuestions(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: MyTextButton(
                        buttonName: "Yarışma Oluştur",
                        onTap: () {
                          postEventCreate(
                            textValueEventName,
                            textValueAward,
                            int.parse(textValueAwardCount),
                            textDate,
                          );
                        },
                        bgColor: textButtonBgColor,
                        textColor: textButtonTextColor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future displayDatePicker(BuildContext context) async {
    var date = await showDatePicker(
      context: context,
      initialDate: selected,
      firstDate: initial,
      lastDate: last,
    );

    if (date != null) {
      setState(() {
        _dateC.text = date.toLocal().toString().split(" ")[0];
      });
    }
  }

  void postEventCreate(String eventName, String award, int awardCount,
      String eventFinishDate) async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        status: "Yükleniyor",
        dismissOnTap: false);
    var dio = Dio(
      BaseOptions(
        baseUrl: apiURL,
      ),
    );
    Response<Map> response = await dio.post('/create-event', data: {
      "id": Preferences.getID(),
      "owner": Preferences.getID(),
      "eventName": eventName,
      "eventFinishDate": eventFinishDate,
      "award": award,
      "awardCount": awardCount,
      "questions": questions,
    });
    Map? responseBody = response.data;
    EasyLoading.dismiss();
    if (responseBody!["success"] == true) {
      controllerEventName.clear();
      controllerAward.clear();
      controllerAwardCount.clear();
      controllerQuestion.clear();
      controllerAnswerOne.clear();
      controllerAnswerTwo.clear();
      controllerAnswerThree.clear();
      controllerAnswerFour.clear();
      _dateC.clear();
      setState(() {
        questions = [];
      });
      Fluttertoast.showToast(
        msg: responseBody["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: toastSuccessBgColor,
        textColor: toastSuccessTextColor,
        fontSize: toastFontSize,
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

  List<Widget> getQuestions() {
    String question;
    String answerOne;
    String answerTwo;
    String answerThree;
    String answerFour;
    int answerTrueIndex;
    String data = "";
    List<Widget> widgets = [];
    for (var i = 0; i < questions.length; i++) {
      question = questions[i]["question"].toString();
      answerOne = questions[i]["answerOne"].toString();
      answerTwo = questions[i]["answerTwo"].toString();
      answerThree = questions[i]["answerThree"].toString();
      answerFour = questions[i]["answerFour"].toString();
      answerTrueIndex = questions[i]["trueAnswer"];
      data =
          "${i + 1}.Soru: ${question}\n A) ${answerOne}\n B) ${answerTwo}\n C) ${answerThree}\n D) ${answerFour}\nDoğru Cevap: ${answerTrueIndex + 1}. Cevap";
      Widget widget = Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(data, style: ortaBoyBody),
            IconButton(
              onPressed: () {
                setState(() {
                  questions.removeAt(i);
                });
              },
              icon: const Icon(Icons.delete, color: primaryColor),
            ),
          ],
        ),
      );
      widgets.add(widget);
    }
    return widgets;
  }
}
