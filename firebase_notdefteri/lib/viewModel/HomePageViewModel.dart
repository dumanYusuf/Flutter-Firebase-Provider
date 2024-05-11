import 'package:firebase_notdefteri/model/notMoeld.dart';
import 'package:firebase_notdefteri/repo/databaseRepo.dart';
import 'package:firebase_notdefteri/tools/locator.dart';
import 'package:flutter/material.dart';

class HomePageViewModel with ChangeNotifier{

  final _servis=locator<DatabaseRepository>();

  TextEditingController _aramaKontroller=TextEditingController();
  TextEditingController get aramaKontroller => _aramaKontroller;

  TextEditingController _baslikControler=TextEditingController();
  TextEditingController get baslikControler => _baslikControler;
  TextEditingController _icerikController=TextEditingController();
  TextEditingController get icerikController => _icerikController;


  Stream<List<Notes>>? _stream;

  List<Notes>_notlar=[];
  List<Notes> get notlar => _notlar;

  HomePageViewModel(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getNotes();
    });
  }

  void getNotes()async{
    try{
      _stream= await _servis.getNotes();
      _stream!.listen((event) {
         _notlar=event;
         notifyListeners();
      });
    }
    catch(e){
      print("viewModelda hata cıktı $e");
    }
  }

  void getSearch(String aramaKelimesi)async{
    try{
      _notlar=await _servis.searchNotes(aramaKelimesi);
      notifyListeners();
    }
    catch(e){
      print("hata cıktı viewModelda arama işleminde $e");
    }
  }

  void deleteNotes(dynamic id)async{
    try{
      await _servis.deleteNotes(id);
      _notlar.removeWhere((element) => element.notId==id);
      print("silme viewModel calıstı");
    }
    catch(e){
      print("silme işleminde hata olustu");
    }
  }


  void saveNotes(BuildContext context)async{
   var  sonuc=await _builddPencereAc(context);
   if(sonuc!= null && sonuc.length>1){
     String baslik=sonuc[0];
     String icerik=sonuc[1];

     Notes notes=Notes(baslik: baslik, icerik: icerik);
     await _servis.saveNotes(notes);
     notifyListeners();
   }
  }


  void updateNotes(BuildContext context ,dynamic id)async{
    var guncelSonuc= await _builddPencereGuncelle(context);
    if(guncelSonuc != null && guncelSonuc.length>1){
      String guncelBaslik=guncelSonuc[0];
      String guncelIcerik=guncelSonuc[1];

      await _servis.updateNotes(id, guncelBaslik, guncelIcerik);
      notifyListeners();
    }
  }


  Future<List<String>?> _builddPencereAc(BuildContext context)async{
    _baslikControler.clear();
    icerikController.clear();
    return showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) {
           return AlertDialog(
             title: Text("Not Ekle"),
             content: SingleChildScrollView(
               child: Column(
                 children: [
                   TextFormField(
                     controller: _baslikControler,
                     decoration:const  InputDecoration(
                       labelText: "Baslık giriniz",
                       hintText: "Başlık..."
                     ),
                   ),
                   TextFormField(
                     controller: _icerikController,
                     decoration:const  InputDecoration(
                         labelText: "İçeriği Giriniz",
                         hintText: "Notunuz..."
                     ),
                   ),
                  const SizedBox(height:10 ,),
                   Row(
                     children: [
                       ElevatedButton(onPressed: (){
                         Navigator.pop(context);
                       }, child: Text("Vazgec")),
                       ElevatedButton(onPressed: (){
                          Navigator.pop(context,[_baslikControler.text,_icerikController.text]);
                       }, child: Text("Kaydet"))
                     ],
                   )
                 ],
               ),
             ),
           );
        });
  }
  Future<List<String>?> _builddPencereGuncelle(BuildContext context)async{
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Not Güncelle"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _baslikControler,
                    decoration:const  InputDecoration(
                        labelText: "Baslık guncelle",
                        hintText: "Başlık..."
                    ),
                  ),
                  TextFormField(
                    controller: _icerikController,
                    decoration:const  InputDecoration(
                        labelText: "İçeriği guncelle",
                        hintText: "Notunuz..."
                    ),
                  ),
                  const SizedBox(height:10 ,),
                  Row(
                    children: [
                      ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text("Vazgec")),
                      ElevatedButton(onPressed: (){
                        Navigator.pop(context,[_baslikControler.text,_icerikController.text]);
                      }, child: Text("Kaydet"))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

}