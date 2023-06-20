import "package:flutter/material.dart";
import '../family_process.dart';
import '../models/family_member.dart';
import '../services/db_utils.dart';

DbUtils utils = DbUtils();

class ListFamilyMembers extends StatefulWidget {
  @override
  _ListFamilyMembersState createState() => _ListFamilyMembersState();
}

class _ListFamilyMembersState extends State<ListFamilyMembers> {
  List<FamilyInfo> familyList = [];

  void getData() async {
    await utils.members().then((result) => {
          setState(() {
            familyList = result;
          })
        });
    print(familyList);
  }

  void showAlert(String alertTitle, String alertContent) {
    AlertDialog alertDialog;
    alertDialog =
        AlertDialog(title: Text(alertTitle), content: Text(alertContent));
    showDialog(context: context, builder: (_) => alertDialog);
  }

  _deleteFamilyMemberTable() {
    utils.deleteTable();
    familyList = [];
    getData();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Aile Üyesi Sayısı : " + familyList.length.toString()),
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
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 225, 245, 255),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          offset: const Offset(2, 2),
                          blurRadius: 4,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 5, left: 12, right: 12, bottom: 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ad Soyad',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  'TC No',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  'Yaş',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ]),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: familyList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(familyList[index].name),
                                  Text(familyList[index].id.toString()),
                                  Text(familyList[index].age.toString()),
                                ],
                              ),
                              onTap: () {
                                showAlert(
                                    "member " + index.toString() + " clicked",
                                    "member " + index.toString() + " clicked");
                              },
                              onLongPress: () async {
                                await utils
                                    .deleteFamilyMember(familyList[index].id)
                                    .then((value) => {
                                          showAlert(
                                              "member " +
                                                  index.toString() +
                                                  " deleted",
                                              "member " +
                                                  index.toString() +
                                                  " deleted")
                                        });
                                getData();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FamilyProcess()),
                              );
                            },
                            child: const Text("Aile Üyesi Ekle/Güncelle")),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: _deleteFamilyMemberTable,
                            child: const Text("Tüm Aile Üyelerini Sil")),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          getData();
                        },
                        child: const Text("Listeyi Yenile")),
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
