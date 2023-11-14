import 'package:flutter/material.dart';
import 'package:flutter_sos/home_screen.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_sos/map.dart';

class Views extends StatefulWidget {
  const Views({Key? key}) : super(key: key);

  @override
  _ViewsState createState() => _ViewsState();
}

class _ViewsState extends State<Views> {
  int _currentIndex = 1;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final PageController _pageController = PageController(initialPage: 1);
  final List<Widget> _pages = [
    HomeScreen(),
    MapScreen(),
    // 필요한 경우 다른 페이지를 추가합니다
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: _pages,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(31, 40, 71, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildNavBarItem(Octicons.report, 0),
              buildNavBarItem(MaterialCommunityIcons.map_marker, 1),
              IconButton(
                icon: Icon(
                  Feather.settings,
                  color: _currentIndex == 2 ? Colors.white : Colors.grey,
                ),
                onPressed: () {
                  // Feather.settings 아이콘이 눌렸을 때 Drawer를 엽니다
                  _scaffoldKey.currentState?.openEndDrawer();
                },
              ),
            ],
          ),
        ),
      ),
      endDrawer: Drawer(
        // 여기에 Drawer 내용을 추가합니다
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(31, 40, 71, 1),
              ),
              child: Text(
                '사용자',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // 원하는 설정 항목을 여기에 추가합니다
          ],
        ),
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: _currentIndex == index ? Colors.white : Colors.grey,
      ),
      onPressed: () {
        _pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
    );
  }
}
