import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Tambah extends StatefulWidget {
  @override
  _TambahState createState() => _TambahState();
}

class _TambahState extends State<Tambah> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController merkController = TextEditingController();
  TextEditingController jenisController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();

  Future<void> _tambahBarang() async {
    final response = await http.post(
      Uri.parse('http://192.168.88.90/projekSas/tambah_barang.php'),
      body: {
        'nama_barang': namaController.text,
        'merk_barang': merkController.text,
        'jenis_barang': jenisController.text,
        'jumlah_barang': jumlahController.text,
      },
    );

    final result = json.decode(response.body);

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['pesan'])),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['pesan'])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Barang'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama Barang'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Barang harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: merkController,
                decoration: InputDecoration(labelText: 'Merk Barang'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Merk Barang harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: jenisController,
                decoration: InputDecoration(labelText: 'Jenis Barang'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jenis Barang harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: jumlahController,
                decoration: InputDecoration(labelText: 'Jumlah Barang'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jumlah Barang harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _tambahBarang();
                  }
                },
                child: Text('Tambah Barang'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: Tambah(),
    ));
