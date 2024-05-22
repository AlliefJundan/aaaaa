import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const HomePage());

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String _title = 'Peminjaman';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;


  List _listdata = [];
  Future _getdata() async {
    try {
      final respone = await http.get(
        Uri.parse('http://10.5.7.165/projekSas/read2.php'));
        if (respone.statusCode==200) {
          print(respone.body);
          final data = jsonDecode(respone.body);
          setState(() {
            _listdata = data;
          });
        }
  } catch (e) {
    print(e);
  }
  }
  @override
  void initState() {
    _getdata();
    print(_listdata);
    super.initState();
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
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.amber,
                  width: double.infinity,
                  height: 48.0,
                  child: Text("Makan Enak Gak Pake Bayar"),
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
