import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yarisma_application/util/constants.dart';
import 'package:flutter_yarisma_application/screens/screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_yarisma_application/widgets/widget.dart';
import 'package:flutter_yarisma_application/util/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isPasswordVisible = true;
  String textValueUsername = "";
  String textValuePassword = "";
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  @override
  void initState() {
    super.initState();
    controllerUsername
        .addListener(() => {textValueUsername = controllerUsername.text});
    controllerPassword
        .addListener(() => {textValuePassword = controllerPassword.text});
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
              Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(
                  builder: (context) => const WelcomePage(),
                ),
                (route) => false,
              );
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SafeArea(
          child: CustomScrollView(
            reverse: true,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Hoşgeldiniz!",
                              style: buyukBoyBaslik,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Hadi Giriş Yapalım!",
                              style: buyukBoyBody,
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            MyTextField(
                              hintText: "Kullanıcı Adı",
                              inputType: TextInputType.text,
                              myController: controllerUsername,
                            ),
                            MyPasswordField(
                              isPasswordVisible: isPasswordVisible,
                              onTop: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              myController: controllerPassword,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Şifremi Unuttum! ",
                                  style: ortaBoyBody,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => ResetPassword(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Şifremi Sıfırla",
                                    style: ortaBoyKalinBody.copyWith(
                                      color: appColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Hesabınız yok mu? ",
                            style: ortaBoyBody,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Üye Ol",
                              style: ortaBoyKalinBody.copyWith(
                                color: appColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextButton(
                          buttonName: "Giriş Yap",
                          onTap: () {
                            postLogin(textValueUsername, textValuePassword);
                          },
                          bgColor: textButtonBgColor,
                          textColor: textButtonTextColor),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void postLogin(String username, String password) async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        status: "Yükleniyor",
        dismissOnTap: false);
    var dio = Dio(
      BaseOptions(
        baseUrl: apiURL,
      ),
    );
    Response<Map> response = await dio
        .post('/login', data: {"username": username, "password": password});
    Map? responseBody = response.data;
    EasyLoading.dismiss();
    if (responseBody!["accountStatus"] == "inactive") {
      Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(
            builder: (context) => AccountActivatedPage(username),
          ),
          (route) => false);
    }
    if (responseBody["success"] == true) {
      Preferences.setIsLogin(true);
      Preferences.setRole(responseBody["token"]);
      Preferences.setID(responseBody["token"]);
      Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(
            builder: (context) => const IndexPage(),
          ),
          (route) => false);
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
