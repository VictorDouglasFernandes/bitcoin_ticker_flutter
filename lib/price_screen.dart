import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

import 'components/coin_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'USD';

  Map<String,dynamic> coinDataMap = {};

  CoinData coinData = CoinData();

  DropdownButton<String> androidDropdownItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      items.add(item);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: items,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
        getDataUpdateUI();
      },
    );
  }

  Widget iosPicker() {
    List<Widget> items = [];
    for (String currency in currenciesList) {
      var item = Text(currency);
      items.add(item);
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedCurrency = currenciesList.elementAt(index);
        });
        getDataUpdateUI();
      },
      children: items,
    );
  }

  generateDefaultListValue() {
    for(String crypto in cryptoList){
      coinDataMap[crypto] = {
        'cryptoName': crypto,
        'currencyName': selectedCurrency,
        'value': 0.0
      };
    }
  }

  void getDataUpdateUI() {
    coinData.getMapData(selectedCurrency)
      .then(
        (res) {
          setState(() {
            coinDataMap = res;
          });
        }
      );
  }

  List<Widget> getCards() {
    List<Widget> cards = [];
    for(String crypto in coinDataMap.keys){
      cards.add(
        CoinCard(
            criptoName: coinDataMap[crypto]['cryptoName'],
            currencyName: coinDataMap[crypto]['currencyName'],
            value: coinDataMap[crypto]['value']
        )
      );
    }
    return cards;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateDefaultListValue();
    getDataUpdateUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: getCards(),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdownItems(),
          ),
        ],
      ),
    );
  }
}
