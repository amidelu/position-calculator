import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static final _formKey = GlobalKey<FormState>();
  bool _isLongActive = true;

  // Entry variables
  double? _totalCapital;
  double? _entryPrice = 0.00;
  double? _takeProfit = 0.00;
  double? _stopLoss = 0.00;

  double _positionSize = 0.0;
  double riskRatio = 0.0;
  double _riskAmount = 0.0;
  double _coinAmount = 0.0;
  double _profitAmount = 0.0;
  double _lossAmount = 0.0;

  _allCalculation() {
    setState(() {
      _riskAmount = (_totalCapital! * 1) / 100;

      if (_isLongActive) {
        riskRatio = (_entryPrice! - _stopLoss!) / _entryPrice!;
        _positionSize = _riskAmount / riskRatio;
        _coinAmount = _positionSize / _entryPrice!;
        _profitAmount = (_takeProfit! - _entryPrice!) * _coinAmount;
        _lossAmount = (_stopLoss! - _entryPrice!) * _coinAmount;
      } else {
        riskRatio = (_stopLoss! - _entryPrice!) / _entryPrice!;
        _positionSize = _riskAmount / riskRatio;
        _coinAmount = _positionSize / _entryPrice!;
        _profitAmount = (_entryPrice! - _takeProfit!) * _coinAmount;
        _lossAmount = (_entryPrice! - _stopLoss!) * _coinAmount;
      }
    });
    debugPrint('Risk Percentage: $riskRatio');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Position Calculator'),
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // ======================== Entry Section ========================
                      const Text(
                        'Entry Section',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              label: 'Total Capital',
                              isDone: false,
                              onChanged: (value) {
                                setState(() {
                                  _totalCapital = double.parse(value);
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: CustomTextFormField(
                              label: 'Entry Price',
                              isDone: false,
                              onChanged: (value) {
                                setState(() {
                                  _entryPrice = double.parse(value);
                                });
                              },
                            ),
                          ),
                        ],
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
                                  _takeProfit = double.parse(value);
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
                                  _stopLoss = double.parse(value);
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
                        isDollarShown: false,
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
    );
  }
}
