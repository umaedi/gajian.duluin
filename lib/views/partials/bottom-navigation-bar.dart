import 'package:duluin_app/contants/color.dart';
import 'package:duluin_app/views/blog-page.dart';
import 'package:duluin_app/views/dashboard-page.dart';
import 'package:duluin_app/views/history-page.dart';
import 'package:duluin_app/views/profile-page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigationPartial extends StatefulWidget {
  final int initialPage;
  const BottomNavigationPartial({Key? key, required this.initialPage})
      : super(key: key);

  @override
  _BottomNavigationPartialState createState() =>
      _BottomNavigationPartialState();
}

class _BottomNavigationPartialState extends State<BottomNavigationPartial> {
  late int _currentIndex;

  final List<Widget> _pages = [
    const DashboardPage(),
    const HistoryPage(),
    const BlogPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialPage;
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            selectedItemColor: COLOR_PRIMARY_GREEN,
            backgroundColor: Colors.transparent,
            elevation: 0,
            onTap: _onTabTapped,
            iconSize: size.width * 0.050,
            selectedLabelStyle: TextStyle(fontSize: size.width * 0.030),
            unselectedLabelStyle: TextStyle(fontSize: size.width * 0.030),
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.house,
                  size: size.width * 0.050,
                ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.rectangleList,
                  size: size.width * 0.050,
                ),
                label: 'Riwayat',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.newspaper,
                  size: size.width * 0.050,
                ),
                label: 'Duluin',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.user,
                  size: size.width * 0.050,
                ),
                label: 'Saya',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
