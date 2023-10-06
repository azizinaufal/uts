import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uts/ui/list_data.dart';
import 'package:uts/ui/sidemenu.dart';

class TambahData extends StatefulWidget {
  const TambahData({Key? key}) : super(key: key);

  @override
  _TambahDataState createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  final namatugasController = TextEditingController();
  final statusController = TextEditingController();

  Future postData(String nama_tugas, String status) async {
    // print(namatugas);
    String url = Platform.isAndroid
        ? 'http://10.0.2.2/api-flutter/index.php'
        : 'http://localhost/api-flutter/index.php';
    // String url = 'http://localhost/api-flutter/index.php';

    // String url = 'http://127.0.0.1/apiTrash/prosesLoginDriver.php';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsonBody = '{"nama_tugas": "$nama_tugas", "status": "$status"}';
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Tugas'),
      ),
      drawer: const Sidemenu(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: namatugasController,
              decoration: const InputDecoration(
                hintText: 'Nama Tugas',
              ),
            ),
            TextField(
              controller: statusController,
              decoration: const InputDecoration(
                hintText: 'Status',
              ),
            ),
            ElevatedButton(
              child: const Text('Tambah Tugas'),
              onPressed: () {
                String nama_tugas = namatugasController.text;
                String status = statusController.text;
                // print(namatugas);
                postData(nama_tugas, status).then((result) {
                  //print(result['pesan']);
                  if (result['pesan'] == 'berhasil') {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Tugas berhasil di tambah'),
                            content: const Text(''),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ListData(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        });
                  }
                  setState(() {});
                });
              },
            ),
          ],
        ),

        //     ],
        //   ),
        // ),
      ),
    );
  }
}
