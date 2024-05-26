import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sas/pinjam.dart';

void main() => runApp(const HomePage());

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String _title = 'Peminjaman';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  List _listdata = [];

  Future _getdata() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.88.95/projekSas/read.php'));
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
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peminjaman'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              icon: Text("Beranda"),
            ),
            Tab(
              icon: Text("Barang"),
            ),
            Tab(
              icon: Text("Peminjaman"),
            ),
            Tab(
              icon: Icon(Icons.brightness_5_sharp),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.amber,
                  width: double.infinity,
                  height: 48.0,
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.amber,
                  width: double.infinity,
                  height: 48.0,
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: _listdata
                  .map((item) => Card(
                        child: ListTile(
                          title: Text(item['nama_barang']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Kode Barang : " + item['kode_barang']),
                              Text("Merk Barang : " + item['merk']),
                              Text("Jenis Barang : " + item['jenis']),
                              Text("Jumlah : " + item['jumlah']),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Pinjam()),
                                  );
                                },
                                child: Text('Pinjam Barang'),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.amber,
                  width: double.infinity,
                  height: 60.0,
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.amber,
                  width: double.infinity,
                  height: 60.0,
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.amber,
                  width: double.infinity,
                  height: 60.0,
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.amber,
                  width: double.infinity,
                  height: 60.0,
                ),
              ],
            ),
          ),
          const Center(
            child: Text("tes"),
          ),
        ],
      ),
    );
  }
}
