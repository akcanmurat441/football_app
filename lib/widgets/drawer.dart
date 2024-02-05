import 'package:flutter/material.dart';
import 'package:football_app/pages/home/screen/home_screen.dart';
import 'package:football_app/pages/settings/screen/settings_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

var appbarTitle = [
  "Fixture List",
  "Settings",
];

class _MyDrawerState extends State<MyDrawer> {
  Widget currentPage = const HomeScreen();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appbarTitle[currentIndex]),
        backgroundColor: const Color.fromARGB(255, 38, 84, 122),
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 38, 84, 122),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'akcanmurat441',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'akcanmurat@dmail.ai',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  currentPage = const HomeScreen();
                  currentIndex = 0;
                });
              },
              tileColor: currentIndex == 0 ? Colors.grey[300] : null,
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  currentPage = const SettingsScreen();
                  currentIndex = 1;
                });
              },
              tileColor: currentIndex == 1 ? Colors.grey[300] : null,
            ),
          ],
        ),
      ),
      body: currentPage,
    );
  }
}
