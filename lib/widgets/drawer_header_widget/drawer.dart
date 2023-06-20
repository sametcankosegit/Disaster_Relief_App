import 'package:flutter/material.dart';
import '../../login/login_page.dart';
import 'about_us_page/about_us_page.dart';
import 'activity_page/activity_page.dart';
import 'contact_us_page/contact_us_page.dart';
import 'family_info_page/views/list_family_merbers.dart';
import 'news_page/news_page.dart';
import 'profile_page/profile_page.dart';
import 'settings_page/settings_page.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 225, 245, 255),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/turk_bayragi.png'),
                  fit: BoxFit.contain),
            ),
            child: null,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.account_circle,
              size: 28,
              color: Colors.black,
            ),
            title: const Text(
              'Profil',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          const Divider(color: Color.fromARGB(255, 136, 134, 134)),
          ListTile(
            leading: const Icon(
              Icons.family_restroom,
              size: 28,
              color: Colors.black,
            ),
            title: const Text(
              'Aile Bilgisi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListFamilyMembers()),
              );
            },
          ),
          const Divider(color: Color.fromARGB(255, 136, 134, 134)),
          ListTile(
            leading: const Icon(
              Icons.settings,
              size: 28,
              color: Colors.black,
            ),
            title: const Text(
              'Ayarlar',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
          const Divider(color: Color.fromARGB(255, 136, 134, 134)),
          ListTile(
            leading: const Icon(
              Icons.newspaper,
              size: 28,
              color: Colors.black,
            ),
            title: const Text(
              'Gündem',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsPage()),
              );
            },
          ),
          const Divider(color: Color.fromARGB(255, 136, 134, 134)),
          ListTile(
            leading: const Icon(
              Icons.local_activity,
              size: 28,
              color: Colors.black,
            ),
            title: const Text(
              'Faaliyetlerimiz',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ActivityPage()),
              );
            },
          ),
          const Divider(color: Color.fromARGB(255, 136, 134, 134)),
          ListTile(
            leading: const Icon(
              Icons.call,
              size: 28,
              color: Colors.black,
            ),
            title: const Text(
              'İletişim',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactUsPage()),
              );
            },
          ),
          const Divider(color: Color.fromARGB(255, 136, 134, 134)),
          ListTile(
            leading: const Icon(
              Icons.info,
              size: 28,
              color: Colors.black,
            ),
            title: const Text(
              'Hakkında',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUsPage()),
              );
            },
          ),
          const Divider(color: Color.fromARGB(255, 136, 134, 134)),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              size: 28,
              color: Colors.black,
            ),
            title: const Text(
              'Çıkış Yap',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
