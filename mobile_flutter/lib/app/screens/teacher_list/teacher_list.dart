import 'package:flutter/material.dart';
import 'available/available_widget.dart';
import 'favorites/favorites_widget.dart';

class TeacherListScreen extends StatefulWidget {
  @override
  _TeacherListScreenState createState() => _TeacherListScreenState();
}

class _TeacherListScreenState extends State<TeacherListScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [AvailableWidget(), FavoritesWidget()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xffF0F0F7),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Color(0xffC1BCCC),
        currentIndex: this._currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.tv),
            title: new Text('Proffys'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.favorite_border),
            title: new Text('Favoritos'),
          ),
        ],
      ),
      body: SafeArea(
        child: _children[_currentIndex],
      ),
    );
  }
}
