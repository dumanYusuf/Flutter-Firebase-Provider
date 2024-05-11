import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_notdefteri/model/notMoeld.dart';
import 'package:firebase_notdefteri/servis/base/databaseServis.dart';
import 'package:flutter/cupertino.dart';

class FirestoreServis extends DatabaseServis{

  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  @override
  Future getNotes()async{
    List<Notes> _notlar = [];
    try {
      return _firestore.collection("Note").snapshots().map(
              (snapshots) =>
              snapshots.docs
                  .map((e) => Notes.fromMap(e.data())).toList());
    } catch (e) {
      print("hata olustu");
    }
    return _notlar;

  }

  @override
  Future<List<Notes>> searchNotes(String aramaKelimesi) async {
    List<Notes> _arananNotlar = [];
    try {
      var snapshot = await _firestore.collection("Note").get();
      List<Notes> _arananNot = snapshot.docs.map((doc) => Notes.fromMap(doc.data())).toList();

      for(var ara in _arananNot){
         if(ara.baslik.toLowerCase().contains(aramaKelimesi.toLowerCase())){
           _arananNotlar.add(ara);
         }
      }
    } catch (e) {
      print("arama servisde hata cıktı $e");
      throw e;
    }
    return _arananNotlar;
  }

  @override
  Future saveNotes(Notes notes) async {
    try {
      dynamic notIdAl = _firestore.collection("Note").doc().id;
      await _firestore.collection("Note").add(notes.toMap(key: notIdAl));
    } catch (e) {
      print("Kaydetme işleminde bir hata oluştu: $e");
    }
  }


  @override
  Future deleteNotes(id) async{
    try{
     await _firestore.collection("Note").doc(id).delete();

    }
    catch(e){
      print("silme işleminde bir hata olustu");
    }
  }

  @override
  Future updateNotes(id, String yeniBaslik, String yeniIcerik) async{
    try{
      await _firestore.collection("Note").doc(id).set({
        'baslik':yeniBaslik,
        'icerik':yeniIcerik
      },SetOptions(merge: true));
    }
    catch(e){
      print("hata olustu $e");
    }
  }

}