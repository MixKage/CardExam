import 'package:cardexam/pages/notification_page.dart';
import 'package:cardexam/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;
    controller = PersistentTabController(initialIndex: 4);

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
                    children: const [
                      Text('1'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar.large(
                  centerTitle: true,
                  title: Text(
                    'Сохранённое',
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
                    children: const [
                      Text('2'),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                      SwitchListTile(
                        title: const Text('Темная тема'),
                        onChanged: (value) {},
                        value: true,
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
