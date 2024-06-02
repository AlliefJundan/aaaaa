import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sas/editdata.dart';
import 'package:sas/pinjam.dart';
import 'package:sas/tambah.dart';
import 'package:sas/beranda.dart'; // Import Beranda page

class BarangUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barang'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Beranda()), // Navigate to Beranda
            );
          },
        ),
      ),
      body: BarangUser(),
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

class BarangUser extends StatefulWidget {
  const BarangUser({Key? key}) : super(key: key);

  @override
  _BarangUserState createState() => _BarangUserState();
}

class _BarangUserState extends State<BarangUser> {
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

  Future _hapus(String id) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.88.90/projekSas/delete.php'),
        body: {
          'id_BarangUser': id,
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
                  title: Text(item['nama_BarangUser']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID BarangUser: ${item['id_BarangUser']}'),
                      Text("Kode BarangUser: ${item['kode_BarangUser']}"),
                      Text("Merk BarangUser: ${item['merk']}"),
                      Text("Jenis BarangUser: ${item['jenis']}"),
                      Text("Jumlah: ${item['jumlah']}"),
                      SizedBox(height: 10),
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
