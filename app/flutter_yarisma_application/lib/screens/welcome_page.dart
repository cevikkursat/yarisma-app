import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yarisma_application/util/constants.dart';
import 'package:flutter_yarisma_application/screens/screen.dart';
import '../widgets/my_text_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Flexible(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: const Image(
                              image: AssetImage('assets/images/brain.png')),
                        ),
                      ),
                      const Text(
                        "YarışmaApp",
                        style: buyukBoyBaslik,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: welcomePageButtonRightBgColor,
                      borderRadius: BorderRadius.circular(18)),
                  child: Row(
                    children: [
                      Expanded(
                        child: MyTextButton(
                          bgColor: textButtonBgColor,
                          buttonName: "Üye Ol",
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ));
                          },
                          textColor: textButtonTextColor,
                        ),
                      ),
                      Expanded(
                        child: MyTextButton(
                          bgColor: Colors.transparent,
                          buttonName: "Giriş Yap",
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const SignInPage(),
                                ));
                          },
                          textColor: welcomePageButtonRightTextColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
