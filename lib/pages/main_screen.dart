import 'package:flutter/material.dart';
import 'package:mapakaon_redo/pages/history_page.dart';
import 'package:mapakaon_redo/pages/home_page.dart';
import 'package:mapakaon_redo/pages/maps_page.dart';
import 'package:mapakaon_redo/pages/settings_page.dart';
import '../Utils/colors.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // adding a _selectedIndex variable, It tracks which bottom nav item is
  // being selected

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    MapsPage(),
    HistoryPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0; // or go back to previous index if tracked
          });
          return false; // prevent the default pop behavior
        }
        return true; // allow default behavior (exit app)
      },
      child: Scaffold(
        backgroundColor: bgColor,
        body: _pages[_selectedIndex],
        bottomNavigationBar:
            _selectedIndex == 1
                ? null
                : Container(
                  height: 100,
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: bgColor,
                    currentIndex: _selectedIndex,
                    onTap: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    selectedItemColor: appColor,
                    // customize to match your theme
                    unselectedItemColor: Colors.grey,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.map),
                        label: "Maps",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.history),
                        label: "History",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.settings),
                        label: "Settings",
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
