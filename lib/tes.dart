import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Tes extends StatefulWidget {
  Tes({Key? key}) : super(key: key);

  @override
  State<Tes> createState() => _TesState();
}
class _TesState extends State<Tes> {
  List _listdata = [];
  Future _getdata() async {
    try {
  final response = await http.get(Uri.parse('http://10.5.7.165/projekSas/read2.php'));
  if (response.statusCode == 200) {
    print(response.body);
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
    _getdata();
    print(_listdata);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tes"),
      ),
      body: Text('Body'),
    );
  }
}