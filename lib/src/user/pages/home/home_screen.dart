import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:ride_hailer/src/user/pages/home/map_full_screen.dart';
import 'package:ride_hailer/src/user/pages/home/map_go_screen.dart';
import 'package:ride_hailer/src/user/pages/home/map_search_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return persistantBottomNabBar();
  }

  List<Widget> _buildScreens() {
    return [ MapSearchScreen(),MapFullScreen(), MapGoScreen()];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  PersistentBottomNavBarItem persistentBottomNavBarItem(
      {required String iconName, required String activeIconName}) {
    return PersistentBottomNavBarItem(
        icon: const Icon(Icons.home, color: Colors.black,),
        inactiveIcon: const Icon(Icons.mail_lock, color: Colors.black,),
        // iconSize: 10,
        activeColorPrimary: Colors.deepPurple,
        activeColorSecondary: Colors.grey);
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
       persistentBottomNavBarItem(
          iconName: "home", activeIconName: "home"),
            persistentBottomNavBarItem(
          iconName: "homelocation", activeIconName: "homelocation"),
            persistentBottomNavBarItem(
          iconName: "homesearch", activeIconName: "homesearch"),
    ];
  }

  Widget persistantBottomNabBar() {
    return PersistentTabView(navBarHeight:MediaQuery.of(context).size.height * 0.1,
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      onItemSelected: _onItemTapped,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
