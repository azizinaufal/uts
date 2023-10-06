import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:uts/ui/list_data.dart';
import 'package:uts/ui/sidemenu.dart';

class EditData extends StatefulWidget {
  const EditData(
      {Key? key,
      required this.nama_tugas,
      required this.status,
      required this.id})
      : super(key: key);
  final String id;
  final String nama_tugas;
  final String status;
  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final TextEditingController namatugasController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  Future updateData(String nama_tugas, String status) async {
    final baseUrl = Platform.isAndroid
        ? 'http://10.0.2.2/api-flutter/index.php'
        : 'http://localhost/api-flutter/index.php';

    final headers = <String, String>{'Content-Type': 'application/json'};
    final requestBody = <String, dynamic>{
      'id': widget.id,
      'nama_tugas': nama_tugas,
      'status': status,
    };

    final response = await http.put(
      Uri.parse(baseUrl),
      headers: headers,
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to update data');
    }
  }

  @override
  void initState() {
    super.initState();
    namatugasController.text = widget.nama_tugas;
    statusController.text = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Tugas'),
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
              onPressed: () async {
                final nama_tugas = namatugasController.text;
                final status = statusController.text;

                final result = await updateData(nama_tugas, status);

                if (result['pesan'] == 'berhasil') {
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Tugas berhasil di update'),
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
                    },
                  );
                }
                setState(() {});
              },
              child: const Text('Update Tugas'),
            )
          ],
        ),
      ),
    );
  }
}
