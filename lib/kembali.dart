import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sas/peminjaman.dart';

class Kembali extends StatefulWidget {
  final Map ListData;
  Kembali({Key? key, required this.ListData}) : super(key: key);

  @override
  State<Kembali> createState() => _KembaliState();
}

class _KembaliState extends State<Kembali> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController idPeminjamanController;
  late TextEditingController idPeminjamController;
  late TextEditingController jumlahBrgController;
  late TextEditingController statusController;
  late TextEditingController idBarangController;

  @override
  void initState() {
    super.initState();
    idPeminjamanController =
        TextEditingController(text: widget.ListData['id_peminjaman']);
    idPeminjamController =
        TextEditingController(text: widget.ListData['id_peminjam']);
    jumlahBrgController =
        TextEditingController(text: widget.ListData['jml_brg']);
    statusController = TextEditingController(text: widget.ListData['status']);
    idBarangController =
        TextEditingController(text: widget.ListData['id_barang']);
  }

  Future<bool> _kembalikanBarang() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.43.246/projekSas/kembali.php'),
        body: {
          'id_peminjaman': idPeminjamanController.text,
          'id_barang': idBarangController.text,
          'jml_brg': jumlahBrgController.text
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.body;
        final result = json.decode(responseData);
        if (result is Map && result.containsKey('success')) {
          return result['success'];
        } else {
          throw FormatException('Invalid JSON format');
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
        title: Text('Formulir Pengembalian Barang'),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                TextFormField(
                  controller: idPeminjamanController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'ID Peminjaman',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: idPeminjamController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'ID Peminjam',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: idBarangController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'ID Barang',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: jumlahBrgController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Jumlah Barang',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: statusController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: statusController.text == 'Kembali'
                        ? null
                        : () {
                            _kembalikanBarang().then((success) {
                              final snackBar = SnackBar(
                                content: Text(success
                                    ? "Berhasil mengembalikan barang"
                                    : "Gagal mengembalikan barang"),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              if (success) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PeminjamanPage()),
                                  (route) => false,
                                );
                              }
                            });
                          },
                    child: Text(
                      'Kembalikan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
