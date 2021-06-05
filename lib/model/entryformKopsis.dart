import 'package:flutter/material.dart';
import 'package:tugas_coba/FireDatabase/Database.dart';
import '../model/itemKopsis.dart';
import 'package:tugas_coba/dbhelper/dbhelper.dart';

class EntryForm extends StatefulWidget {
  final ItemKopsis itemkopsis;
  final String namakop;
  final int tanggalKop;
  final String id;
  final String docId;
  EntryForm(
      this.itemkopsis, this.namakop, this.tanggalKop, this.id, this.docId);
  @override
  EntryFormState createState() => EntryFormState(
      this.itemkopsis, this.namakop, this.tanggalKop, this.id, this.docId);
}

//class controller
class EntryFormState extends State<EntryForm> {
  ItemKopsis itemkopsis;
  String namakop;
  int tanggalKop;
  String id;
  String docId;
  EntryFormState(
      this.itemkopsis, this.namakop, this.tanggalKop, this.id, this.docId);
  TextEditingController namaKopsisController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  @override
  Widget build(BuildContext context) {
//kondisi
    if (namakop != null) {
      namaKopsisController.text = namakop;
      tanggalController.text = tanggalKop.toString();
    }
//rubah
    return Scaffold(
      appBar: AppBar(
        title: itemkopsis == null ? Text('Tambah') : Text('Edit'),
        leading: Icon(Icons.keyboard_arrow_left),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
// nama
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: namaKopsisController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nama Penjual Kopsis',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
//
                },
              ),
            ),
//tanggal
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: tanggalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Tanggal',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
//
                },
              ),
            ),
// tombol button
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                children: <Widget>[
// tombol simpan
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        if (namakop == null) {
// tambah data
                          DatabaseF.addKop(
                              i: id,
                              nama: namaKopsisController.text,
                              tanggal: int.parse(tanggalController.text));
                        } else {
// ubah data
                          DatabaseF.updateKop(
                              uid: id,
                              nama: namaKopsisController.text,
                              tanggal: int.parse(tanggalController.text),
                              docId: docId);
                        }
// kembali ke layar sebelumnya dengan membawa objek item
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
// tombol batal
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Cancel',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
