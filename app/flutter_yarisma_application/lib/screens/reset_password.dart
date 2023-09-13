import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yarisma_application/util/constants.dart';
import 'package:flutter_yarisma_application/screens/screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_yarisma_application/widgets/widget.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String textValueEmail = "";
  final controllerEmail = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerEmail.addListener(() => {textValueEmail = controllerEmail.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBgColor,
        elevation: 0,
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          reverse: true,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Şifre Sıfırlama!",
                            style: buyukBoyBaslik,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Hesabınızın şifresinin sıfırlamak için hesabınızın mail adresini girerek mail olarak gelen şifreyle uygulamaya giriş yapabilirsiniz.",
                            style: buyukBoyBody,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          MyTextField(
                              hintText: "Email",
                              inputType: TextInputType.emailAddress,
                              myController: controllerEmail)
                        ],
                      ),
                    ),
                    MyTextButton(
                      buttonName: "Şifreyi Sıfırla!",
                      onTap: () {
                        postResetPass(textValueEmail);
                      },
                      bgColor: textButtonBgColor,
                      textColor: textButtonTextColor,
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

  void postResetPass(String email) async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        status: "Yükleniyor",
        dismissOnTap: false);
    var dio = Dio(
      BaseOptions(
        baseUrl: apiURL,
      ),
    );
    Response<Map> response =
        await dio.post('/reset-password', data: {"email": email});
    Map? responseBody = response.data;
    EasyLoading.dismiss();
    if (responseBody!["success"] == true) {
      Fluttertoast.showToast(
        msg: "Şifre Sıfırlandı Maile Gelen Şifre İle Giriş Yapabilirsiniz!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: toastSuccessBgColor,
        textColor: toastSuccessTextColor,
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
}
