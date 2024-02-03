import 'dart:convert';
import 'dart:typed_data';

class Criminal {
  String? name;
  Uint8List? image;
  String? crimeHistory;
  String? place;
  String? date;
  String? time;

  Criminal(
      {this.name,
      this.image,
      this.crimeHistory,
      this.place,
      this.date,
      this.time});

  Criminal.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    image = base64Decode(json['Image']);
    crimeHistory = json['Crime_History'];
    place = json['Place'];
    date = json['Date'].toString().substring(0, 10);
    time = json['Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (image != null) {
      data['image'] = base64.encode(image!); // Encode image data to base64
    }
    data['crimeHistory'] = crimeHistory;
    data['place'] = place;
    data['date'] = date;
    data['time'] = time;
    return data;
  }
}
