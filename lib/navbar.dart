import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:uasmobile/earthquake_list.dart';
import 'package:uasmobile/notes.dart';
import 'package:uasmobile/user_profile.dart';  // Make sure this import is correct

class Navbar extends StatefulWidget {
  final String userEmail;

  Navbar({required this.userEmail});

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 0;

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      EarthquakeList(),
      Notes(),
      ProfilePage(),  // Use ProfilePage instead of UserProfile
      // Add a placeholder or map page here when implementing Google Maps
      // You can later replace `MapsPage()` with your Google Maps implementation
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Color.fromRGBO(116, 53, 242, 1),
        items: <Widget>[
          Icon(Icons.data_object, color: Colors.white, size: 30),  // Earthquake List icon
          Icon(Icons.edit_note_sharp, color: Colors.white, size: 30),  // Notes icon
          Icon(Icons.person, color: Colors.white, size: 30),  // Profile icon
        ],
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
