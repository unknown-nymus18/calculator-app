import 'package:calculator/custom_button.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String value = '';
  List<String> result = [];
  String lastOperator = '';

  void btnClicked(data) {
    setState(() {
      value = value + data;
      if (result.isNotEmpty) {
        if (result[0] == 'Error') {
          result.clear();
        }
      }
    });
  }

  void calc({
    required String operand1,
    required String operand2,
    required String operator,
  }) {
    if (operator == 'x') {
      result[0] = (double.parse(operand1) * double.parse(operand2)).toString();
    } else if (operator == '+') {
      result[0] = (double.parse(operand1) + double.parse(operand2)).toString();
    } else if (operator == '-') {
      result[0] = (double.parse(operand1) - double.parse(operand2)).toString();
    } else if (operator == '/' || operator == '%') {
      if (double.parse(operand2) != 0) {
        if (operator == '/') {
          result[0] =
              (double.parse(operand1) / double.parse(operand2)).toString();
        } else {
          result[0] = ((double.parse(operand1) / double.parse(operand2)) * 100)
              .toString();
        }
      } else {
        result[0] = "Error";
      }
    }

    if (result[0] != 'Error') {
      if (double.parse(result[0]) == double.parse(result[0]).toInt()) {
        result[0] = double.parse(result[0]).truncate().toString();
      } else {
        result[0] = roundNumber(double.parse(result[0])).toString();
      }
    }
    result.removeAt(1);
    value = '';
    lastOperator = '';
  }

  void clear() {
    setState(() {
      value = '';
      result = [];
      lastOperator = '';
    });
  }

  double roundNumber(double number) {
    return (number * 100000).roundToDouble() / 100000;
  }

  void getOperand(operator) {
    setState(() {
      if (value.isNotEmpty) {
        if (result.length < 2) {
          result.add(value);
        }
        if (result.length == 2) {
          calc(
              operand1: result[0],
              operand2: result[1],
              operator: lastOperator.isEmpty ? operator : lastOperator);
        } else {
          value = '';
        }
      }
      lastOperator = operator;
    });
  }

  void delete() {
    if (value.isNotEmpty) {
      setState(() {
        value = value.substring(0, value.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                value.isEmpty
                    ? result.isNotEmpty
                        ? result[0]
                        : '0'
                    : value,
                style: const TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                text: 'AC',
                onTap: clear,
              ),
              CustomButton(
                  text: 'del',
                  onTap: () {
                    delete();
                  }),
              CustomButton(
                  text: '%',
                  onTap: () {
                    getOperand('%');
                  }),
              CustomButton(
                  text: '/',
                  onTap: () {
                    getOperand('/');
                  }),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                  text: '7',
                  onTap: () {
                    btnClicked('7');
                  }),
              CustomButton(
                  text: '8',
                  onTap: () {
                    btnClicked('8');
                  }),
              CustomButton(
                  text: '9',
                  onTap: () {
                    btnClicked('9');
                  }),
              CustomButton(
                  text: 'x',
                  onTap: () {
                    getOperand('x');
                  }),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                  text: '4',
                  onTap: () {
                    btnClicked('4');
                  }),
              CustomButton(
                  text: '5',
                  onTap: () {
                    btnClicked('5');
                  }),
              CustomButton(
                  text: '6',
                  onTap: () {
                    btnClicked('6');
                  }),
              CustomButton(
                  text: '-',
                  onTap: () {
                    getOperand('-');
                  }),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                  text: '1',
                  onTap: () {
                    btnClicked('1');
                  }),
              CustomButton(
                  text: '2',
                  onTap: () {
                    btnClicked('2');
                  }),
              CustomButton(
                  text: '3',
                  onTap: () {
                    btnClicked('3');
                  }),
              CustomButton(
                  text: '+',
                  onTap: () {
                    getOperand('+');
                  }),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                text: '0',
                onTap: () {
                  btnClicked('0');
                },
                width: 180,
              ),
              CustomButton(
                text: '.',
                onTap: () {
                  btnClicked('.');
                },
                width: 80,
              ),
              CustomButton(
                text: '=',
                onTap: () {
                  if (lastOperator.isNotEmpty) {
                    getOperand(lastOperator);
                  }
                },
                width: 80,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
