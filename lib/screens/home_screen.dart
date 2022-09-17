import 'package:calculator/widgets/display.dart';
import 'package:calculator/widgets/keyboard_button.dart';
import 'package:calculator/widgets/keyboard_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';
import 'package:just_audio/just_audio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String focusedButtonText = '';
  final List<String> calculatorSymbolsList = [
    'C',
    '(',
    ')',
    '<-',
    '1',
    '2',
    '3',
    '/',
    '4',
    '5',
    '6',
    '*',
    '7',
    '8',
    '9',
    '-',
    '.',
    '0',
    '=',
    '+',
  ];

  String calculatorDisplayString = '';
  String calculatorString = '';

  final player = AudioPlayer();

  Future playAudio() async {
    await player.setAsset(
      'assets/sounds/pressed-7.mp3',
    );
    await player.setVolume(0.3);
    await player.play();
  }

  void computingNumbers() async {
    debugPrint('calculatorDisplayString =' + calculatorDisplayString);
    debugPrint('calculatorString =' + calculatorString);
    setState(() {
      focusedButtonText = '=';
    });
    if (calculatorString != 'error') {
      try {
        var expression = Expression.parse(calculatorString);
        var evaluator = const ExpressionEvaluator();
        var resultCalculation = evaluator.eval(expression, {});
        setState(() {
          calculatorDisplayString = resultCalculation.toString();
          calculatorString = resultCalculation.toString();
        });
      } catch (e) {
        debugPrint('error=' + e.toString());
        if (calculatorString.isNotEmpty) {
          setState(() {
            calculatorString = 'error';
            calculatorDisplayString = 'error';
          });
        }
      }
    } else {
      setState(() {
        calculatorDisplayString = '';
        calculatorString = '';
      });
    }
  }

  Iterable<Widget> keyboardButtonsWidget = [];

  @override
  void initState() {
    super.initState();
    keyboardButtonsWidget =
        calculatorSymbolsList.map((String calculatorSymbol) {
      if (calculatorSymbol == '<-') {
        return _buildCalculatorKeyWidget(
            onPressed: () {
              if (calculatorDisplayString.isNotEmpty) {
                setState(() {
                  calculatorDisplayString = calculatorDisplayString.substring(
                      0, calculatorDisplayString.length - 1);
                  calculatorString = calculatorString.substring(
                      0, calculatorString.length - 1);
                });
              }
              setState(() {
                focusedButtonText = calculatorSymbol;
              });
            },
            onLongPressed: () {
              setState(() {
                calculatorDisplayString = '';
                calculatorString = '';
                focusedButtonText = calculatorSymbol;
              });
            },
            child: KeyboardIconButton(
                icon: Icons.backspace_outlined,
                isFocused: focusedButtonText == calculatorSymbol));
      } else {
        if (calculatorSymbol == 'C') {
          return _buildCalculatorKeyWidget(
              onPressed: () {
                setState(() {
                  calculatorDisplayString = '';
                  calculatorString = '';
                  focusedButtonText = calculatorSymbol;
                });
              },
              child: KeyboardButton(
                  isFocused: focusedButtonText == calculatorSymbol,
                  text: calculatorSymbol));
        } else if (calculatorSymbol == '*') {
          return _buildCalculatorKeyWidget(
              onPressed: () {
                setState(() {
                  calculatorDisplayString += '×';
                  calculatorString += calculatorSymbol;
                  focusedButtonText = calculatorSymbol;
                });
              },
              child: KeyboardButton(
                  isFocused: focusedButtonText == calculatorSymbol, text: '×'));
        } else if (calculatorSymbol == '/') {
          return _buildCalculatorKeyWidget(
              onPressed: () {
                setState(() {
                  calculatorDisplayString += '÷';
                  calculatorString += calculatorSymbol;
                  focusedButtonText = calculatorSymbol;
                });
              },
              child: KeyboardButton(
                  isFocused: focusedButtonText == calculatorSymbol, text: '÷'));
        } else if (calculatorSymbol == '=') {
          return _buildCalculatorKeyWidget(
              onPressed: () {
                computingNumbers();
              },
              child: KeyboardButton(
                  isFocused: focusedButtonText == calculatorSymbol,
                  text: calculatorSymbol));
        } else {
          return _buildCalculatorKeyWidget(
              onPressed: () {
                setState(() {
                  calculatorString += calculatorSymbol;
                  calculatorDisplayString += calculatorSymbol;
                  focusedButtonText = calculatorSymbol;
                });
              },
              child: KeyboardButton(
                  isFocused: focusedButtonText == calculatorSymbol,
                  text: calculatorSymbol));
        }
      }
    });
  }

  Widget _buildCalculatorKeyWidget({
    required Function onPressed,
    required Widget child,
    VoidCallback? onLongPressed,
  }) {
    return GestureDetector(
      onTap: () async {
        await playAudio();
        onPressed();
      },
      onLongPress: onLongPressed != null
          ? () async {
              await playAudio();
              onLongPressed();
            }
          : null,
      child: child,
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF131419),
      body: SafeArea(
        child: Container(
            width: size.width,
            height: size.height,
            padding: const EdgeInsets.all(25),
            decoration:
                BoxDecoration(color: const Color(0xFF131419), boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(2, 2),
                  blurRadius: 5),
              BoxShadow(
                  color: Colors.white.withOpacity(0.05),
                  offset: const Offset(-3, -3),
                  blurRadius: 7),
            ]),
            child: Column(
              children: [
                Display(text: calculatorDisplayString),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(children: keyboardButtonsWidget.toList()),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
