import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketku_vendor/src/views/screens/main/earning/earning_screen.dart';
import 'package:marketku_vendor/src/views/screens/main/edit/edit_screen.dart';
import 'package:marketku_vendor/src/views/screens/main/orders/orders_screen.dart';
import 'package:marketku_vendor/src/views/screens/main/profile/profile_screen.dart';
import 'package:marketku_vendor/src/views/screens/main/upload/upload_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;

  List<Widget> pages = [
    EarningScreen(),
    UploadScreen(),
    EditScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: (value) {
            setState(() {
              pageIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.blueAccent,
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.money_dollar), label: "Earnings"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.upload_circle), label: "Upload"),
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: "Edit"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.shopping_cart), label: "Orders"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.profile_circled), label: "Profile")
          ]),
      body: pages[pageIndex],
    );
  }
}
