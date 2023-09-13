import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yarisma_application/screens/screen.dart';
import 'package:flutter_yarisma_application/util/shared_preferences.dart';
import 'package:flutter_yarisma_application/widgets/widget.dart';
import 'package:flutter_yarisma_application/util/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isPasswordVisible = true;
  String textValueFName = "";
  String textValueEmail = "";
  String textValueUsername = "";
  String textValueLName = "";
  String textValuePhone = "";
  String textValuePassword = "";
  final controllerPassword = TextEditingController();
  final controllerPhone = TextEditingController();
  final controllerFName = TextEditingController();
  final controllerLName = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserDetails();
    controllerPassword
        .addListener(() => {textValuePassword = controllerPassword.text});
    controllerPhone.addListener(() => {textValuePhone = controllerPhone.text});
    controllerFName.addListener(() => {textValueFName = controllerFName.text});
    controllerLName.addListener(() => {textValueLName = controllerLName.text});
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
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Email:  ", style: ortaBoyBaslik),
                          Text(textValueEmail, style: buyukBoyBody),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Username:  ", style: ortaBoyBaslik),
                        Text(
                          textValueUsername,
                          style: buyukBoyBody,
                        ),
                      ],
                    ),
                    MyTextField(
                      hintText: "Ad",
                      inputType: TextInputType.text,
                      myController: controllerFName,
                    ),
                    MyTextField(
                      hintText: "Soyad",
                      inputType: TextInputType.text,
                      myController: controllerLName,
                    ),
                    MyTextButton(
                      buttonName: "Ad Soyad Güncelle",
                      onTap: () {
                        print(textValueUsername);
                        //putName(textValueFName, textValueLName);
                      },
                      bgColor: textButtonBgColor,
                      textColor: textButtonTextColor,
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                      hintText: "Telefon",
                      inputType: TextInputType.phone,
                      myController: controllerPhone,
                    ),
                    MyTextButton(
                      buttonName: "Telefonu Güncelle",
                      onTap: () {
                        putPhone(textValuePhone);
                      },
                      bgColor: textButtonBgColor,
                      textColor: textButtonTextColor,
                    ),
                    const SizedBox(height: 20),
                    MyPasswordField(
                        isPasswordVisible: isPasswordVisible,
                        onTop: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        myController: controllerPassword),
                    MyTextButton(
                      buttonName: "Şifreyi Güncelle",
                      onTap: () {
                        putPassword(textValuePassword);
                      },
                      bgColor: textButtonBgColor,
                      textColor: textButtonTextColor,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Yarışmalarım",
                      style: ortaBoyBaslik,
                    ),
                    MyEventCardforWinners(),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: MyTextButton(
                        buttonName: "Hesabı Kapat",
                        onTap: () {
                          putCloseAccount();
                        },
                        bgColor: textButtonimportantBgColor,
                        textColor: textButtonimportantTextColor,
                      ),
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

  void putName(String fName, String lName) async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        status: "Yükleniyor",
        dismissOnTap: false);
    var dio = Dio(
      BaseOptions(
        baseUrl: apiURL,
      ),
    );
    Response<Map> response = await dio.put('/change-name', data: {
      "id": Preferences.getID(),
      "fName": fName,
      "lName": lName,
    });
    Map? responseBody = response.data;
    EasyLoading.dismiss();
    if (responseBody!["success"] == true) {
      Fluttertoast.showToast(
        msg: "Adınız Soyadınız Değiştirildi!",
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

  void putPhone(String phone) async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        status: "Yükleniyor",
        dismissOnTap: false);
    var dio = Dio(
      BaseOptions(
        baseUrl: apiURL,
      ),
    );
    Response<Map> response = await dio.put('/change-phone', data: {
      "id": Preferences.getID(),
      "phone": phone,
    });
    Map? responseBody = response.data;
    EasyLoading.dismiss();
    if (responseBody!["success"] == true) {
      Fluttertoast.showToast(
        msg: "Telefon Numaranız Değiştirildi!",
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

  void putPassword(String password) async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        status: "Yükleniyor",
        dismissOnTap: false);
    var dio = Dio(
      BaseOptions(
        baseUrl: apiURL,
      ),
    );
    Response<Map> response = await dio.put('/change-password', data: {
      "id": Preferences.getID(),
      "password": password,
    });
    Map? responseBody = response.data;
    EasyLoading.dismiss();
    if (responseBody!["success"] == true) {
      controllerPassword.clear();

      Fluttertoast.showToast(
        msg: "Şifreniz Değiştirildi!",
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

  void putCloseAccount() async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        status: "Yükleniyor",
        dismissOnTap: false);
    var dio = Dio(
      BaseOptions(
        baseUrl: apiURL,
      ),
    );
    Response<Map> response = await dio.put('/deactive-account', data: {
      "id": Preferences.getID(),
    });
    Map? responseBody = response.data;
    EasyLoading.dismiss();
    if (responseBody!["success"] == true) {
      Fluttertoast.showToast(
        msg: "Hesabınız Kapatıldı!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: toastInfoBgColor,
        textColor: toastInfoTextColor,
        fontSize: toastFontSize,
      );
      Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(
          builder: (context) => const SignInPage(),
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

  void getUserDetails() async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        status: "Yükleniyor",
        dismissOnTap: false);
    var dio = Dio(
      BaseOptions(
        baseUrl: apiURL,
      ),
    );
    Response<Map> response = await dio.post('/get-user-details', data: {
      "id": Preferences.getID(),
    });
    Map? responseBody = response.data;
    EasyLoading.dismiss();
    if (responseBody!["success"] == true) {
      controllerPhone.text = responseBody["phone"];
      controllerFName.text = responseBody["fName"];
      controllerLName.text = responseBody["lName"];
      setState(() {
        textValueEmail = responseBody["email"];
        textValueUsername = responseBody["username"];
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
