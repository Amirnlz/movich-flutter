import 'package:flutter/material.dart';
import 'package:movich/pages/lists_screen.dart';
import 'package:movich/pages/home_screen.dart';
import 'package:movich/pages/profile_screen.dart';
import 'package:movich/pages/search_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:iconsax/iconsax.dart';

class PersistentNavigationBar extends StatelessWidget {
  PersistentNavigationBar({Key? key}) : super(key: key);
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const ListScreen(),
      const SearchScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Iconsax.home),
        title: ("Home"),
        activeColorPrimary: Colors.blueAccent,
        inactiveColorPrimary: Colors.blueGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Iconsax.video_vertical),
        title: ("Lists"),
        activeColorPrimary: const Color(0xFFff004d),
        inactiveColorPrimary: Colors.blueGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Iconsax.search_normal),
        title: ("Search"),
        activeColorPrimary: const Color(0xFF2a9d8f),
        inactiveColorPrimary: Colors.blueGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Iconsax.user),
        title: ("Profile"),
        activeColorPrimary: const Color(0xFFe9c46a),
        inactiveColorPrimary: Colors.blueGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      margin: const EdgeInsets.all(5),
      confineInSafeArea: true,
      backgroundColor: const Color(0xff262626),
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(25.0),
      ),
      popAllScreensOnTapOfSelectedTab: false,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        curve: Curves.decelerate,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 650),
      ),
      navBarStyle: NavBarStyle.neumorphic,
    );
  }
}
