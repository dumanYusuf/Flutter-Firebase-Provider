import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_notdefteri/base/firestore_database_servis.dart';
import 'package:firebase_notdefteri/model/notMoeld.dart';
import 'package:firebase_notdefteri/servis/base/databaseServis.dart';
import 'package:firebase_notdefteri/servis/firestoreServis.dart';
import 'package:firebase_notdefteri/tools/locator.dart';

class DatabaseRepository extends DatabaseBase{

final DatabaseServis _servis=locator<FirestoreServis>();

  @override
  Future getNotes() async{
    return await _servis.getNotes();
  }

  @override
  Future searchNotes(String aramaKelimesi) async{
    return await _servis.searchNotes(aramaKelimesi);
  }

  @override
  Future saveNotes(Notes notes) async {
    return await _servis.saveNotes(notes);
  }

  @override
  Future deleteNotes(id)async {
    return await _servis.deleteNotes(id);
  }

  @override
  Future updateNotes(id, String yeniBaslik, String yeniIcerik)async {
    return await _servis.updateNotes(id, yeniBaslik, yeniIcerik);
  }
}