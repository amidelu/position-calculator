import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'widgets/widgets.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static final _formKey = GlobalKey<FormState>();
  bool _isLongActive = true;
  final FocusNode _entryPriceFocus = FocusNode();
  final box = GetStorage();

  // Entry variables
  String? _totalCapital;
  String? _entryPrice = '0.00';
  String? _takeProfit = '0.00';
  String? _stopLoss = '0.00';

  double _positionSize = 0.0;
  double riskRatio = 0.0;
  double _riskAmount = 0.0;
  double _coinAmount = 0.0;
  double _profitAmount = 0.0;
  double _lossAmount = 0.0;

  _resetAllValue() {
    setState(() {
      _formKey.currentState!.reset();
      _entryPriceFocus.requestFocus();

      _positionSize = 0.0;
      riskRatio = 0.0;
      _riskAmount = 0.0;
      _coinAmount = 0.0;
      _profitAmount = 0.0;
      _lossAmount = 0.0;
    });
  }

  _allCalculation() {
    setState(() {
      double totalCap = double.parse(_totalCapital!);
      _riskAmount = (totalCap * 1) / 100;

      if (_isLongActive) {
        riskRatio = (double.parse(_entryPrice!) - double.parse(_stopLoss!)) /
            double.parse(_entryPrice!);
        _positionSize = _riskAmount / riskRatio;
        _coinAmount = _positionSize / double.parse(_entryPrice!);
        _profitAmount =
            (double.parse(_takeProfit!) - double.parse(_entryPrice!)) *
                _coinAmount;
        _lossAmount = (double.parse(_stopLoss!) - double.parse(_entryPrice!)) *
            _coinAmount;
      } else {
        riskRatio = (double.parse(_stopLoss!) - double.parse(_entryPrice!)) /
            double.parse(_entryPrice!);
        _positionSize = _riskAmount / riskRatio;
        _coinAmount = _positionSize / double.parse(_entryPrice!);
        _profitAmount =
            (double.parse(_entryPrice!) - double.parse(_takeProfit!)) *
                _coinAmount;
        _lossAmount = (double.parse(_entryPrice!) - double.parse(_stopLoss!)) *
            _coinAmount;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Position & Risk Calculator'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Top Button
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        title: 'LONG',
                        buttonColor: _isLongActive
                            ? Colors.green[900]
                            : Colors.grey[600],
                        onTap: () {
                          setState(() {
                            _isLongActive = true;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: CustomButton(
                        title: 'SHORT',
                        buttonColor:
                            !_isLongActive ? Colors.red[900] : Colors.grey[600],
                        onTap: () {
                          setState(() {
                            _isLongActive = false;
                          });
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const Text(
                  'Entry Section',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextFormField(
                  label: 'Total Capital',
                  initialValue: box.read('capital'),
                  isDone: false,
                  onChanged: (value) {
                    setState(() {
                      box.write('capital', value);
                      _totalCapital = value;
                    });
                  },
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // ======================== Entry Section ========================
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        myFocus: _entryPriceFocus,
                        label: 'Entry Price',
                        isDone: false,
                        onChanged: (value) {
                          setState(() {
                            _entryPrice = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              label: 'Take Profit',
                              isDone: false,
                              onChanged: (value) {
                                setState(() {
                                  _takeProfit = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: CustomTextFormField(
                              label: 'Stop Loss',
                              isDone: true,
                              onChanged: (value) {
                                setState(() {
                                  _stopLoss = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      Container(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                        width: MediaQuery.of(context).size.width,
                        child: CustomButton(
                          title: 'CALCULATE',
                          buttonColor: Colors.deepPurple,
                          onTap: _allCalculation,
                        ),
                      ),
                      // ======================== Result Section ========================
                      const Text(
                        'Result Section',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextRow(
                        title: 'Risk Amount',
                        value: _riskAmount.toStringAsFixed(2),
                        isDollarShown: true,
                      ),
                      CustomTextRow(
                        title: 'Position Size',
                        value: _positionSize.toStringAsFixed(2),
                        isDollarShown: true,
                      ),
                      CustomTextRow(
                        title: 'Risk%',
                        value: '${riskRatio.toStringAsFixed(4)}%',
                        isDollarShown: false,
                      ),

                      CustomTextRow(
                        title: 'Coin Amount',
                        value: _coinAmount.toStringAsFixed(2),
                        isDollarShown: false,
                      ),
                      CustomTextRow(
                        title: 'Profit Amount',
                        value: _profitAmount.toStringAsFixed(2),
                        isDollarShown: true,
                      ),
                      CustomTextRow(
                        title: 'Loss Amount',
                        value: _lossAmount.toStringAsFixed(2),
                        isDollarShown: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Reset',
        onPressed: _resetAllValue,
        child: const Icon(Icons.restart_alt_outlined),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
