import 'package:brillo/buddies.dart';
import 'package:brillo/email_login.dart';
import 'package:brillo/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedItem;
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Profile(),
    Buddies(),
    Discover(),
    SettingsPrivacy()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Profile",
                backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance),
                label: "Buddies",
                backgroundColor: Colors.yellow),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Discover",
                backgroundColor: Colors.yellow),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Settings",
              backgroundColor: Colors.blue,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
