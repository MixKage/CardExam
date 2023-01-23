import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final List<String> items = [
    'МИРЭА',
    'Финансовый',
    'ItHub',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const TextField(style: TextStyle()),
              CustomDropdownButton2(
                buttonWidth: 250,
                hint: 'Выберите учебное заведение',
                dropdownItems: items,
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
              ),
            ],
          ),
        ),
      );
}
