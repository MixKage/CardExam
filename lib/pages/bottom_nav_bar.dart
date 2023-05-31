import 'package:cardexam/pages/local_page.dart';
import 'package:cardexam/pages/notification_page.dart';
import 'package:cardexam/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class HideNavBar extends ChangeNotifier {
  bool hideNavBar = false;

  void hideNavigationBar() {
    hideNavBar = !hideNavBar;
    notifyListeners();
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;
    controller = PersistentTabController(initialIndex: 1);
    bool hideNavBar = Provider.of<HideNavBar>(context).hideNavBar;

    List<Widget> buildScreens() => [
          Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar.large(
                  centerTitle: true,
                  title: Text(
                    'Облако',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                // Just some content big enough to have something to scroll.
                SliverToBoxAdapter(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Column(
                        children: const [
                          SizedBox(
                            height: 40,
                          ),
                          Icon(
                            Icons.build,
                            size: 72,
                          ),
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              'В разработке',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const LocalPage(),
          Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar.large(
                  centerTitle: true,
                  title: Text(
                    'Статистика',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                // Just some content big enough to have something to scroll.
                SliverToBoxAdapter(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Column(
                        children: const [
                          SizedBox(
                            height: 40,
                          ),
                          Icon(
                            Icons.build,
                            size: 72,
                          ),
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              'В разработке',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const NotificationPage(),
          const SettingsPage(),
        ];

    List<PersistentBottomNavBarItem> navBarsItems() => [
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.cloud),
            title: 'Cloud',
            activeColorPrimary: Theme.of(context).colorScheme.onPrimary,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.storage),
            title: 'LocaleStorage',
            activeColorPrimary: Theme.of(context).colorScheme.onPrimary,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.query_stats),
            title: 'Explore',
            activeColorPrimary: Theme.of(context).colorScheme.onPrimary,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.notifications),
            title: 'Notify',
            activeColorPrimary: Theme.of(context).colorScheme.onPrimary,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.settings),
            title: 'Settings',
            activeColorPrimary: Theme.of(context).colorScheme.onPrimary,
            inactiveColorPrimary: Colors.grey,
          ),
        ];

    return PersistentTabView(
      context,
      controller: controller,
      screens: buildScreens(),
      items: navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Theme.of(context)
          .colorScheme
          .primaryContainer, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when
      // keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBar: hideNavBar,
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while
      // using this argument. Default is true.
      decoration: const NavBarDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
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
          NavBarStyle.style12, // Choose the nav bar style with this property.
    );
  }
}
