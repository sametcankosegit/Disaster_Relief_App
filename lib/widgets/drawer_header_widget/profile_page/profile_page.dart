import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _usersCollection;
  late String userId;
  String name = '';
  String email = '';
  String phone = '';
  String dob = '';
  String address = '';
  String city = '';
  String state = '';

  @override
  void initState() {
    super.initState();
    _usersCollection = _firestore.collection('users_info');
    loadUserProfile();
  }

  Future<void> saveUserProfile() async {
    try {
      await _usersCollection.doc(userId).set({
        'ad': name,
        'email': email,
        'telefon': phone,
        'dob': dob,
        'adres': address,
        'ilce': city,
        'sehir': state,
      });
    } catch (error) {
      print('Kaydedilirken Hata Oluştu: $error');
    }
  }

  Future<void> loadUserProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        userId = user.uid;
        DocumentSnapshot snapshot = await _usersCollection.doc(userId).get();
        if (snapshot.exists) {
          Map<String, dynamic> userData =
              snapshot.data() as Map<String, dynamic>;
          setState(() {
            name = userData['ad'] ?? '';
            email = userData['email'] ?? '';
            phone = userData['telefon'] ?? '';
            dob = userData['dob'] ?? '';
            address = userData['adres'] ?? '';
            city = userData['ilce'] ?? '';
            state = userData['sehir'] ?? '';
          });
        }
      }
    } catch (error) {
      print('Failed to load user profile: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PROFİL',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
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
                        )
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      CircleAvatar(
                        radius: 64,
                        child: Container(
                          width: 120,
                          height: 120,
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/avatar.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        name,
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        leading: const Icon(
                          Icons.email,
                          size: 25,
                          color: Colors.black,
                        ),
                        title: Text(
                          email,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.phone,
                          size: 25,
                          color: Colors.black,
                        ),
                        title: Text(
                          phone,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.date_range,
                          size: 25,
                          color: Colors.black,
                        ),
                        title: Text(
                          dob,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 110.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _showEditProfileDialog();
                          },
                          child: const Text('Profili Düzenle'),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Title(
                          color: Colors.black,
                          child: const Text(
                            'Adres Bilgisi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.location_city,
                            size: 25,
                            color: Colors.black,
                          ),
                          title: Text(
                            address,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.map,
                            size: 25,
                            color: Colors.black,
                          ),
                          title: Row(
                            children: [
                              Text(
                                '$city / $state',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _showEditAddressDialog();
                            },
                            child: const Text('Adresi Düzenle'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showEditProfileDialog() async {
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController emailController = TextEditingController(text: email);
    TextEditingController phoneController = TextEditingController(text: phone);
    TextEditingController dobController = TextEditingController(text: dob);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Profili Düzenle'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Ad Soyad'),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'E-posta'),
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Telefon'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                    PhoneNumberFormatter(),
                  ],
                ),
                TextFormField(
                  controller: dobController,
                  decoration: const InputDecoration(labelText: 'Doğum Tarihi'),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                    DateOfBirthFormatter(),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Kaydet'),
              onPressed: () {
                setState(() {
                  name = nameController.text;
                  email = emailController.text;
                  phone = phoneController.text;
                  dob = dobController.text;
                });
                saveUserProfile();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditAddressDialog() async {
    TextEditingController addressController =
        TextEditingController(text: address);
    TextEditingController cityController = TextEditingController(text: city);
    TextEditingController stateController = TextEditingController(text: state);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adresi Düzenle'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Adres'),
                ),
                TextFormField(
                  controller: cityController,
                  decoration: const InputDecoration(labelText: 'İlçe'),
                ),
                TextFormField(
                  controller: stateController,
                  decoration: const InputDecoration(labelText: 'Şehir'),
                  inputFormatters: [UpperCaseTextFormatter()],
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Kaydet'),
              onPressed: () {
                setState(() {
                  address = addressController.text;
                  city = cityController.text;
                  state = stateController.text;
                });
                saveUserProfile();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class DateOfBirthFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newString = newValue.text;
    final StringBuffer newText = StringBuffer();

    // Remove any non-digit characters from the input
    final cleanString = newString.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleanString.length >= 3) {
      newText.write(cleanString.substring(0, 2) + '.');
      if (cleanString.length >= 5) {
        newText.write(cleanString.substring(2, 4) + '.');
        if (cleanString.length >= 9) {
          newText.write(cleanString.substring(4, 8));
        } else {
          newText.write(cleanString.substring(4));
        }
      } else {
        newText.write(cleanString.substring(2));
      }
    } else {
      newText.write(cleanString);
    }

    return newValue.copyWith(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newString = newValue.text;
    final StringBuffer newText = StringBuffer();

    final cleanString = newString.replaceAll(RegExp(r'[^0-9]'), '');

    for (int i = 0; i < cleanString.length; i++) {
      if (i == 4 || i == 7) {
        newText.write(' ');
      }
      newText.write(cleanString[i]);
    }

    return newValue.copyWith(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
