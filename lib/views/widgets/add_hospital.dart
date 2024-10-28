import 'package:flutter/material.dart';
import 'package:myapp/services/services.dart';

class AddHospital extends StatefulWidget {
  const AddHospital({super.key});

  @override
  State<AddHospital> createState() => _AddHospitalState();
}

class _AddHospitalState extends State<AddHospital> {
  final TextEditingController _hospitalControllers = TextEditingController();
  final TextEditingController _addressControllers = TextEditingController();
  List<dynamic> places = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250 + MediaQuery.of(context).viewInsets.bottom,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          children: [
            TextField(
              controller: _hospitalControllers,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '病院名',
              ),
            ),
            Expanded(
              child: ListView(
                children: places.map((place) => Text(place)).toList(),
              ),
            ),
            TextField(
              controller: _addressControllers,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '住所',
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  addHospital(
                      _hospitalControllers.text, _addressControllers.text);
                  Navigator.pop(context);
                },
                child: const Text('登録')),
          ],
        ),
      )),
    );
  }
}
