import 'package:firebasebasitprovider/base/databaseBase.dart';
import 'package:firebasebasitprovider/model/kisiler.dart';
import 'package:firebasebasitprovider/servis/base/database_servis.dart';
import 'package:firebasebasitprovider/servis/firestoreServis/firestore_servis.dart';
import 'package:firebasebasitprovider/servis/sqfliteServis/sqfLiteServis.dart';
import 'package:firebasebasitprovider/tools/locator.dart';

class DatabaseRepository implements DatabaseBase{

  final DatabaseServis _servis=locator<FirestoreServis>();

  @override
  Future<dynamic> kisileriYukle()async {
    return await _servis.kisileriYukle();
  }

  @override
  Future<dynamic>aramaYap(String aramaKelimesi)async {
    return await _servis.aramaYap(aramaKelimesi);
  }

  @override
  Future silme(id)async {
    return await _servis.silme(id);
  }

  @override
  Future<dynamic>kaydet(Kisiler kisiler)async {
    return await _servis.kaydet(kisiler);
  }

  @override
  Future guncelle(dynamic id,String yeniName, String yeniLastname)async {
    return await _servis.guncelle(id,yeniName, yeniLastname);
  }
}