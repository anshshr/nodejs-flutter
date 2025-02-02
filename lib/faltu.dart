// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: 'navbar',
//     home: NavBar(),
//   ));
// }

// class NavBar extends StatelessWidget {
//   const NavBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: CurvedNavigationBar(
//         animationDuration: Duration(milliseconds: 300),
//         backgroundColor: Colors.grey[100]!,
//         color: Colors.black,
//         onTap: (value) => print(value),
//         items: [
//         Icon(
//           Icons.home,
//           color: Colors.white,
//         ),
//         Icon(
//           Icons.school_rounded,
//           color: Colors.white,
//         ),
//         Icon(
//           Icons.person,
//           color: Colors.white,
//         ),
//       ]),
//       appBar: AppBar(
//         title: Text('navbar'),
//         centerTitle: true,
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'navbar',
    home: NavBar(),
  ));
}

class NavBar extends StatelessWidget {
  NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        height: 80,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(20)),
        child: Container(
          color: Colors.black,
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: GNav(
                backgroundColor: Colors.black,
                color: Colors.white,
                tabBackgroundColor: Colors.grey.shade600,
                activeColor: Colors.white,
                padding: EdgeInsets.all(14),
                onTabChange: (value) => print(value),
                gap: 8,
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'HOME',
                  ),
                  GButton(
                    icon: Icons.school_rounded,
                    text: 'COURSES',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'PROFILE',
                  ),
                ]),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('navbar'),
      ),
    );
  }
}
