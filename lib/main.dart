import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  int _customDiceType = 0; // Custom dice type, initially set to 0
  int _dc = 10; // Default DC of 10
  bool _isAdvantage = false;
  bool _isDisadvantage = false;
  double _probability = 0.0;
  int _modifier = 0; // Default modifier of 0
  bool _showNonStandardDice = false;
  bool _showDCError = false;
  bool _showModifierError = false;

  final TextEditingController _customDiceTypeController =
      TextEditingController();
  final TextEditingController _dcController = TextEditingController();
  final TextEditingController _modifierController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _calculateProbability();
  }

  @override
  void dispose() {
    _customDiceTypeController.dispose();
    _dcController.dispose();
    _modifierController.dispose();
    super.dispose();
  }

  void _calculateProbability() {
    int maxRoll = _showNonStandardDice && _customDiceType > 0
        ? _customDiceType
        : _diceType;
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
      if (result + _modifier >= _dc) {
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
              value: _showNonStandardDice && _customDiceType > 0
                  ? null
                  : _diceType,
              onChanged: _showNonStandardDice && _customDiceType > 0
                  ? null
                  : (int? newValue) {
                      setState(() {
                        _diceType = newValue!;
                        _calculateProbability();
                      });
                    },
              items: [
                4,
                6,
                8,
                10,
                12,
                20,
                100,
              ].map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('d$value'),
                );
              }).toList(),
              disabledHint: Text('Custom dice'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showNonStandardDice = !_showNonStandardDice;
                  if (!_showNonStandardDice) {
                    _customDiceTypeController.clear();
                    _customDiceType = 0;
                  }
                });
              },
              child: const Text('Non-standard Dice'),
            ),
            if (_showNonStandardDice)
              TextField(
                controller: _customDiceTypeController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                onChanged: (value) {
                  setState(() {
                    try {
                      _customDiceType = int.parse(value);
                      if (_customDiceType <= 0) {
                        _customDiceType = 0;
                        _probability = 0.0;
                      } else {
                        _calculateProbability();
                      }
                    } catch (e) {
                      _customDiceType = 0;
                      _probability = 0.0;
                    }
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Custom Dice Type',
                ),
              ),
            TextField(
              controller: _dcController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onChanged: (value) {
                setState(() {
                  try {
                    _dc = int.parse(value);
                    if (_dc == 0) {
                      _probability = 0.0;
                      _showDCError = true;
                    } else {
                      _calculateProbability();
                      _showDCError = false;
                    }
                  } catch (e) {
                    _dc = 0;
                    _probability = 0.0;
                    _showDCError = true;
                  }
                });
              },
              decoration: InputDecoration(
                labelText: 'Difficulty Class (DC)',
                errorText: _showDCError ? 'Invalid DC value' : null,
              ),
            ),
            TextField(
              controller: _modifierController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
              ],
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    _modifier = 0;
                    _calculateProbability();
                    _showModifierError = false;
                  } else {
                    try {
                      _modifier = int.parse(value);
                      _calculateProbability();
                      _showModifierError = false;
                    } catch (e) {
                      _modifier = 0;
                      _showModifierError = true;
                    }
                  }
                });
              },
              decoration: InputDecoration(
                labelText: 'Modifier',
                errorText: _showModifierError ? 'Invalid modifier value' : null,
              ),
            ),
            SwitchListTile(
              title: const Text('Advantage'),
              value: _isAdvantage,
              onChanged: (bool value) {
                setState(() {
                  _isAdvantage = value;
                  _isDisadvantage = false;
                  _calculateProbability();
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
                  _calculateProbability();
                });
              },
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Probability of rolling $_dc or higher with a modifier of $_modifier:',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '${(_probability * 100).toStringAsFixed(2)}%',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
