import 'package:condition_builder/condition_builder.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'condition_builder Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ConditionBuilderDemo(),
    );
  }
}

class ConditionBuilderDemo extends StatefulWidget {
  const ConditionBuilderDemo({super.key});

  @override
  State<ConditionBuilderDemo> createState() => _ConditionBuilderDemoState();
}

class _ConditionBuilderDemoState extends State<ConditionBuilderDemo> {
  int _counter = 0;
  String _asyncStatus = "Press button for async check";
  bool _isProcessingAsync = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> _runAsyncCheck() async {
    setState(() {
      _isProcessingAsync = true;
      _asyncStatus = "Processing...";
    });

    // Simulate some async conditions and results
    Future<bool> isEvenlyDivisibleBy3(int value) async {
      await Future.delayed(const Duration(milliseconds: 200));
      return value % 3 == 0;
    }

    Future<bool> isGreaterThan10(int value) async {
      await Future.delayed(const Duration(milliseconds: 150));
      return value > 10;
    }

    String result = (await AsyncConditionBuilder<String>()
        .on(
          () async => await isEvenlyDivisibleBy3(_counter),
          () async => "Counter ($_counter) is divisible by 3!",
        )
        .on(
          () async => await isGreaterThan10(_counter),
          () async => "Counter ($_counter) is greater than 10!",
        )
        .orElse(
          () async => "Counter ($_counter) did not meet specific async conditions.",
        )
        .build())!; // Using ! as orElse is provided

    setState(() {
      _asyncStatus = result;
      _isProcessingAsync = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // --- Synchronous ConditionBuilder Usage ---
    // Determine text and color based on counter value
    final syncResult = ConditionBuilder<(String, Color)>() // Using a Record for multiple return values
        .on(
          () => _counter == 0,
          () => ("Initial State", Colors.grey),
        )
        .on(
          () => _counter > 0 && _counter <= 5,
          () => ("Counter is low: $_counter", Colors.blue),
        )
        .onIf(
          // Example of onIf
          () => _isProcessingAsync, // Only include this condition if _isProcessingAsync is true
          () => _counter > 10, // The actual condition
          () => ("Counter is high: $_counter", Colors.orange),
        )
        .orElse(
          () => ("Counter is very high: $_counter", Colors.red),
        )
        .build()!; // Using ! because orElse is provided

    final syncText = syncResult.$1;
    final syncColor = syncResult.$2;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Condition Builder Demo"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Synchronous Example:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                syncText,
                style: TextStyle(fontSize: 24, color: syncColor),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _incrementCounter,
                child: const Text('Increment Counter'),
              ),
              const SizedBox(height: 48),
              const Text(
                'Asynchronous Example:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _isProcessingAsync
                  ? const CircularProgressIndicator()
                  : Text(
                      _asyncStatus,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isProcessingAsync ? null : _runAsyncCheck,
                child: const Text('Run Async Check'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
