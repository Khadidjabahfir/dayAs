import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:flutter/material.dart';


class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    // here we will add the pages once they are done 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('DayAs',
              style:LineStyles.header),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          indicatorColor: AppColors.bluePastel,
          selectedIndex: _selectedIndex,
          backgroundColor: Colors.white,
          
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Icons.chat_bubble),
              label: 'Discussion',
            ),
          ],
        ));
  }
}