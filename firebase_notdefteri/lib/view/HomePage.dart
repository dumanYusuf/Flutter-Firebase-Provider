import 'package:firebase_notdefteri/viewModel/HomePageViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Not Defteri"),
      actions: [
        Icon(Icons.note_alt,size: 40,)
      ],
      ),
      body: Consumer<HomePageViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              Padding(
                padding:  EdgeInsets.all(12.0),
                child: CupertinoSearchTextField(
                  controller:viewModel.aramaKontroller,
                  onChanged: (value){
                    viewModel.getSearch(value);
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: viewModel.notlar.length,
                    itemBuilder: (context, index) {
                      var oanakiNot = viewModel.notlar[index];
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          title: Text(oanakiNot.baslik),
                          subtitle: Text(oanakiNot.icerik),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(onPressed: (){
                                  print("silme consumer calıstı");
                                  viewModel.deleteNotes(oanakiNot.notId);
                                }, icon: Icon(Icons.delete)),
                                IconButton(onPressed: (){
                                  viewModel.updateNotes(context, oanakiNot.notId);
                                }, icon: Icon(Icons.edit))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child:const  Icon(Icons.add),
          onPressed: (){
            context.read<HomePageViewModel>().saveNotes(context);
            print("not kaydedildi");
          }),
    );
  }
}
