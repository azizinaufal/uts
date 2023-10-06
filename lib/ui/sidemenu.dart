import 'package:flutter/material.dart';
import 'package:uts/ui/homepage.dart';
import 'package:uts/ui/logout_page.dart';
import 'package:uts/ui/list_data.dart';

class Sidemenu extends StatelessWidget {
  const Sidemenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Mohamad Naufal Azizi'),
            accountEmail: const Text('mohamad.zizi@mhs.unsoed.ac.id'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(child: Image.asset('images/azizi.jpg')),
            ),
            decoration: BoxDecoration(
                color: Colors.pinkAccent,
                image: DecorationImage(
                    image: AssetImage('images/back.jpg'), fit: BoxFit.cover)),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Data Tugas'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ListData(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Keterangan'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LogoutPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
