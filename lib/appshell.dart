import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:learning/api_photo_juggar_view.dart';
import 'package:learning/listview_api.dart';
import 'package:learning/users_api.dart';

class Appshell extends StatefulWidget {
  const Appshell({super.key});

  @override
  State<Appshell> createState() => _AppshellState();
}

class _AppshellState extends State<Appshell> {
  int _selectedIndex = 0;

  // List of pages/screens for each tab
  final List<Widget> _pages = [
    ApiPhotoJuggarView(),
    UsersApi(),
    MyAPIData(),
    ApiPhotoJuggarView(), // Replace with your actual profile page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],  
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1)),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.purple,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.purple.withOpacity(0.1),
              color: Colors.grey[800],
              tabs: [
                GButton(icon: Icons.photo, text: 'Photos'),
                GButton(icon: Icons.person, text: 'Users'),
                GButton(icon: Icons.photo_album_sharp, text: 'Posts'),
                GButton(icon: Icons.gesture_sharp, text: 'Profile'),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
