class Hospital {
  // コンストラクタ
  Hospital({
    required this.id,
    required this.name,
    required this.address,
    this.phone = 0, // デフォルト値を0で設定
  });

  // プロパティ
  final int id;
  final String name;
  final String address;
  final int phone;

  // JSONからArticleを生成するファクトリコンストラクタ
  // factory Hospital.fromMap(Map<String, dynamic> map) {
  //   return Hospital(
  //     id: map['id'],
  //     name: map['name'],
  //     address: map['address'],
  //     phone: map['phone'],
  //   );
  // }
}
