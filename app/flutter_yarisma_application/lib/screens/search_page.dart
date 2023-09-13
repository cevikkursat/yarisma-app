import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yarisma_application/util/constants.dart';
import 'package:flutter_yarisma_application/util/shared_preferences.dart';
import 'package:flutter_yarisma_application/widgets/widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool eventBool = false;
  bool firstTimeBool = false;
  var username;
  var event;
  String textValueEventName = "";
  final controllerEventName = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerEventName
        .addListener(() => {textValueEventName = controllerEventName.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextField(
                      hintText: "Yarışma Adı",
                      inputType: TextInputType.text,
                      myController: controllerEventName,
                    ),
                    MyTextButton(
                      buttonName: "Yarışma Ara",
                      onTap: () {
                        postSearchEvent(textValueEventName);
                      },
                      bgColor: textButtonBgColor,
                      textColor: textButtonTextColor,
                    ),
                    eventBool
                        ? MyEventCard(
                            event: event,
                            owner: username,
                            isActive: event["isActive"],
                            eventFinishDate:
                                event["eventFinishDate"].toString(),
                            eventName: event["eventName"],
                            award: event["award"],
                            awardCount: event["awardCount"].toString(),
                            contestants: event["contestants"].toString(),
                          )
                        : MyBulunamadiText(
                            firstTimeBool: firstTimeBool,
                            data: "Yarışma",
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void postSearchEvent(String eventName) async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        status: "Yükleniyor",
        dismissOnTap: false);
    firstTimeBool = true;
    var dio = Dio(
      BaseOptions(
        baseUrl: apiURL,
      ),
    );
    Response<Map> response = await dio.post('/event-search', data: {
      "id": Preferences.getID(),
      "eventName": eventName,
    });
    Map? responseBody = response.data;
    EasyLoading.dismiss();
    if (responseBody!["success"] == true) {
      setState(() {
        event = responseBody["event"];
        username = responseBody["username"];
        eventBool = true;
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
      setState(() {
        eventBool = false;
      });
    }
  }
}
