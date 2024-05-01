
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasebasitprovider/model/kisiler.dart';
import 'package:firebasebasitprovider/servis/base/database_servis.dart';

class FirestoreServis implements DatabaseServis{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<dynamic>kisileriYukle() async {
    List<Kisiler> kisilerim = [];
    try {
      return _firestore.collection("rehber").snapshots().map(
              (snapshots) => snapshots.docs
              .map((e) => Kisiler.fromjson( e.data(),  e.id))
              .toList());

    } catch (e) {
      print("hata olustu");
    }
    return kisilerim ;
  }


  @override
  Future<dynamic>aramaYap(String aramaKelimesi) async {
    List<Kisiler>aranandegerler=[];
    try {
      QuerySnapshot snapshot = await _firestore
          .collection("rehber")
          .get();

      List<Kisiler> aramaSonucu = snapshot.docs.map((doc) =>
          Kisiler.fromjson(doc.data() as Map<String, dynamic>, doc.id)).toList();

      for(var elemnet in aramaSonucu){
        if(elemnet.name.toLowerCase().contains(aramaKelimesi.toLowerCase())){
          aranandegerler.add(elemnet);
        }
      }
      return aranandegerler;
    } catch (e) {
      print("Arama yapılırken hata oluştu: $e");
      return [];
    }
  }

  @override
  Future silme(id) async{
    try{
      await _firestore.collection("rehber").doc(id).delete();
    }
    catch(e){
      print("silme işleminde bir hata olustu");
    }
  }

  @override
  Future kaydet(Kisiler kisiler) async {
    try {
      dynamic kisiId = _firestore.collection("rehber").doc().id;
      await _firestore.collection("rehber").add(kisiler.toMap(key: kisiId));
    } catch (e) {
      print("Kaydetme işleminde bir hata oluştu: $e");
    }
  }

  @override
  Future guncelle(id, String yeniName, String yeniLastname) async{
    try{
      await _firestore.collection("rehber").doc(id).set({
        'name':yeniName,
        'lastname':yeniLastname
      },SetOptions(merge: true));
    }
    catch(e){
      print("hata olustu $e");
    }
  }
  }

