import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sas/pinjam.dart';
import 'package:sas/tambah.dart'; // Import the Tambah class

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
          await http.get(Uri.parse('http://192.168.88.90/projekSas/read.php'));
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
            .map((item) => Card(
                  child: ListTile(
                    title: Text(item['nama_barang']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Kode Barang : " + item['kode_barang']),
                        Text("Merk Barang : " + item['merk']),
                        Text("Jenis Barang : " + item['jenis']),
                        Text("Jumlah : " + item['jumlah']),
                        SizedBox(height: 10),
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
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
