import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sas/barang.dart';
import 'package:sas/beranda.dart';
import 'package:sas/homepage.dart';

void main() => runApp(const Pinjam());

class Pinjam extends StatelessWidget {
  const Pinjam({Key? key}) : super(key: key);

  static const String _title = 'Formulir Pinjam';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: PinjamState(),
    );
  }
}

class PinjamState extends StatefulWidget {
  const PinjamState({Key? key}) : super(key: key);

  @override
  State<PinjamState> createState() => _PinjamState();
}

class _PinjamState extends State<PinjamState> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController kode = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController merk = TextEditingController();
  TextEditingController jenis = TextEditingController();
  TextEditingController jumlah = TextEditingController();
  TextEditingController peminjam = TextEditingController();
  TextEditingController keperluan = TextEditingController();
  TextEditingController jumlahPinjam = TextEditingController();

  Future<bool> _pinjam() async {
    final response = await http.post(
      Uri.parse('http://192.168.88.90/projekSas/create.php'),
      body: {
        'kode_barang': kode.text,
        'nama_barang': nama.text,
        'merk_barang': merk.text,
        'jenis_barang': jenis.text,
        'jumlah_barang': jumlah.text,
        'id_peminjam': peminjam.text,
        'keperluan': keperluan.text,
        'jml_brg': jumlahPinjam.text,
      },
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result['success'];
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulir Pinjam'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: kode,
                  decoration: InputDecoration(labelText: 'ID Barang'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kode Barang harus diisi';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: nama,
                  decoration: InputDecoration(labelText: 'Nama Barang'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama Barang harus diisi';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: merk,
                  decoration: InputDecoration(labelText: 'Jenis Barang'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Merk Barang harus diisi';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: jenis,
                  decoration: InputDecoration(labelText: 'Merk Barang'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jenis Barang harus diisi';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: jumlah,
                  decoration: InputDecoration(labelText: 'Jumlah Tersedia'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jumlah Barang harus diisi';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: peminjam,
                  decoration: InputDecoration(labelText: 'ID Peminjam'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ID Peminjam harus diisi';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: jumlahPinjam,
                  decoration: InputDecoration(labelText: 'Jumlah Pinjam'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jumlah Pinjam harus diisi';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: keperluan,
                  decoration: InputDecoration(labelText: 'Keperluan'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Keperluan harus diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _pinjam().then((success) {
                        final snackBar = SnackBar(
                          content: Text(
                              success ? 'Berhasil Dipinjam' : 'Gagal Meminjam'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Beranda()),
                          (route) => false);
                    }
                  },
                  child: Text('Submit'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Beranda()),
                    );
                  },
                  child: Text('Kembali'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
