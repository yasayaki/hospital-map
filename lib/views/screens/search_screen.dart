import 'package:flutter/material.dart';
import 'package:myapp/models/hospital.dart';
import 'package:myapp/views/widgets/hospital_container.dart';
import 'package:myapp/services/services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<TextEditingController> controllers =
      List.generate(2, (i) => TextEditingController());
  List<Hospital> hospitals = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 36,
              ),
              child: TextField(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    hintText: '病院名を入力してください',
                  ),
                  onSubmitted: (String value) async {
                    final searchResults = await searchHospital(value);
                    setState(() => hospitals = searchResults);
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: controllers[0],
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '病院名',
                        ),
                      ),
                      TextField(
                        controller: controllers[1],
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '住所',
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            addHospital(
                                controllers[0].text, controllers[1].text);
                            Navigator.pop(context);
                          },
                          child: const Text('登録')),
                    ],
                  ),
                )),
              );
            },
          );
        },
        backgroundColor: const Color(0xFF96CEB4),
        child: const Icon(Icons.add),
      ),
    );
  }
}
