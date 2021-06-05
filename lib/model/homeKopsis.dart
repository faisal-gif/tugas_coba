import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tugas_coba/FireDatabase/Database.dart';
import 'package:tugas_coba/model/entryformKopsis.dart';
import 'package:tugas_coba/dbhelper/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'itemKopsis.dart';
//pendukung program asinkron

class HomeKopsis extends StatefulWidget {
  @override
  final id;
  HomeKopsis(this.id);
  HomeKopsisState createState() => HomeKopsisState();
}

class HomeKopsisState extends State<HomeKopsis> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<ItemKopsis> itemKopsisList;

  @override
  Widget build(BuildContext context) {
    String id = widget.id;
 
  
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Nama Penjual Kopsis')),
      ),
      body: Column(children: [
        Expanded(
          child: fireList(id),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: Text("Tambah Nama"),
              onPressed: () async {
                var itemKopsis = await navigateToEntryForm(context, null,null,null,id,null);
                
              },
            ),
          ),
        ),
      ]),
    );
  }

  Future<ItemKopsis> navigateToEntryForm(
      BuildContext context,
      ItemKopsis itemkopsis,
      String namKop,
      int tanggalKop,
      String id,
      String docId) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(itemkopsis, namKop, tanggalKop, id, docId);
    }));
    return result;
  }
StreamBuilder fireList(String a) {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;

    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseF().readKop(a),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
              alignment: Alignment.center,
              child: Text('Loading',
                  style: TextStyle(fontWeight: FontWeight.bold)));
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              var noteInfo = snapshot.data.docs[index].data();
              String docID = snapshot.data.docs[index].id;
              String nama = noteInfo['nama'];
              int tanggalKop = noteInfo['tanggal'];
              
              return Card(
                color: Colors.white,
                elevation: 2.0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.ad_units),
                  ),
                  title: Text(
                    nama,
                    style: textStyle,
                  ),
                  subtitle: Text("Tanggal   : " +
                      tanggalKop.toString()),
                  trailing: GestureDetector(
                    child: Icon(Icons.delete),
                    onTap: () async {
//TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                      DatabaseF.deleteKop(docId: docID,uid: a);
                    },
                  ),
                  onTap: () async {
                    await navigateToEntryForm(context, null, nama, tanggalKop, a, docID);
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.ad_units),
            ),
            title: Text(
              this.itemKopsisList[index].namaKopsis,
              style: textStyle,
            ),
            subtitle: Text(
                "Tanggal : " + this.itemKopsisList[index].tanggal.toString()),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
//TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                dbHelper.deleteKopsis(this.itemKopsisList[index].id);
                updateListView();
              },
            ),
            onTap: () async {
              
            },
          ),
        );
      },
    );
  }

//update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
//TODO 1 Select data dari DB
      Future<List<ItemKopsis>> itemKopsisListFuture =
          dbHelper.getItemKopsisList();
      itemKopsisListFuture.then((itemKopsisList) {
        setState(() {
          this.itemKopsisList = itemKopsisList;
          this.count = itemKopsisList.length;
        });
      });
    });
  }
}
