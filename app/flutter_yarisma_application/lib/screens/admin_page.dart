import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yarisma_application/util/shared_preferences.dart';
import 'package:flutter_yarisma_application/widgets/widget.dart';
import 'package:flutter_yarisma_application/util/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool userBool = false;
  bool userfirstTimeBool = false;
  var user;
  String textValueUsername = "";
  final controllerUsername = TextEditingController();

  bool eventBool = false;
  bool eventfirstTimeBool = false;
  var username;
  var event;
  String textValueEventName = "";
  final controllerEventName = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerUsername
        .addListener(() => {textValueUsername = controllerUsername.text});
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
                      hintText: "Username",
                      inputType: TextInputType.text,
                      myController: controllerUsername,
                    ),
                    MyTextButton(
                      buttonName: "Kullanıcı Ara",
                      onTap: () {
                        postSearchUsername(textValueUsername);
                      },
                      bgColor: textButtonBgColor,
                      textColor: textButtonTextColor,
                    ),
                    userBool
                        ? MyUserCardforAdmin(
                            user: user,
                            postMethod: () {
                              postSearchUsername(textValueUsername);
                            },
                            username: user[0]["username"],
                            fName: user[0]["fName"],
                            lName: user[0]["lName"],
                            phone: user[0]["phone"],
                            email: user[0]["email"],
                            earnedAwards: user[0]["earnedAwards"],
                            accountStatus: user[0]["accountStatus"],
                            role: user[0]["role"],
                          )
                        : MyBulunamadiText(
                            firstTimeBool: userfirstTimeBool,
                            data: "Kullanıcı",
                          ),
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
                        ? MyEventCardforAdmin(
                            postMethod: () {
                              postSearchEvent(textValueEventName);
                            },
                            id: event["_id"].toString(),
                            owner: username,
                            isActive: event["isActive"],
                            eventFinishDate:
                                event["eventFinishDate"].toString(),
                            eventName: event["eventName"],
                            award: event["award"],
                            awardCount: event["awardCount"].toString(),
                            contestants: event["contestants"],
                            questions: event["questions"],
                          )
                        : MyBulunamadiText(
                            firstTimeBool: eventfirstTimeBool,
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
    eventfirstTimeBool = true;
    var dio = Dio(
      BaseOptions(
        baseUrl: apiURL,
      ),
    );
    Response<Map> response = await dio.post('/admin-event-search', data: {
      "id": Preferences.getID(),
      "eventName": eventName,
    });
    Map? responseBody = response.data;
    EasyLoading.dismiss();
    if (responseBody!["success"] == true) {
      setState(() {
        eventBool = true;
        event = responseBody["event"];
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
      setState(() {
        eventBool = false;
      });
    }
  }

  void postSearchUsername(String username) async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        status: "Yükleniyor",
        dismissOnTap: false);
    userfirstTimeBool = true;
    var dio = Dio(
      BaseOptions(
        baseUrl: apiURL,
      ),
    );
    Response<Map> response = await dio.post('/admin-user-search', data: {
      "id": Preferences.getID(),
      "username": username,
    });
    Map? responseBody = response.data;
    EasyLoading.dismiss();
    if (responseBody!["success"] == true) {
      setState(() {
        user = responseBody["user"];
        userBool = true;
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
        userBool = false;
      });
    }
  }
}
