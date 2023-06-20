import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_models.dart';

class UserService {
  String url = "https://api.orhanaydogdu.com.tr/deprem/live.php?limit=100";
  Future<Deprem?> get() async {
    //api den veri alma isteği
    var res = await http.get(Uri.parse(url)); //api den veri alma
    if (res.body.isNotEmpty) {
      var jsonBody = Deprem.fromJson(jsonDecode(res.body));
      return jsonBody;
    }
    return null;
  }
}
