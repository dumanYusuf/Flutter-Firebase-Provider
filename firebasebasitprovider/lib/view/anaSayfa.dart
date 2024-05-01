import 'package:firebasebasitprovider/viewModel/anaSayfaViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

  @override
  Widget build(BuildContext context) {
    print("anasayfa calıstı");
    return Scaffold(
      appBar: AppBar(
        title: Consumer<AnaSayfaViewModel>(
          builder: (context, viewModel, child) => CupertinoSearchTextField(
            controller: viewModel.controller,
            onChanged: (value) {
              viewModel.aramaYap(value);
              print("arama consumer calıstı");
            },
          ),
        ),
      ),

      body: Consumer<AnaSayfaViewModel>(builder: (context,viewModel,child){
        print("body consumer calıstı");
             return Card(
               elevation: 3,
               child: ListView.builder(
                 itemCount: viewModel.kisiler.length,
                   itemBuilder:(context, index){
                       var oankideger=viewModel.kisiler[index];
                       return InkWell(
                         onTap: (){
                           viewModel.detaySayfaAc(context,oankideger);
                         },
                         child: ListTile(
                           title: Text(oankideger.name),
                           subtitle: Text(oankideger.lastname),
                           trailing: SizedBox(
                             width: 100,
                             child: Row(
                               children: [
                                Consumer<AnaSayfaViewModel>(builder: (context,viewModel,child)=>IconButton(
                                    onPressed: (){
                                      viewModel.silmeYap(oankideger.id);
                                      print("silme consumer calıstı");
                                    },
                                    icon:const Icon(Icons.delete))
                                ),
                                 IconButton(onPressed: (){
                                   viewModel.kisiGuncelle(context, oankideger.id);
                                   print("guncelle viewModel calıstı");
                                 }, icon: Icon(Icons.edit)),
                               ],
                             ),
                           ),
                         ),
                       );
                   }),
             );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
          onPressed: (){
             context.read<AnaSayfaViewModel>().KisiKaydet(context);
             print("kisi ekle consumer calıstı");
          }
      ),
    );
  }

}
