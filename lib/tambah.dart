import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sas/barang.dart';

class Tambah extends StatefulWidget {
  const Tambah({Key? key});

  @override
  State<Tambah> createState() => _FormulirState();
}

class _FormulirState extends State<Tambah> {
  final formkey = GlobalKey<FormState>();
  TextEditingController id_barang = TextEditingController();
  TextEditingController kode_barang = TextEditingController();
  TextEditingController nama_barang = TextEditingController();
  TextEditingController merk = TextEditingController();
  TextEditingController jenis = TextEditingController();
  TextEditingController jumlah = TextEditingController();

  Future<bool> _simpan() async {
    final response = await http.post(
      Uri.parse('http://192.168.88.90/projekSas/create.php'),
      body: {
        'id_barang': id_barang.text,
        'kode_barang': kode_barang.text,
        'nama_barang': nama_barang.text,
        'merk': merk.text,
        'jenis': jenis.text,
        'jumlah': jumlah.text,
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambahkan Barang'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Form(
        key: formkey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: nama_barang,
                decoration: InputDecoration(
                  hintText: 'Nama Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama barang tidak boleh kosong!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: id_barang,
                keyboardType:
                    TextInputType.number, // Set keyboard type to number
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ], // Only allow digits
                decoration: InputDecoration(
                  hintText: 'ID Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'ID Barang tidak boleh kosong!';
                //   }
                //   return null;
                // },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: kode_barang,
                decoration: InputDecoration(
                  hintText: 'Kode Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Kode Barang tidak boleh kosong!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: merk,
                decoration: InputDecoration(
                  hintText: 'Merk Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Merk Barang tidak boleh kosong!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: jenis,
                decoration: InputDecoration(
                  hintText: 'Jenis Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Jenis Barang tidak boleh kosong!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: jumlah,
                keyboardType:
                    TextInputType.number, // Set keyboard type to number
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ], // Only allow digits
                decoration: InputDecoration(
                  hintText: 'Jumlah Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Jumlah Barang tidak boleh kosong!';
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
                  if (formkey.currentState!.validate()) {
                    _simpan().then((value) {
                      final snackBar = SnackBar(
                        content: Text(value
                            ? "Barang berhasil ditambahkan"
                            : "Barang gagal ditambahkan"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      if (value) {
                        nama_barang.clear();
                        kode_barang.clear();
                        merk.clear();
                        jenis.clear();
                        jumlah.clear();
                        id_barang.clear();
                      }
                    });
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => BarangPage()),
                      (route) => false,
                    );
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
