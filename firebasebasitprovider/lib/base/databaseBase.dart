
import 'package:firebasebasitprovider/model/kisiler.dart';

abstract class DatabaseBase{
  Future<dynamic>kisileriYukle();
  Future<dynamic>aramaYap(String aramaKelimesi);
  Future<dynamic>silme(dynamic id);
  Future<dynamic>kaydet(Kisiler kisiler);
  Future<dynamic>guncelle(dynamic id,String yeniName,String yeniLastname);
}