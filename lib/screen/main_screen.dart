import 'package:flutter/material.dart';
import 'package:my_school/screen/about_screen.dart';
import 'package:my_school/screen/contact_screen.dart';
import 'package:my_school/screen/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Map<String, dynamic>> _menu = [
    {
      "title": "ข่าวสาร",
      "icon": Icons.newspaper,
      "screen": HomeScreen(),
    },
    {
      "title": "ติดต่อเรา",
      "icon": Icons.phone,
      "screen": ContactScreen(),
    },
    {
      "title": "เกี่ยวกับเรา",
      "icon": Icons.info,
      "screen": AboutScreen(),
    },
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_menu[_currentIndex]['title']),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Bundit Nuntates'),
              accountEmail: Text('silkyland@gmail.com'),
              currentAccountPicture: CircleAvatar(
                radius: 50,
                backgroundImage: Image.network(
                  'https://i.natgeofe.com/n/f0dccaca-174b-48a5-b944-9bcddf913645/01-cat-questions-nationalgeographic_1228126_4x3.jpg',
                ).image,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("หน้าหลัก"),
            ),
            ListTile(
              leading: Icon(Icons.dangerous),
              title: Text("หน้าอื่นๆ"),
            )
          ],
        ),
      ),
      body: _menu[_currentIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: _menu
            .map(
              (e) => BottomNavigationBarItem(
                icon: Icon(e['icon']),
                label: e['title'],
              ),
            )
            .toList(),
      ),
    );
  }
}
