import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const Ejercicio2App());
}

class Ejercicio2App extends StatelessWidget {
  // ignore: use_super_parameters
  const Ejercicio2App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Combined Widgets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CombinedWidgetsExample(),
    );
  }
}

class CombinedWidgetsExample extends StatefulWidget {
  // ignore: use_super_parameters
  const CombinedWidgetsExample({Key? key}) : super(key: key);

  @override
  State<CombinedWidgetsExample> createState() => _CombinedWidgetsExampleState();
}

class _CombinedWidgetsExampleState extends State<CombinedWidgetsExample> {
  DateTime _selectedDate = DateTime.now();
  double _cupertinoSliderValue = 50.0;
  double _materialSliderValue = 50.0;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: _selectedDate,
            minimumDate: DateTime(1900),
            maximumDate: DateTime(2100),
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                _selectedDate = newDate;
              });
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Combined Widgets'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Material Date Picker'),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              onPressed: () => _showCupertinoDatePicker(context),
              child: const Text('Cupertino Date Picker'),
            ),
            const SizedBox(height: 20),
            CupertinoSlider(
              value: _cupertinoSliderValue,
              min: 0,
              max: 100,
              onChanged: (double value) {
                setState(() {
                  _cupertinoSliderValue = value;
                });
              },
            ),
            const SizedBox(height: 10),
            Text(
              'Cupertino Slider: ${_cupertinoSliderValue.toStringAsFixed(1)}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Slider(
              value: _materialSliderValue,
              min: 0,
              max: 100,
              onChanged: (double value) {
                setState(() {
                  _materialSliderValue = value;
                });
              },
            ),
            const SizedBox(height: 10),
            Text(
              'Material Slider: ${_materialSliderValue.toStringAsFixed(1)}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
