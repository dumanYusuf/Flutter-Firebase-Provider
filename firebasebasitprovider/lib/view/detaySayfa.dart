import 'package:firebasebasitprovider/model/kisiler.dart';
import 'package:flutter/material.dart';

class DetaySayfa extends StatefulWidget {

  Kisiler kisiler;

  DetaySayfa({required this.kisiler});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("detay sayfa"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(widget.kisiler.name),
          Text(widget.kisiler.lastname),
          Text(widget.kisiler.no.toString()),
          Text(widget.kisiler.id.toString())
        ],
      ),
    );
  }
}
