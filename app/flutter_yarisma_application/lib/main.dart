import 'package:flutter/material.dart';
import 'package:flutter_yarisma_application/screens/screen.dart';
import 'util/constants.dart';
import './util/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yarışma App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: appBgColor),
      home: FirstRunPage(),
      builder: EasyLoading.init(),
    );
  }
}
