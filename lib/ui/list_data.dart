import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uts/ui/edit_data.dart';
import 'package:uts/ui/sidemenu.dart';
import 'package:uts/ui/tambah_data.dart';

class ListData extends StatefulWidget {
  const ListData({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  List<Map<String, String>> dataTugas = [];
  String url = Platform.isAndroid
      ? 'http://10.0.2.2/api-flutter/index.php'
      : 'http://localhost/api-flutter/index.php';
  // String url = 'http://localhost/api-flutter/index.php';
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        dataTugas = List<Map<String, String>>.from(data.map((item) {
          return {
            'nama_tugas': item['nama_tugas'] as String,
            'status': item['status'] as String,
            'id': item['id'] as String,
          };
        }));
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future deleteData(int id) async {
    final response = await http.delete(Uri.parse('$url?id=$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to delete data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Tugas'),
      ),
      drawer: const Sidemenu(),
      body: Column(children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: dataTugas.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(dataTugas[index]['nama_tugas']!),
                subtitle: Text('Status: ${dataTugas[index]['status']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.visibility),
                      onPressed: () {
                        lihatTugas(context, index);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        editTugas(context, index);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Hapus Data'),
                                content: const Text(
                                    'Apakah Anda yakin mau menghapus data?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ListData(),
                                        ),
                                      );
                                    },
                                    child: const Text('Tidak'),
                                  ),
                                  TextButton(
                                    child: const Text('Ya'),
                                    onPressed: () {
                                      deleteData(int.parse(
                                              dataTugas[index]['id']!))
                                          .then((result) {
                                        if (result['pesan'] == 'berhasil') {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ListData(),
                                            ),
                                          );
                                        }
                                      });
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const TambahData(),
              ),
            );
          },
          child: const Text('Tambah Tugas'),
        ),
      ]),
    );
  }

  void editTugas(BuildContext context, int index) {
    final Map<String, dynamic> tugas = dataTugas[index];
    final String id = tugas['id'] as String;
    final String nama_tugas = tugas['nama_tugas'] as String;
    final String status = tugas['status'] as String;

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          EditData(id: id, nama_tugas: nama_tugas, status: status),
    ));
  }

  void lihatTugas(BuildContext context, int index) {
    final tugas = dataTugas[index];
    final nama_tugas = tugas['nama_tugas'] as String;
    final status = tugas['status'] as String;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          title: const Center(child: Text('Detail Tugas')),
          content: SizedBox(
            height: 50,
            child: Column(
              children: [
                Text('Nama Tugas : $nama_tugas'),
                Text('status: $status'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
