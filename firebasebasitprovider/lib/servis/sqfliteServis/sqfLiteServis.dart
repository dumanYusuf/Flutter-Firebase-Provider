import 'package:firebasebasitprovider/model/kisiler.dart';
import 'package:firebasebasitprovider/servis/base/database_servis.dart';
import 'package:firebasebasitprovider/servis/sqfliteServis/data_helper.dart';


class SqfLiteServis implements DatabaseServis{

  @override
  Future aramaYap(String aramaKelimesi) async{
    var db=await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>>maps=await db.rawQuery("SELECT*FROM ogrenciler WHERE name like'%$aramaKelimesi%'");
    return List.generate(maps.length, (index) {
      var satir=maps[index];
      return Kisiler(id:satir["id"], name:satir["name"], lastname: satir["lastname"]);
    });
  }

  @override
  Future guncelle(id, String yeniName, String yeniLastname)async {
    var db=await VeritabaniYardimcisi.veritabaniErisim();
    var gunceleKisi=Map<String,dynamic>();
    gunceleKisi["name"]=yeniName;
    gunceleKisi["lastname"]=yeniLastname;

    await db.update("ogrenciler", gunceleKisi,where: "id=?",whereArgs: [id]);
  }

  @override
  Future kaydet(Kisiler kisiler)async {
    var db=await VeritabaniYardimcisi.veritabaniErisim();
    var yeniKisi=Map<String,dynamic>();
    yeniKisi["name"]=kisiler.name;
    yeniKisi["lastname"]=kisiler.lastname;

    await db.insert("ogrenciler", yeniKisi);

  }

  @override
  Future kisileriYukle() async{
    var db=await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>>maps=await db.rawQuery("SELECT*FROM ogrenciler");

    return List.generate(maps.length, (index){
      var satir=maps[index];
      return Kisiler(id:satir["id"],name: satir["name"], lastname: satir["lastname"]);
    });
  }

  @override
  Future silme(id) async{
    var db=await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("ogrenciler",where: "id=?",whereArgs: [id]);
  }
}