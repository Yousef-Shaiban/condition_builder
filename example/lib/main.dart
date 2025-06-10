import 'package:condition_builder/condition_builder.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'condition_builder Demo',
      home: Demo(),
    );
  }
}

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  bool isSelected = false;
  bool isDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ConditionBuilder<Color>().on(() => isDisabled, () => Colors.grey.shade300).on(() => isSelected, () => Colors.blue.shade300).build(orElse: () => Colors.black12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              ConditionBuilder<String>().on(() => isDisabled, () => 'Disabled').on(() => isSelected, () => 'Selected').build(orElse: () => 'Normal'),
              style: TextStyle(
                color: ConditionBuilder<Color>().on(() => isDisabled, () => Colors.black38).build(orElse: () => Colors.white),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Switch(
                value: isSelected,
                onChanged: isDisabled ? null : (val) => setState(() => isSelected = val),
              ),
              const Text("Selected"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Switch(
                value: isDisabled,
                onChanged: (val) => setState(() {
                  isDisabled = val;
                  if (val) isSelected = false;
                }),
              ),
              const Text("Disabled"),
            ],
          ),
        ],
      ),
    );
  }
}
