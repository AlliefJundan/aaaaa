import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sas/barang.dart';

class EditDataPage extends StatefulWidget {
  final Map ListData;
  EditDataPage({Key? key, required this.ListData}) : super(key: key);

  @override
  State<EditDataPage> createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController namaController;
  late TextEditingController merkController;
  late TextEditingController jenisController;
  late TextEditingController jumlahController;
  late TextEditingController kodeController;

  @override
  void initState() {
    super.initState();
    namaController =
        TextEditingController(text: widget.ListData['nama_barang']);
    merkController = TextEditingController(text: widget.ListData['merk']);
    jenisController = TextEditingController(text: widget.ListData['jenis']);
    jumlahController = TextEditingController(text: widget.ListData['jumlah']);
    kodeController =
        TextEditingController(text: widget.ListData['kode_barang']);
  }

  Future<bool> _editBarang() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.43.246/projekSas/edit.php'),
        body: {
          'id_barang': widget.ListData['id_barang'],
          'nama_barang': namaController.text,
          'merk_barang': merkController.text,
          'jenis_barang': jenisController.text,
          'jumlah_barang': jumlahController.text,
          'kode_barang': kodeController.text,
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.body;
        if (responseData.contains('<br /> <b>')) {
          print('Server Error: $responseData');
          return false; // Handle server error accordingly
        } else {
          final result = json.decode(responseData);
          if (result is Map && result.containsKey('success')) {
            return result['success'];
          } else {
            throw FormatException('Invalid JSON format');
          }
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data Barang'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: kodeController,
                decoration: InputDecoration(
                  hintText: 'Kode Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kode Barang harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(
                  hintText: 'Nama Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Barang harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: merkController,
                decoration: InputDecoration(
                  hintText: 'Merk Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Merk Barang harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: jenisController,
                decoration: InputDecoration(
                  hintText: 'Jenis Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jenis Barang harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: jumlahController,
                decoration: InputDecoration(
                  hintText: 'Jumlah Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jumlah Barang harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _editBarang().then((success) {
                      final snackBar = SnackBar(
                        content: Text(success
                            ? "Data berhasil diperbarui"
                            : "Gagal memperbarui data"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      if (success) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => BarangPage()),
                          (route) => false,
                        );
                      }
                    });
                  }
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
