import 'package:cloud_firestore/cloud_firestore.dart';
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('notes');

class DatabaseF {
  static String userUid;
  static Future<void> addItem({
    String i,
    String nama_pem,
    String nama_bar,
    int price,
    int stock,
    int kode
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(i).collection('barang').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "name_pem": nama_pem,
      "nama_bar": nama_bar,
      "price": price,
      "stock": price,
      "kode": kode
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    String uid,
     String nama_pem,
    String nama_bar,
    int price,
    int stock,
    int kode,
    String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(uid).collection('barang').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "name_pem": nama_pem,
      "nama_bar": nama_bar,
      "price": price,
      "stock": price,
      "kode": kode
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  Stream<QuerySnapshot> readItems(
    String uid
  ) {
    CollectionReference notesItemCollection =
        _mainCollection.doc(uid).collection('barang');

    return notesItemCollection.snapshots();
  }

  static Future<void> deleteItem({
    String uid,
    String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(uid).collection('barang').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }

   static Future<void> addKop({
    String i,
    String nama,
    int tanggal,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(i).collection('penjual').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "nama": nama,
      "tanggal": tanggal,
      
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

static Future<void> updateKop({
    String uid,
    String nama,
    int tanggal,
    String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(uid).collection('penjual').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
       "nama": nama,
      "tanggal": tanggal,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }
  Stream<QuerySnapshot> readKop(
    String uid
  ) {
    CollectionReference notesItemCollection =
        _mainCollection.doc(uid).collection('penjual');

    return notesItemCollection.snapshots();
  }
   static Future<void> deleteKop({
    String uid,
    String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(uid).collection('penjual').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }

}
