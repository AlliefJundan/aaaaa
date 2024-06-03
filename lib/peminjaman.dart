import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sas/beranda.dart';
import 'package:sas/detailPeminjaman.dart';
import 'package:sas/kembali.dart';
import 'package:sas/pinjam.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PeminjamanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Peminjaman'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String username =
                  prefs.getString('username') ?? 'default_username';
              String idUser = prefs.getString('id_user') ?? 'default_id';

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Beranda(username: username, idUser: idUser)),
              );
            },
          ),
        ),
        body: Peminjaman());
  }
}

class Peminjaman extends StatefulWidget {
  const Peminjaman({Key? key}) : super(key: key);

  @override
  _PeminjamanState createState() => _PeminjamanState();
}

class _PeminjamanState extends State<Peminjaman> {
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
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPeminjaman(ListData: item),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(item['nama_barang']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ID Peminjaman : " + item['id_peminjaman']),
                          Text("ID Peminjam : " + item['id_peminjam']),
                          Text("ID Barang : " + item['id_barang']),
                          Text("Kode Barang : " + item['kode_barang']),
                          Text("Tanggal Pinjam : " + item['tgl_pinjam']),
                          Text("Status : " + item['status']),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Kembali(
                                    ListData: item,
                                  ),
                                ),
                              );
                            },
                            child: Text('Kembalikan'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
