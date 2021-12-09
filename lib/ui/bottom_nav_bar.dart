import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  int _selectedIndex;
  BottomNavBar(selectedIndex) {
    _selectedIndex = selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 40,
      selectedIconTheme: IconThemeData(
        color: const Color(0xFF200087),
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.black12,
      ),
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Icon(Icons.home),
          ),
          title: Text(
            "Home",
            style: const TextStyle(color: Colors.black),
          ),
        ),
        BottomNavigationBarItem(
          icon: Padding(
            child: Icon(Icons.calculate),
            padding: const EdgeInsets.only(top: 8.0),
          ),
          title: Text(
            "BMI Calculator",
            style: const TextStyle(color: Colors.black),
          ),
        ),
        BottomNavigationBarItem(
          icon: Padding(
            child: Icon(Icons.food_bank_rounded),
            padding: const EdgeInsets.only(top: 8.0),
          ),
          title: Text(
            "Food",
            style: const TextStyle(color: Colors.black),
          ),
        ),
        BottomNavigationBarItem(
          icon: Padding(
            child: Icon(Icons.account_circle),
            padding: const EdgeInsets.only(top: 8.0),
          ),
          title: Text(
            "Profile",
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: (int _selectedIndex) {
        switch (_selectedIndex) {
          case 0:
            Navigator.popAndPushNamed(
              context,
              '/home',
            );
            break;
          case 1:
            Navigator.popAndPushNamed(
              context,
              '/bmi',
            );
            break;
          case 2:
            Navigator.popAndPushNamed(
              context,
              '/recipe',
            );
            break;
          case 3:
            Navigator.popAndPushNamed(
              context,
              '/realprofile',
            );
            break;
        }
      },
    );
  }
}
