import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../models/weather_model.dart';
import '../../service.dart/weather_service.dart';
import '../../utils/colors.dart';
import '../../widgets/drawer_header_widget/drawer.dart';
import '../questions_screen.dart/question_main_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CollectionReference<Map<String, dynamic>> _emergencyCollection;

  @override
  void initState() {
    super.initState();
    getWeatherData('İstanbul');
    Firebase.initializeApp().then((_) {
      _emergencyCollection =
          FirebaseFirestore.instance.collection('Acil Durum');
    });
  }

  void sendEmergencyMessage() {
    _emergencyCollection.add({
      'message': 'Acil Durum Mesajı',
      'timestamp': DateTime.now(),
      'Şehir': '',
    }).then((_) {
      print('Acil Durum Mesajı Gönderildi');
    }).catchError((error) {
      print('Acil Durum Mesajı Gönderilirken Hata Oluştu: $error');
    });
  }

  List<Color> buildBackGroundColorGradient(String weather) {
    if (weather.toLowerCase() == "snow") {
      return [niceWhite, niceDarkBlue];
    } else if (weather.toLowerCase() == "rain") {
      return [niceVeryDarkBlue, niceDarkBlue];
    } else {
      return [niceBlue, niceDarkBlue];
    }
  }

  Color buildTextColor(String weather) {
    if (weather.toLowerCase() == "snow") {
      return niceTextDarkBlue;
    } else if (weather.toLowerCase() == "rain") {
      return Colors.white;
    } else {
      return Colors.white;
    }
  }

  void getWeatherData(String cityData) {
    ApiService.getWeatherDataByCity(cityData).then((data) {
      Map resultBody = json.decode(data.body);
      if (resultBody['success'] == true) {
        setState(() {
          city = resultBody['city'];
          Iterable result = resultBody['result'];
          weatherList =
              result.map((watherData) => Weather(watherData)).toList();
        });
      }
    });
  }

  String buildWeatherListText(String day) {
    switch (day.toLowerCase()) {
      case "pazartesi":
        return "Pazartesi";
      case "salı":
        return "Salı           ";
      case "çarşamba":
        return "Çarşamba";
      case "perşembe":
        return "Perşembe";
      case "cuma":
        return "Cuma        ";
      case "cumartesi":
        return "Cumartesi   ";
      case "pazar":
        return "Pazar          ";
      default:
        return "?";
    }
  }

  String city = "";
  List<Weather> weatherList = [];

  @override
  Widget build(BuildContext context) {
    if (weatherList.isEmpty) {
      return Container(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.question_mark_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuestionsPage()),
              );
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 192, 129, 252),
                Color.fromARGB(255, 216, 101, 130),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_morning.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 217, 240),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade600,
                        offset: const Offset(2, 2),
                        blurRadius: 4,
                        spreadRadius: 2,
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                    right: 20,
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Image.asset(
                            'assets/images/siren.png',
                            height: 130,
                          ),
                          onTap: sendEmergencyMessage,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Acil Durum Mesajı Göndermek İçin Sirene Tıklayınız',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 242, 188, 220),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          offset: const Offset(2, 2),
                          blurRadius: 4,
                          spreadRadius: 2,
                        )
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  weatherList[0].day,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color:
                                        buildTextColor(weatherList[0].status),
                                  ),
                                ),
                                Text(
                                  weatherList[0].date,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color:
                                          buildTextColor(weatherList[0].status),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  color: buildTextColor(weatherList[0].status),
                                ),
                                Text(
                                  city.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color:
                                          buildTextColor(weatherList[0].status),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Image.network(weatherList[0].icon,
                          width: MediaQuery.of(context).size.width / 8),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "${double.parse(weatherList[0].degree).round().toString()}°C",
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w400,
                          color: buildTextColor(weatherList[0].status),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: weatherList.length - 1,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    buildWeatherListText(
                                        weatherList[index + 1].day),
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  Image.network(
                                    weatherList[index + 1].icon,
                                    height: 50,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${double.parse(weatherList[index + 1].min).round()}°",
                                        style: const TextStyle(
                                          fontSize: 22.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        "${double.parse(weatherList[index + 1].max).round()}°",
                                        style: const TextStyle(
                                          fontSize: 22.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              color: Colors.transparent,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const DrawerPage(),
    );
  }
}
