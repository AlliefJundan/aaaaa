import 'package:flutter/material.dart';
import 'package:sas/barang.dart';
import 'package:sas/peminjaman.dart';
import 'package:sas/beranda.dart';

void main() => runApp(const Tes());

class Tes extends StatelessWidget {
  const Tes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const TabBarExample(),
    );
  }
}

class TabBarExample extends StatelessWidget {
  const TabBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar Sample'),
          bottom: const TabBar(
            tabs: <Widget>[
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
        body: const TabBarView(
          children: <Widget>[
            Beranda(),
            Barang(),
            Peminjaman(),
          ],
        ),
      ),
    );
  }
}
