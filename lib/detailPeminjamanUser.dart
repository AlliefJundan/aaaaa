import 'package:flutter/material.dart';

class DetailPeminjamanUser extends StatefulWidget {
  final Map ListData;
  DetailPeminjamanUser({Key? key, required this.ListData}) : super(key: key);

  @override
  State<DetailPeminjamanUser> createState() => _DetailPeminjamanUserState();
}

class _DetailPeminjamanUserState extends State<DetailPeminjamanUser> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id_peminjaman = TextEditingController();
  TextEditingController id_peminjam = TextEditingController();
  TextEditingController nama_barang = TextEditingController();
  TextEditingController tgl_pinjam = TextEditingController();
  TextEditingController tgl_kembali = TextEditingController();
  TextEditingController keperluan = TextEditingController();
  TextEditingController jml_brg = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController kode_barang = TextEditingController();
  TextEditingController id_login = TextEditingController();
  TextEditingController id_barang = TextEditingController();

  @override
  void initState() {
    super.initState();
    id_peminjaman.text = widget.ListData['id_peminjaman'];
    id_peminjam.text = widget.ListData['id_peminjam'];
    nama_barang.text = widget.ListData['nama_barang'];
    tgl_pinjam.text = widget.ListData['tgl_pinjam'];
    tgl_kembali.text = widget.ListData['tgl_kembali'];
    keperluan.text = widget.ListData['keperluan'];
    jml_brg.text = widget.ListData['jml_brg'];
    status.text = widget.ListData['status'];
    kode_barang.text = widget.ListData['kode_barang'];
    id_login.text = widget.ListData['id_login'];
    id_barang.text = widget.ListData['id_barang'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Peminjaman'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Card(
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text('ID Peminjaman'),
                    subtitle: Text(widget.ListData['id_peminjaman']),
                  ),
                  ListTile(
                    title: Text('ID Peminjam'),
                    subtitle: Text(widget.ListData['id_peminjam']),
                  ),
                  ListTile(
                    title: Text('ID Barang'),
                    subtitle: Text(widget.ListData['id_barang']),
                  ),
                  ListTile(
                    title: Text('Kode Barang'),
                    subtitle: Text(widget.ListData['kode_barang']),
                  ),
                  ListTile(
                    title: Text('Nama Barang'),
                    subtitle: Text(widget.ListData['nama_barang']),
                  ),
                  ListTile(
                    title: Text('Tanggal Pinjam'),
                    subtitle: Text(widget.ListData['tgl_pinjam']),
                  ),
                  ListTile(
                    title: Text('Tanggal Kembali'),
                    subtitle: Text(widget.ListData['tgl_kembali']),
                  ),
                  ListTile(
                    title: Text('Keperluan'),
                    subtitle: Text(widget.ListData['keperluan']),
                  ),
                  ListTile(
                    title: Text('Jumlah Pinjam'),
                    subtitle: Text(widget.ListData['jml_brg']),
                  ),
                  ListTile(
                    title: Text('Status'),
                    subtitle: Text(widget.ListData['status']),
                  ),
                  ListTile(
                    title: Text('ID Login'),
                    subtitle: Text(widget.ListData['id_login']),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
