
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/search_page.dart';
import 'pages/profile_page.dart';

void main() {
  runApp(const PinterestApp());
}

class PinterestApp extends StatelessWidget {
  const PinterestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pinterest',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE60023),
        ),
        useMaterial3: true,
      ),
      home: const PinterestNavigation(),
    );
  }
}

class PinterestNavigation extends StatefulWidget {
  const PinterestNavigation({super.key});

  @override
  State<PinterestNavigation> createState() =>
      _PinterestNavigationState();
}

class _PinterestNavigationState extends State<PinterestNavigation> {
  int index = 0;

  final pages = const [
    HomePage(),
    SearchPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFFCE4EC),
        selectedIndex: index,
        onDestinationSelected: (value) {
          setState(() => index = value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
