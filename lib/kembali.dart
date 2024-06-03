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
        Uri.parse('http://192.168.88.90/projekSas/kembali.php'),
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
                Text('ID Peminjaman:'),
                SizedBox(height: 5),
                TextFormField(
                  controller: idPeminjamanController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'ID Peminjaman',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('ID Peminjam:'),
                SizedBox(height: 5),
                TextFormField(
                  controller: idPeminjamController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'ID Peminjam',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('ID Barang:'),
                SizedBox(height: 5),
                TextFormField(
                  controller: idBarangController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'ID Barang',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('Jumlah Barang:'),
                SizedBox(height: 5),
                TextFormField(
                  controller: jumlahBrgController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Jumlah Barang',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('Status:'),
                SizedBox(height: 5),
                TextFormField(
                  controller: statusController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Status',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
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
                  child: Text('Kembalikan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
