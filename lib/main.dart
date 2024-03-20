import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Dice Probability Calculator',
      home: DiceCalculator(),
    );
  }
}

class DiceCalculator extends StatefulWidget {
  const DiceCalculator({super.key});

  @override
  _DiceCalculatorState createState() => _DiceCalculatorState();
}

class _DiceCalculatorState extends State<DiceCalculator> {
  int _diceType = 20; // Default to d20
  int _dc = 10; // Default DC of 10
  bool _isAdvantage = false;
  bool _isDisadvantage = false;
  double _probability = 0.0;

  void _calculateProbability() {
    int maxRoll = _diceType;
    int numRolls = _isAdvantage ? 2 : (_isDisadvantage ? 2 : 1);
    int successCount = 0;
    int totalCombinations = pow(maxRoll, numRolls).toInt();

    for (int i = 0; i < totalCombinations; i++) {
      List<int> rolls = [];
      int value = i;
      for (int j = 0; j < numRolls; j++) {
        rolls.add(value % maxRoll + 1);
        value ~/= maxRoll;
      }
      int result = _isAdvantage
          ? rolls.reduce(max)
          : (_isDisadvantage ? rolls.reduce(min) : rolls[0]);
      if (result >= _dc) {
        successCount++;
      }
    }

    setState(() {
      _probability = successCount / totalCombinations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dice Probability Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<int>(
              value: _diceType,
              onChanged: (int? newValue) {
                setState(() {
                  _diceType = newValue!;
                });
              },
              items: List.generate(99, (index) => index + 2)
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('d$value'),
                );
              }).toList(),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _dc = int.parse(value);
                });
              },
              decoration: const InputDecoration(
                labelText: 'Difficulty Class (DC)',
              ),
            ),
            SwitchListTile(
              title: const Text('Advantage'),
              value: _isAdvantage,
              onChanged: (bool value) {
                setState(() {
                  _isAdvantage = value;
                  _isDisadvantage = false;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Disadvantage'),
              value: _isDisadvantage,
              onChanged: (bool value) {
                setState(() {
                  _isDisadvantage = value;
                  _isAdvantage = false;
                });
              },
            ),
            ElevatedButton(
              onPressed: _calculateProbability,
              child: const Text('Calculate Probability'),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Probability of rolling $_dc or higher: ${(_probability * 100).toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
