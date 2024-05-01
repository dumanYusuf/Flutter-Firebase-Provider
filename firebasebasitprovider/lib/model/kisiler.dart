
class Kisiler {
  dynamic id;
  String lastname;
  String name;
  int?  no;

  Kisiler({
    required this.id,
    required this.name,
    required this.lastname,
      this.no ,
  });

  factory Kisiler.fromjson(Map<dynamic, dynamic> json, String key) {
    return Kisiler(
      id: key,
      name: json["name"],
      lastname: json["lastname"],
      no: json["no"],
    );
  }

  Map<String, dynamic> toMap({dynamic key, dynamic no}) {
    return {
      'id': key ?? id,
      'name': name,
      'lastname': lastname,
      'no': no ?? 1,
    };
  }
}
