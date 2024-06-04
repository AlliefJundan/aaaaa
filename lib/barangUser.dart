import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sas/berandaUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BarangUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barang'),
        backgroundColor: Colors.deepOrange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String username = prefs.getString('username') ?? 'default_username';
            String idUser = prefs.getString('id_user') ?? 'default_id';

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BerandaUser(username: username, idUser: idUser),
              ),
            );
          },
        ),
      ),
      body: Barang(),
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
