import 'package:flutter/material.dart';
import 'package:flutter_yarisma_application/screens/screen.dart';
import '../util/shared_preferences.dart';

class FirstRunPage extends StatefulWidget {
  const FirstRunPage({super.key});

  @override
  State<FirstRunPage> createState() => _FirstRunPageState();
}

class _FirstRunPageState extends State<FirstRunPage> {
  bool _isLogin = false;

  @override
  void initState() {
    super.initState();
    _isLogin = Preferences.getIsLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLogin ? const IndexPage() : const WelcomePage(),
    );
  }
}
