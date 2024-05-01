
import 'package:firebasebasitprovider/model/kisiler.dart';
import 'package:firebasebasitprovider/repo/database_repository.dart';
import 'package:firebasebasitprovider/tools/locator.dart';
import 'package:firebasebasitprovider/view/detaySayfa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnaSayfaViewModel with ChangeNotifier{

  TextEditingController _controller=TextEditingController();
  TextEditingController get controller => _controller;

  TextEditingController _nameControler=TextEditingController();
  TextEditingController get nameControler => _nameControler;

  TextEditingController _lastnameControler=TextEditingController();
  TextEditingController get lastnameControler => _lastnameControler;

  final servis =locator<DatabaseRepository>();


  late Stream<List<Kisiler>>? _stream;

  List<Kisiler>_kisiler=[];

  List<Kisiler> get kisiler => _kisiler;


  AnaSayfaViewModel(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {kisileriYukle();});
  }

  void kisileriYukle() async {
    try {
      _stream =  await servis.kisileriYukle();
      _stream!.listen((event) {
        _kisiler = event;
        notifyListeners();
      });
    } catch (e) {
      print("Kişiler yüklenirken hata oluştu: $e");
    }
   /*_kisiler=await servis.kisileriYukle();
    notifyListeners();*/ // burdaki kod sqflitedaki verileri yukliyor Stream dinlemediğimiz için bu keil yapmamız lazım
  }

void aramaYap(String aramaKelimesi)async{
    try{
      _kisiler=await servis.aramaYap(aramaKelimesi);
      notifyListeners();
    }
    catch(e){
      print("hata olustu");
    }
}

void silmeYap(dynamic id)async{
    try{
      await servis.silme(id);
      _kisiler.removeWhere((element) => element.id==id);//burdaki kod silinen kisiyi listedende siler
    // notifyListeners();ekrana direk yansısın diye Sqflite da yapıyurz
    }
    catch(e){
      print("silme işleminde hata olustu");
    }
}

void KisiKaydet(BuildContext context)async{
    List<dynamic>? sonuc=await buildPencereAc(context);
    if(sonuc!= null && sonuc.length>1){
      String name=sonuc[0];
      String lastname=sonuc[1];

       Kisiler yeniKisi=Kisiler(id: 0, name: name, lastname: lastname);
      await servis.kaydet(yeniKisi);
       notifyListeners();
    }
}

void kisiGuncelle(BuildContext context,dynamic id)async{
    List<dynamic>? guncelSonuc=await buildGuncellePencereAc(context);
    if(guncelSonuc!=null && guncelSonuc.length>1){
      String yeniName=guncelSonuc[0];
      String yeniLastname=guncelSonuc[1];

      await servis.guncelle(id, yeniName, yeniLastname);
      notifyListeners();
    }
    else{
      print("kişi guncellenemdi");
    }
}



  Future<List<String>?> buildPencereAc(BuildContext context) async {
    _nameControler.clear();
    _lastnameControler.clear();
    return showDialog<List<String>?>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Baslik"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameControler,
                  decoration:const   InputDecoration(
                    labelText: "Adınızı girin",
                    hintText: "Adınız...",
                  ),
                ),
                TextFormField(
                  controller: _lastnameControler,
                  decoration:const InputDecoration(
                    labelText: "Soyadınızı girin",
                    hintText: "Soyadınız...",
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Vazgeç"),
                    ),
                    SizedBox(width: 10),
                         ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context,[nameControler.text,lastnameControler.text]);
                          },
                          child: Text("Kaydet"),

                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<List<String>?> buildGuncellePencereAc(BuildContext context) async {
    return showDialog<List<String>?>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Guncelle"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameControler,
                ),
                TextFormField(
                  controller: _lastnameControler,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Vazgeç"),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context,[nameControler.text,lastnameControler.text]);
                      },
                      child: Text("Guncelle"),

                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  void detaySayfaAc(BuildContext context,Kisiler kisiler){
    MaterialPageRoute pageRoute=MaterialPageRoute(builder: (context){
      return ChangeNotifierProvider<AnaSayfaViewModel>(create: (context)=>AnaSayfaViewModel(),
      child: DetaySayfa(kisiler: kisiler,));
    });
    Navigator.push(context, pageRoute);
  }
}