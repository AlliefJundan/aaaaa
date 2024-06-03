import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sas/peminjaman.dart';

class Pinjam extends StatefulWidget {
  final Map ListData;
  Pinjam({Key? key, required this.ListData}) : super(key: key);

  @override
  State<Pinjam> createState() => _PinjamState();
}

class _PinjamState extends State<Pinjam> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController namaController;
  late TextEditingController merkController;
  late TextEditingController jenisController;
  late TextEditingController jumlahController;
  late TextEditingController kodeController;
  late TextEditingController idPeminjamController;
  late TextEditingController jumlahDipinjamController;
  late TextEditingController keperluanController;

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
    idPeminjamController = TextEditingController();
    jumlahDipinjamController = TextEditingController();
    keperluanController = TextEditingController();
  }

  Future<bool> _editBarang() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.88.90/projekSas/pinjam.php'),
        body: {
          'id_barang': widget.ListData['id_barang'],
          'nama_barang': namaController.text,
          'merk_barang': merkController.text,
          'jenis_barang': jenisController.text,
          'jumlah_barang': jumlahController.text,
          'login': idPeminjamController.text,
          'jumlah': jumlahDipinjamController.text,
          'keperluan': keperluanController.text,
          'kode_barang': kodeController.text,
        },
      );

      // Log untuk memeriksa respon dari server
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = response.body;
        if (responseData.contains('<br /> <b>')) {
          print('Server Error: $responseData');
          return false;
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

  bool _cekJumlah(int jumlahDipinjam, int jumlahTersedia) {
    if (jumlahDipinjam <= 0) {
      _showAlert("Jumlah yang dipinjam harus lebih dari 0.");
      return false;
    }

    if (jumlahDipinjam > jumlahTersedia) {
      _showAlert("Jumlah yang dipinjam melebihi jumlah yang tersedia.");
      return false;
    }

    return true;
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final int jumlahTersediaSekarang = int.parse(widget.ListData['jumlah']);
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulir Peminjaman Barang'),
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
                Text('Kode Barang:'),
                SizedBox(height: 5),
                TextFormField(
                  controller: kodeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Kode Barang',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('Nama Barang:'),
                SizedBox(height: 5),
                TextFormField(
                  controller: namaController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Nama Barang',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('Merk Barang:'),
                SizedBox(height: 5),
                TextFormField(
                  controller: merkController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Merk Barang',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('Jenis Barang:'),
                SizedBox(height: 5),
                TextFormField(
                  controller: jenisController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Jenis Barang',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('Jumlah Tersedia:'),
                SizedBox(height: 5),
                TextFormField(
                  controller: jumlahController,
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: 'Jumlah Tersedia',
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
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: 'ID Peminjam',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('Jumlah Dipinjam:'),
                SizedBox(height: 5),
                TextFormField(
                  controller: jumlahDipinjamController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: 'Jumlah',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('Keperluan:'),
                SizedBox(height: 5),
                TextFormField(
                  controller: keperluanController,
                  decoration: InputDecoration(
                    hintText: 'Keperluan',
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
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final jumlahDipinjam =
                          int.parse(jumlahDipinjamController.text);
                      if (_cekJumlah(jumlahDipinjam, jumlahTersediaSekarang)) {
                        _editBarang().then((success) {
                          final snackBar = SnackBar(
                            content: Text(success
                                ? "Berhasil meminjam barang"
                                : "Gagal meminjam barang"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          if (success) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PeminjamanPage()),
                              (route) => false,
                            );
                          }
                        });
                      }
                    }
                  },
                  child: Text('Pinjam'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
