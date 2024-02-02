class Criminal{
  String? name;
  String? image;
  String? crimeHistory;
  String? place;
  String? date;
  String? time;

  Criminal({this.name, this.image, this.crimeHistory, this.place, this.date, this.time});

  Criminal.fromJson(Map<String, dynamic> json){
    name = json['name'];
    image = json['image'];
    crimeHistory = json['crimeHistory'];
    place = json['place'];
    date = json['date'];
    time = json['time'];
  }

 Map<String, dynamic> toJson(){
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = name;
  data['image'] = image;
  data['crimeHistory'] = crimeHistory;
  data['place'] = place;
  data['date'] = date;
  data['time'] = time;
  return data;
 }
}