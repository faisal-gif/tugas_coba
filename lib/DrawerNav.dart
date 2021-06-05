import 'package:flutter/material.dart';
import 'package:tugas_coba/model/home.dart';
import 'package:tugas_coba/model/homeKopsis.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerNav extends StatefulWidget {
  @override
   final user;
   DrawerNav(this.user);
  _DrawerNavState createState() => _DrawerNavState();
}
String uids;
class _DrawerNavState extends State<DrawerNav> {

  @override
  Widget build(BuildContext context) {
    User us = widget.user;
      uids = us.uid;
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: 
              Center(child:
              Text("                 DETA FEBBY ARIESTA"+ "\n" + "TUGAS AKHIR PEMROGRAMAN MOBILE"),
            ),
            ),
            ListTile(
              title: Text("Penjual Kopsis"),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeKopsis(uids))),
            ),
            ListTile(
              title: Text("Data Barang"),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Home(uids))),
            ),
          ],
        ),
      ),
    );
  }
}