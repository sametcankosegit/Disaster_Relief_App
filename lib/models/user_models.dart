class DepremResult {
  double? mag; //depremin büyüklüğünü temsil eden bir ondalık sayı
  double? lng; //depremin boylamını temsil eden bir ondalık sayı
  double? lat; //depremin enlemini temsil eden bir ondalık sayı
  String? lokasyon; //depremin konumunu temsil eden bir metin
  double? depth; //depremin derinliğini temsil eden bir ondalık sayı
  List<double?>?
      coordinates; //depremin koordinatlarını temsil eden bir ondalık sayı listesi
  String? title; //deprem başlığını temsil eden bir metin
  String? rev; //bir dizi kodlama revizyonunu temsil eden bir metin
  int? timestamp; //bir zaman damgasını temsil eden bir tamsayı
  String? dateStamp; //bir tarih damgasını temsil eden bir metin
  String? date; //bir tarihi temsil eden bir metin
  String? hash; //bir karma değerini temsil eden bir metin
  String? hash2; //bir ikinci karma değerini temsil eden bir metin

  DepremResult({
    this.mag,
    this.lng,
    this.lat,
    this.lokasyon,
    this.depth,
    this.coordinates,
    this.title,
    this.rev,
    this.timestamp,
    this.dateStamp,
    this.date,
    this.hash,
    this.hash2,
  });
  DepremResult.fromJson(Map<String, dynamic> json) {
    mag = json['mag']?.toDouble();
    lng = json['lng']?.toDouble();
    lat = json['lat']?.toDouble();
    lokasyon = json['lokasyon']?.toString();
    depth = json['depth']?.toDouble();
    if (json['coordinates'] != null) {
      final v = json['coordinates'];
      final arr0 = <double>[];
      v.forEach((v) {
        arr0.add(v.toDouble());
      });
      coordinates = arr0;
    }
    title = json['title']?.toString();
    rev = json['rev']?.toString();
    timestamp = json['timestamp']?.toInt();
    dateStamp = json['date_stamp']?.toString();
    date = json['date']?.toString();
    hash = json['hash']?.toString();
    hash2 = json['hash2']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mag'] = mag;
    data['lng'] = lng;
    data['lat'] = lat;
    data['lokasyon'] = lokasyon;
    data['depth'] = depth;
    if (coordinates != null) {
      final v = coordinates;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['coordinates'] = arr0;
    }
    data['title'] = title;
    data['rev'] = rev;
    data['timestamp'] = timestamp;
    data['date_stamp'] = dateStamp;
    data['date'] = date;
    data['hash'] = hash;
    data['hash2'] = hash2;
    return data;
  }
}

class Deprem {
  bool? status;
  int? tryed;
  int? serverloadms;
  String? desc;
  List<DepremResult?>? result;

  Deprem({
    this.status,
    this.tryed,
    this.serverloadms,
    this.desc,
    this.result,
  });
  Deprem.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    tryed = json['tryed']?.toInt();
    serverloadms = json['serverloadms']?.toInt();
    desc = json['desc']?.toString();
    if (json['result'] != null) {
      final v = json['result'];
      final arr0 = <DepremResult>[];
      v.forEach((v) {
        arr0.add(DepremResult.fromJson(v));
      });
      result = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['tryed'] = tryed;
    data['serverloadms'] = serverloadms;
    data['desc'] = desc;
    if (result != null) {
      final v = result;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['result'] = arr0;
    }
    return data;
  }
}
