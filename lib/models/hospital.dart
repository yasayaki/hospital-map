class Hospital {
  // コンストラクタ
  Hospital({
    required this.id,
    required this.name,
    required this.address,
    this.phoneNumber,
  });

  // プロパティ
  final String id;
  final String name;
  final String address;
  final String? phoneNumber;

  // JSONからHospitalを生成するファクトリコンストラクタ
  // factory Hospital.fromMap(Map<String, dynamic> map) {
  //   return Hospital(
  //     id: map['id'],
  //     name: map['name'],
  //     address: map['address'],
  //     phone: map['phone'],
  //   );
  // }
}
