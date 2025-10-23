import 'package:evently_c16_mon/core/theme/app_colors.dart';
import 'package:evently_c16_mon/ui/home/favorite_tab/favorite_tab.dart';
import 'package:evently_c16_mon/ui/home/home_tab/home_tab.dart';
import 'package:evently_c16_mon/ui/home/profile_tab/profile_tab.dart';
import 'package:evently_c16_mon/ui/manage_events/manage_events_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  late List<Widget> tabs = [
    HomeTab(),
    Center(child: Text("2", style: Theme.of(context).textTheme.titleLarge)),
    Center(child: Text("5", style: Theme.of(context).textTheme.titleLarge)),
    FavoriteTab(),
    ProfileTab()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [Expanded(child: tabs[selectedIndex])]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ManageEventsScreen.routeName);
        },
        shape: CircleBorder(side: BorderSide(width: 4, color: AppColors.white)),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          if(index == 2){
            Navigator.pushNamed(context, ManageEventsScreen.routeName);
          }else {
            selectedIndex = index;
          }
          setState(() {});
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            activeIcon: Icon(Icons.location_on),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_on_outlined,
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

}
