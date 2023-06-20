import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'models/family_member.dart';
import 'services/db_utils.dart';

DbUtils utils = DbUtils();

class FamilyProcess extends StatefulWidget {
  const FamilyProcess({Key? key}) : super(key: key);

  @override
  _FamilyProcessState createState() => _FamilyProcessState();
}

class _FamilyProcessState extends State<FamilyProcess> {
  TextEditingController familyIdController = TextEditingController();
  TextEditingController familyAdController = TextEditingController();
  TextEditingController familyYasController = TextEditingController();

  late Future<Database> database;

  List<FamilyInfo> familyList = [];

  _onPressedUpdate() async {
    final enik = FamilyInfo(
      id: int.parse(familyIdController.text),
      name: familyAdController.text,
      age: int.parse(familyYasController.text),
    );
    utils.updateFamilyMember(enik);
    familyList = await utils.members();
    //print(dogList);
    getData();
  }

  _onPressedAdd() async {
    final enik = FamilyInfo(
      id: int.parse(familyIdController.text),
      name: familyAdController.text,
      age: int.parse(familyYasController.text),
    );
    utils.insertFamilyMember(enik);
    familyList = await utils.members();
    //print(dogList);
    getData();
  }

  void getData() async {
    await utils.members().then((result) => {
          setState(() {
            familyList = result;
          })
        });
    print(familyList);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aile Üyesi Ekle"),
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
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                controller: familyIdController,
                decoration: InputDecoration(
                  hintText: 'TC Kimlik No',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('[a-zA-ZğĞüÜşŞıİöÖçÇ/s ]')),
                  LengthLimitingTextInputFormatter(30),
                ],
                controller: familyAdController,
                decoration: InputDecoration(
                  hintText: 'Ad Soyad',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                controller: familyYasController,
                decoration: InputDecoration(
                  hintText: 'Yaş',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: _onPressedAdd,
                        child: const Text("Üyeyi Ekle")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: _onPressedUpdate,
                        child: const Text("Üyeyi Güncelle")),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
