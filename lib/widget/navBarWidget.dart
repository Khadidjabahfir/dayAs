import 'package:dayas/cubits/CustomCubit.dart';
import 'package:dayas/cubits/ExploreCubit.dart';
import 'package:dayas/screens/ExploreScreen.dart';
import 'package:dayas/screens/HomeScreen.dart';
import 'package:dayas/screens/ProfileScreen.dart';
import 'package:dayas/screens/chatsScreen.dart';
import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBar extends StatefulWidget {
  final int initialIndex; 
  const BottomBar({super.key, this.initialIndex = 0});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
 
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    HomeScreen() , 
    Explorescreen() , 
    ChatsScreen() , 
    Profilescreen()
  ];
   @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; 
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
    providers: [
        BlocProvider<CustomCubit>(
          create: (context) => CustomCubit(),
        ),
        BlocProvider(
          create: (_) => Explorecubit()..fetchHeroes(),
        ),
    ], 
    child : Scaffold(
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
          indicatorColor: AppColors.purplePastel,
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
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'account',
            ),
          ],
        ),
        )
    );
  }
}