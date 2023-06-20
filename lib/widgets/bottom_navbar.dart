import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/bottom_navbar_pages/donate_page.dart';
import '../screens/bottom_navbar_pages/earthquake_live.dart';
import '../screens/bottom_navbar_pages/home_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    const EarthquakePage(),
    DonatePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 238, 199, 222),
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 222, 227, 230),
              icon: Icon(
                Icons.home,
              ),
              label: 'Ana Menü',
            ),
            BottomNavigationBarItem(
              backgroundColor: const Color.fromARGB(255, 222, 230, 226),
              icon: SvgPicture.asset(
                'assets/icons/earthquake.svg',
                width: 26,
                height: 26,
              ),
              label: 'Anlık Depremler',
            ),
            const BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 222, 227, 230),
              icon: Icon(Icons.monetization_on),
              label: 'Bağış Yap',
            ),
          ],
          selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}
