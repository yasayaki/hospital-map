import 'package:flutter/material.dart';
import 'package:myapp/models/hospital.dart';
import 'package:myapp/views/widgets/add_hospital.dart';
import 'package:myapp/views/widgets/hospital_container.dart';
import 'package:myapp/services/services.dart';

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
                    final searchResults = await getHospital(value);
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
                return const AddHospital();
              });
        },
        backgroundColor: const Color(0xFF96CEB4),
        child: const Icon(Icons.add),
      ),
    );
  }
}
