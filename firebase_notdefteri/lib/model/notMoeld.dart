class Notes {
  dynamic notId;
  String baslik;
  String icerik;

  Notes({this.notId, required this.baslik, required this.icerik});

  factory Notes.fromMap(Map<String, dynamic> map, {dynamic key}) {
    return Notes(
        notId: key ?? map["notId"],
        baslik: map["baslik"],
        icerik: map["icerik"]);
  }

  Map<String,dynamic>toMap({dynamic key}){
    return {
      'notId':key ?? notId,
      'baslik':baslik,
      'icerik':icerik
    };
  }
}
