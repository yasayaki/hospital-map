import 'package:flutter/material.dart';
import 'package:myapp/models/db.dart';
import 'package:myapp/models/hospital.dart';
import 'package:myapp/widgets/hospital_container.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Hospital> hospitals = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 36,
            ),
            child: TextField(
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: '病院名を入力してください',
                ),
                onSubmitted: (String value) async {
                  final results = await searchHospital(value);
                  setState(() => hospitals = results);
                }),
          ),
          Expanded(
            child: ListView(
              children: hospitals
                  .map((hospital) => HospitalContainer(hospital: hospital))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  // MySQLデータベースから病院情報を検索・取得
  Future<List<Hospital>> searchHospital(String value) async {
    var results = await pool.execute(
      "SELECT id, name, address, phone FROM hospital WHERE name LIKE :name",
      {"name": "%$value%"}, // 検索ワードに基づいた部分一致検索
    );

    // 取得したデータをリストに変換
    if (results.isNotEmpty) {
      // ResultSetRow のデータを直接 Hospital に変換
      return results.rows.map((row) {
        return Hospital(
          id: row.typedColAt<int>(0) ?? 0, // id
          name: row.colAt(1) ?? '', // name
          address: row.colAt(2) ?? '', // address
          phone: row.typedColAt<int>(3) ?? 0, // phone
        );
      }).toList();
    } else {
      return [];
    }
  }
}
