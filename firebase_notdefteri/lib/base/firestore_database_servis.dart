import 'package:firebase_notdefteri/model/notMoeld.dart';

abstract class DatabaseBase{

  Future<dynamic>getNotes();
  Future<dynamic>searchNotes(String aramaKelimesi);
  Future<dynamic>saveNotes(Notes notes);
  Future<dynamic>deleteNotes(dynamic id);
  Future<dynamic>updateNotes(dynamic id,String yeniBaslik,String yeniIcerik);
}