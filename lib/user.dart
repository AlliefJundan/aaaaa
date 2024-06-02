import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sas/pinjam.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User'),
        ),
        body: User());
  }
}

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  List _listdata = [];

  Future _getdata() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.88.90/projekSas/read3.php'));
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
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: _listdata
            .map((item) => Card(
                  child: ListTile(
                    title: Text(item['username']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Password : " + item['password']),
                        Text("Nama User : " + item['nama_user']),
                        Text("ID User : " + item['id_user']),
                        Text("Role : " + item['role']),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
