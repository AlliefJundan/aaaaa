import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sas/pinjam.dart';

class PeminjamanUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PeminjamanUser'),
        ),
        body: PeminjamanUser());
  }
}

class PeminjamanUser extends StatefulWidget {
  const PeminjamanUser({Key? key}) : super(key: key);

  @override
  _PeminjamanUserState createState() => _PeminjamanUserState();
}

class _PeminjamanUserState extends State<PeminjamanUser> {
  List _listdata = [];

  Future _getdata() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.88.90/projekSas/read2.php'));
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
                        Text(
                            "ID PeminjamanUser : " + item['id_PeminjamanUser']),
                        Text("ID Peminjam : " + item['id_peminjam']),
                        Text("ID Barang : " + item['id_barang']),
                        Text("Kode Barang : " + item['kode_barang']),
                        Text("Tanggal Pinjam : " + item['tgl_pinjam']),
                        Text("Tanggal Kembali : " + item['tgl_kembali']),
                        Text("Jumlah Pinjam : " + item['jml_brg']),
                        Text("Keperluan : " + item['keperluan']),
                        Text("Status : " + item['status']),
                        Text("ID Login : " + item['id_login']),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
