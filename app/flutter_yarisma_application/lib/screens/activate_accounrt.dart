import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yarisma_application/util/constants.dart';
import 'package:flutter_yarisma_application/screens/screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/widget.dart';
import '../util/shared_preferences.dart';

class AccountActivatedPage extends StatefulWidget {
  String user;
  AccountActivatedPage(this.user, {super.key});

  @override
  State<AccountActivatedPage> createState() => _AccountActivatedPageState();
}

class _AccountActivatedPageState extends State<AccountActivatedPage> {
  String textValueCode = "";
  final controllerCode = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerCode.addListener(() => {textValueCode = controllerCode.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          reverse: true,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Hesabını Aktifleştir!",
                            style: buyukBoyBaslik,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Hesabınızı etkinleştirmek için kayıt olduğunuz maile gelen kodu giriniz.",
                            style: buyukBoyBody,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          MyTextField(
                              hintText: "Hesap Etkinleştirme Kodu",
                              inputType: TextInputType.number,
                              myController: controllerCode)
                        ],
                      ),
                    ),
                    MyTextButton(
                        buttonName: "Hesabı Aktifleştir",
                        onTap: () {
                          postActivateAcc(widget.user, textValueCode);
                        },
                        bgColor: textButtonBgColor,
                        textColor: textButtonTextColor)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void postActivateAcc(String username, String correctionsCode) async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        status: "Yükleniyor",
        dismissOnTap: false);
    var dio = Dio(
      BaseOptions(
        baseUrl: apiURL,
      ),
    );
    Response<Map> response = await dio.post('/activeAccount',
        data: {"username": username, "correctionsCode": correctionsCode});
    Map? responseBody = response.data;
    EasyLoading.dismiss();
    if (responseBody!["success"] == true) {
      Preferences.setIsLogin(true);
      Preferences.setRole(responseBody["token"]);
      Preferences.setID(responseBody["token"]);
      Fluttertoast.showToast(
        msg: "Hesap Aktifleştirildi ve Giriş Yapıldı",
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
