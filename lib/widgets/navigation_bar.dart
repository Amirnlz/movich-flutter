import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFF11110f),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.grey.withOpacity(0.1),
          )
        ],
      ),
      child: const GNav(
        gap: 8,
        activeColor: Color(0xFFC3D5FE),
        iconSize: 24,
        textStyle: TextStyle(
          color: Color(0xFFC3D5FE),
          fontFamily: 'OpenSans',
          letterSpacing: .5,
        ),
        curve: Curves.easeIn,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: Duration(milliseconds: 300),
        tabBackgroundColor: Color(0xff262626),
        tabMargin: EdgeInsets.all(7),
        color: Color(0XFF555464),
        tabs: [
          GButton(
            icon: Iconsax.home,
            text: 'Home',
          ),
          GButton(
            icon: Iconsax.filter_search,
            text: 'Filter',
          ),
          GButton(
            icon: Iconsax.search_normal,
            text: 'Search',
          ),
          GButton(
            icon: Iconsax.user,
            text: 'Account',
          )
        ],
      ),
    );
  }
}
