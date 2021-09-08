
import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  CoinCard({required this.criptoName,required this.currencyName, required this.value});

  final String criptoName;
  final String currencyName;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $criptoName = ${value.toString()} $currencyName',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );;
  }
}

