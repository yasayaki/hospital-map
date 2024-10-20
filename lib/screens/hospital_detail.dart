import 'dart:math';
import 'package:flutter/material.dart';
import 'package:myapp/models/db.dart';
import 'package:myapp/models/disease.dart';
import 'package:myapp/models/hospital.dart';

class HospitalDetail extends StatefulWidget {
  const HospitalDetail({
    super.key,
    required this.hospital,
  });

  final Hospital hospital;

  @override
  State<HospitalDetail> createState() => _HospitalDetailState();
}

class _HospitalDetailState extends State<HospitalDetail> {
  List<Disease> diseases = [];
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    Future(() async {
      final searchResults = await searchDisease(widget.hospital.name);
      setState(() => diseases = searchResults);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Visibility(
              replacement: const Text(
                "登録されていません",
                style: TextStyle(color: Colors.black),
              ),
              visible: diseases.isNotEmpty,
              // maintainSize: true,
              child: Expanded(
                child: ListView.builder(
                  itemCount: diseases.length,
                  itemBuilder: (context, index) {
                    return Text(
                      diseases[index].name,
                      style: const TextStyle(color: Colors.black),
                    );
                  },
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 36,
                ),
                child: Row(children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        hintText: '病名を入力してください',
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        addItem(_controller.text);
                      },
                      child: const Text('登録')),
                ])),
          ],
        ),
      ),
    );
  }

  Future<List<Disease>> searchDisease(String value) async {
    var diseases = await pool.execute("SELECT name FROM disease");

    // 取得したデータをリストに変換
    if (diseases.rows.isNotEmpty) {
      return diseases.rows.map((row) {
        return Disease(
          id: row.colAt(0) ?? '', // id
          name: row.colAt(1) ?? '', // name
        );
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
  Future addItem(String name) async {
    var result = await pool.execute(
      "INSERT INTO disease (id, name) VALUES (:id, :name)",
      {
        "id": Random().nextInt(100000).toString(),
        "name": name,
      },
    );

    await pool.execute(
      "INSERT INTO hospital_disease (hospitalId, diseaseId) VALUES (:hospitalId, :diseaseId)",
      {
        "hospitalId": widget.hospital.id,
        "diseaseId": result.insertId!, // addItem内で登録したdiseaseのid
      },
    );
  }
}
