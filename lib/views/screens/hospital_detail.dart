import 'package:flutter/material.dart';
import 'package:myapp/models/hospital.dart';
import 'package:myapp/services/services.dart';

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
  List<String> diseases = [];
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    Future(() async {
      final searchResults = await searchDisease(widget.hospital.id);
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
              child: Expanded(
                child: ListView.builder(
                  itemCount: diseases.length,
                  itemBuilder: (context, index) {
                    return Text(
                      diseases[index],
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
                        addDisease(_controller.text);
                      },
                      child: const Text('登録')),
                ])),
          ],
        ),
      ),
    );
  }
}
