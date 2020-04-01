import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/auth.dart';
import './match_screen.dart';
import './profile_screen.dart';
import './feed_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();

  static const routeName = '/userScreen';
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 1;

  @override
  void initState() {
    _pages = [
      {
        'page': ProfileScreen(),
        'title': 'Profile',
      },
      {
        'page': FeedScreen(),
        'title': 'Feed',
      },
      {
        'page': MatchScreen(),
        'title': 'Matches',
      },
    ];

    Future.delayed(Duration.zero, () async {
      await Provider.of<Auth>(context, listen: false).getUserData();
    });
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          _pages[_selectedPageIndex]['page']
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Color(0xFF06AE71),
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: FittedBox(
              child: Icon(
                Icons.person,
                size: 40,
                color: Color(0xFF3D3D3D),
              ),
            ),
            activeIcon: FittedBox(
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.white,
              ),
            ),
            title: SizedBox(),
          ),
          BottomNavigationBarItem(
            icon: FittedBox(
              child: Icon(
                Icons.view_carousel,
                // Icons.content_copy,
                size: 40,
                color: Color(0xFF3D3D3D),
              ),
            ),
            activeIcon: FittedBox(
              child: Icon(
                Icons.view_carousel,
                size: 40,
                color: Colors.white,
              ),
            ),
            title: SizedBox(),
          ),
          BottomNavigationBarItem(
            icon: FittedBox(
              child: Icon(
                Icons.message,
                size: 40,
                color: Color(0xFF3D3D3D),
              ),
            ),
            activeIcon: FittedBox(
              child: Icon(
                Icons.message,
                size: 40,
                color: Colors.white,
              ),
            ),
            title: SizedBox(),
          ),
        ],
      ),
    );
  }
}
