import 'dart:math';
import 'package:myapp/services/db.dart';
import 'package:myapp/models/hospital.dart';

// 病院検索
Future<List<Hospital>> searchHospital(String value) async {
  var results = await pool.execute(
    "SELECT * FROM hospital WHERE name LIKE :name",
    {"name": "%$value%"}, // 検索ワードに基づいた部分一致検索
  );

  // 取得したデータをリストに変換
  if (results.isNotEmpty) {
    // ResultSetRow のデータを直接 Hospital に変換
    return results.rows.map((row) {
      return Hospital(
        id: row.colAt(0) ?? '', // id
        name: row.colAt(1) ?? '', // name
        address: row.colAt(2) ?? '', // address
        phoneNumber: row.colAt(3), // phone
      );
    }).toList();
  } else {
    return [];
  }
}

// 病院登録
Future addHospital(String name, String address) async {
  await pool.execute(
    "INSERT INTO hospital (id, name, address, lat, lng) VALUES (:id, :name, :address, :lat, :lng)",
    {
      "id": Random().nextInt(100000).toString(),
      "name": name,
      "address": address,
      "lat": "0.0",
      "lng": "0.0",
    },
  );
}

Future<List<String>> searchDisease(String value) async {
  var diseases = await pool.execute(
      "SELECT disease.name AS disease_name FROM hospital JOIN hospital_disease ON hospital.id = hospital_disease.hospitalId JOIN disease ON hospital_disease.diseaseId = disease.id WHERE hospital.id = $value");
  // 取得したデータをリストに変換
  if (diseases.rows.isNotEmpty) {
    return diseases.rows.map((row) {
      return row.colByName("disease_name").toString();
    }).toList();
    // // 取得したデータをリストに変換
    // if (diseases.rows.isNotEmpty) {
    //   return diseases.rows.map((row) {
    //     return row.assoc().values.toString();
    //   }).toList();
  } else {
    return [];
  }
}

// 病気を登録
Future addDisease(String name) async {
  final pass = Random().nextInt(100000).toString();

  await pool.execute(
    "INSERT INTO disease (id, name) VALUES (:id, :name)",
    {
      "id": pass,
      "name": name,
    },
  );

  await pool.execute(
    "INSERT INTO hospital_disease (hospitalId, diseaseId) VALUES (:hospitalId, :diseaseId)",
    {
      "hospitalId": pass,
      "diseaseId": pass,
    },
  );
}
