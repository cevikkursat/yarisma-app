import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yarisma_application/util/constants.dart';
import 'package:flutter_yarisma_application/screens/screen.dart';
import 'package:flutter_yarisma_application/util/shared_preferences.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Ana Sayfa',
      style: ortaBoyBaslik,
    ),
    Text(
      'Arama',
      style: ortaBoyBaslik,
    ),
    Text(
      'Yarışma Oluştur',
      style: ortaBoyBaslik,
    ),
    Text(
      'Hesap',
      style: ortaBoyBaslik,
    ),
    Text(
      'Admin',
      style: ortaBoyBaslik,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _widgetOptions.elementAt(_selectedIndex),
        backgroundColor: appBarBgColor,
        actions: [
          Row(
            children: [
              IconButton(
                splashColor: Colors.transparent,
                onPressed: () {
                  Preferences.removeID();
                  Preferences.removeIsLogin();
                  Preferences.removeRole();
                  Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                        builder: (context) => const WelcomePage(),
                      ),
                      (route) => false);
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          )
        ],
      ),
      body: getPage(),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black54,
              blurRadius: 15.0,
              offset: Offset(0.0, 0.75))
        ]),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: appBarBgColor,
          currentIndex: _selectedIndex,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          unselectedItemColor: unselectedItemColor,
          selectedItemColor: appColor,
          elevation: 0,
          items: getBottomNavigator(),
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  dynamic getPage() {
    switch (_selectedIndex) {
      case 0:
        return HomePage();
      case 1:
        return SearchPage();
      case 2:
        return EventCreatePage();
      case 3:
        return AccountPage();
      case 4:
        return AdminPage();
    }
  }

  List<BottomNavigationBarItem> getBottomNavigator() {
    if (Preferences.getRole() == "admin") {
      return [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Ana Sayfa',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Arama',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.post_add_outlined),
          label: 'Yarışma Oluştur',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Hesap',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.admin_panel_settings),
          label: 'Admin',
        )
      ];
    } else {
      return [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Ana Sayfa',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Arama',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.post_add_outlined),
          label: 'Yarışma Oluştur',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Hesap',
        )
      ];
    }
  }
}
