import 'package:flutter/material.dart';
import 'package:sas/barangUser.dart';
import 'package:sas/peminjamanUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/cupertino.dart';
import 'package:sas/login.dart';

class BerandaUser extends StatefulWidget {
  final String username;
  final String idUser;

  const BerandaUser({
    Key? key,
    required this.username,
    required this.idUser,
  }) : super(key: key);

  @override
  _BerandaUserState createState() => _BerandaUserState();
}

class _BerandaUserState extends State<BerandaUser> {
  String? username;
  String? idUser;
  bool isLoggedIn = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = widget.username;
      idUser = widget.idUser;
      isLoggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !isLoggedIn, // Nonaktifkan tombol kembali jika sudah login
      child: Scaffold(
        appBar: AppBar(
          title: Text('Beranda'),
          actions: [
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginForm()),
                );
              },
              child: Text('Log Out'),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50))),
              child: Column(
                children: [
                  const SizedBox(height: 0),
                  ListTile(
                    title: Text(
                        'Username : $username', // Menggunakan username sebagai title
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.white)),
                    subtitle: Text(
                        'ID User: $idUser', // Menggunakan idUser sebagai subtitle
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).primaryColor,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(100))),
                  child: Column(
                    children: [
                      Spacer(flex: 2),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 40,
                        mainAxisSpacing: 30,
                        children: [
                          itemDashboard(
                              context,
                              'Barang',
                              CupertinoIcons.cube_box_fill,
                              Colors.deepOrangeAccent,
                              BarangUserPage()),
                          itemDashboard(
                              context,
                              'Peminjaman',
                              CupertinoIcons.table,
                              Colors.deepOrangeAccent,
                              PeminjamanUserPage()),
                        ],
                      ),
                      Spacer(flex: 3),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemDashboard(BuildContext context, String title, IconData iconData,
      Color background, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 5)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(color: background, shape: BoxShape.circle),
              child: Icon(
                iconData,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ),
    );
  }
}
