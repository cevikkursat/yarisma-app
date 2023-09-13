import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yarisma_application/util/constants.dart';
import 'package:flutter_yarisma_application/util/shared_preferences.dart';
import 'package:flutter_yarisma_application/widgets/widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool firstPost = true;
  bool eventBool = false;
  int eventsCount = 0;
  List events = [];
  List username = [];
  String textValueEventName = "";
  final controllerEventName = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerEventName
        .addListener(() => {textValueEventName = controllerEventName.text});
    if (firstPost) {
      postAllEvent();
    }
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
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: listEvents(eventsCount),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void postAllEvent() async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        status: "Yükleniyor",
        dismissOnTap: false);
    var dio = Dio(
      BaseOptions(
        baseUrl: apiURL,
      ),
    );
    await dio.post('/list-events', data: {
      "id": Preferences.getID(),
    }).then((response) {
      Map? responseBody = response.data;
      EasyLoading.dismiss();
      if (responseBody!["success"] == true) {
        setState(() {
          events = responseBody["events"];
          username = responseBody["usernames"];
          eventsCount = responseBody["eventsCount"];
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
      return response;
    });
  }

  List<Widget> listEvents(int eventsCount) {
    if (!eventBool) {
      return [
        const MyBulunamadiText(
          firstTimeBool: true,
          data: "Yarışma",
        ),
      ];
    } else {
      List<Widget> eventCards = [];
      for (var i = 0; i < eventsCount; i++) {
        Widget event = MyEventCard(
          event: events[i],
          owner: username[i],
          isActive: events[i]["isActive"],
          eventFinishDate: events[i]["eventFinishDate"].toString(),
          eventName: events[i]["eventName"],
          award: events[i]["award"],
          awardCount: events[i]["awardCount"].toString(),
          contestants: events[i]["contestants"].toString(),
        );
        eventCards.add(event);
      }
      return eventCards;
    }
  }
}
