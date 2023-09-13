import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yarisma_application/util/constants.dart';
import 'package:flutter_yarisma_application/screens/screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isPasswordVisible = true;
  String textValueUsername = "";
  String textValueName = "";
  String textValueSurname = "";
  String textValuePhone = "";
  String textValuePassword = "";
  String textValueEmail = "";
  final controllerUsername = TextEditingController();
  final controllerName = TextEditingController();
  final controllerSurname = TextEditingController();
  final controllerPhone = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerEmail = TextEditingController();
  @override
  void initState() {
    super.initState();
    controllerUsername
        .addListener(() => {textValueUsername = controllerUsername.text});
    controllerName.addListener(() => {textValueName = controllerName.text});
    controllerSurname
        .addListener(() => {textValueSurname = controllerSurname.text});
    controllerPhone.addListener(() => {textValuePhone = controllerPhone.text});
    controllerPassword
        .addListener(() => {textValuePassword = controllerPassword.text});
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
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Üye Olmak",
                              style: buyukBoyBaslik,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Bu eğlenceye katılmak için bir hesap oluşturun",
                              style: buyukBoyBody,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MyTextField(
                              hintText: "Kullanıcı Adı",
                              inputType: TextInputType.text,
                              myController: controllerUsername,
                            ),
                            MyTextField(
                              hintText: "Ad",
                              inputType: TextInputType.text,
                              myController: controllerName,
                            ),
                            MyTextField(
                              hintText: "Soyad",
                              inputType: TextInputType.text,
                              myController: controllerSurname,
                            ),
                            MyTextField(
                              hintText: "Telefon",
                              inputType: TextInputType.phone,
                              myController: controllerPhone,
                            ),
                            MyTextField(
                              hintText: "Email",
                              inputType: TextInputType.emailAddress,
                              myController: controllerEmail,
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
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Hesabınız Var Mı? ",
                            style: ortaBoyBody,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const SignInPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Giriş Yap",
                              style: ortaBoyKalinBody.copyWith(
                                  color: appColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextButton(
                          buttonName: "Üye Ol",
                          onTap: () {
                            postRegister(
                              textValueUsername,
                              textValueName,
                              textValueSurname,
                              textValuePhone,
                              textValueEmail,
                              textValuePassword,
                            );
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
      ),
    );
  }

  void postRegister(String username, String fName, String lName, String phone,
      String email, String password) async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        status: "Yükleniyor",
        dismissOnTap: false);
    var dio = Dio(
      BaseOptions(
        baseUrl: apiURL,
      ),
    );
    Response<Map> response = await dio.post('/register', data: {
      "username": username,
      "fName": fName,
      "lName": lName,
      "phone": phone,
      "email": email,
      "password": password,
    });
    Map? responseBody = response.data;
    EasyLoading.dismiss();
    if (responseBody!["success"] == true) {
      Fluttertoast.showToast(
        msg: "Üyelik İşlemleri tamamlandı.",
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
