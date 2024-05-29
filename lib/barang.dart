import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sas/editdata.dart';
import 'package:sas/pinjam.dart';
import 'package:sas/tambah.dart';

class BarangPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barang'),
      ),
      body: Barang(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Tambah()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Barang extends StatefulWidget {
  const Barang({Key? key}) : super(key: key);

  @override
  _BarangState createState() => _BarangState();
}

class _BarangState extends State<Barang> {
  List _listdata = [];

  Future _getdata() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.43.246/projekSas/read.php'));
      if (response.statusCode == 200) {
        print('Response Body: ${response.body}');
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
        });
      } else {
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future _hapus(String id) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.43.246/projekSas/delete.php'),
        body: {
          'id_barang': id,
        },
      );
      if (response.statusCode == 200) {
        print('Response Body: ${response.body}');
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
        });
      } else {
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getdata();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: _listdata
            .map(
              (item) => Card(
                child: ListTile(
                  title: Text(item['nama_barang']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID Barang: ${item['id_barang']}'),
                      Text("Kode Barang: ${item['kode_barang']}"),
                      Text("Merk Barang: ${item['merk']}"),
                      Text("Jenis Barang: ${item['jenis']}"),
                      Text("Jumlah: ${item['jumlah']}"),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pinjam(),
                                ),
                              );
                            },
                            child: Text('Pinjam Barang'),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditDataPage(
                                    ListData: item,
                                  ),
                                ),
                              );
                            },
                            child: Text('Edit Data Barang'),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text('Hapus barang ini?'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          _hapus(item['id_barang'])
                                              .then((value) {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        BarangPage())),
                                                (route) => false);
                                          });
                                        },
                                        child: Text('Hapus'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Batal'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('Hapus Barang'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
