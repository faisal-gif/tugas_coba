import 'package:flutter/material.dart';
import '../model/item.dart';
import 'package:tugas_coba/FireDatabase/Database.dart';

class EntryForm extends StatefulWidget {
  final Item item;
  final String nama_pem;
  final String nama_bar;
  final int price;
  final int stock;
  final int kode;
  final String id;
  final String docId;
  EntryForm(this.item, this.nama_pem, this.nama_bar, this.price, this.stock,
      this.kode, this.id, this.docId);
  @override
  EntryFormState createState() => EntryFormState(this.item, this.nama_pem,
      this.nama_bar, this.price, this.stock, this.kode, this.id, this.docId);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Item item;
  String nama_pem;
  String nama_bar;
  int price;
  int stock;
  int kode;
  String id;
  String docId;
  EntryFormState(this.item, this.nama_pem, this.nama_bar, this.price,
      this.stock, this.kode, this.id, this.docId);
  TextEditingController namaController = TextEditingController();
  TextEditingController namaBarangController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stokController = TextEditingController();
  TextEditingController kodeBarangController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  @override
  Widget build(BuildContext context) {
//kondisi
    if (nama_bar != null) {
      namaController.text = nama_pem;
      namaBarangController.text = nama_bar;
      priceController.text = price.toString();
      stokController.text = stock.toString();
      kodeBarangController.text = kode.toString();

      // tanggalController.text = item.tanggal;
    }
//rubah
    return Scaffold(
      appBar: AppBar(
        title: item == null ? Text('Tambah') : Text('Edit'),
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
                controller: namaController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nama Pembeli',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
//
                },
              ),
            ),
// nama barang
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: namaBarangController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nama Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
//
                },
              ),
            ),
// harga
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Harga',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  //
                },
              ),
            ),
// stok
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: stokController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Stok',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  //
                },
              ),
            ),
// kode barang
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: kodeBarangController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Kode Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
//
                },
              ),
            ),

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
                        if (nama_pem == null) {
// tambah data
                          DatabaseF.addItem(
                              i: id,
                              nama_pem: namaController.text,
                              nama_bar: namaBarangController.text,
                              price: int.parse(priceController.text),
                              stock: int.parse(stokController.text),
                              kode: int.parse(kodeBarangController.text));
                          // tanggalController.text);
                        } else {
// ubah data
                          DatabaseF.updateItem(
                              uid: id,
                              nama_pem: namaController.text,
                              nama_bar: namaBarangController.text,
                              price: int.parse(priceController.text),
                              stock: int.parse(stokController.text),
                              kode: int.parse(kodeBarangController.text),
                              docId: docId);
                          // item.tanggal = tanggalController.text;
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
