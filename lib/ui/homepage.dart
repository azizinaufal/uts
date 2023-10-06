import 'package:flutter/material.dart';
import 'package:uts/ui/sidemenu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Saya'),
        backgroundColor: Colors.blueGrey,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('images/erwin.jpg'),
            ),
            Text(
              'NAMA: Mohamad Naufal Azizi',
              style: TextStyle(fontSize: 20.0, color: Colors.blue),
            ),
            Text(
              'NIM: H1D021023',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
            Text(
              'Ujian Tengah Smester Pemrograman Mobile',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
      drawer: const Sidemenu(),
    );
  }
}
