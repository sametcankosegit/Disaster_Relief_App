class FamilyInfo {
  final int id;
  final String name;
  final int age;

  FamilyInfo({required this.id, required this.name, required this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Family{id: $id, name: $name, age: $age}';
  }
}
