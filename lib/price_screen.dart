import 'package:flutter/material.dart';
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

  var data;

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
      },
      children: items,
    );
  }

  void getCardData() async {
    // for(String crypto in cryptoList){
    //   var data = await CoinData().getCoinData('ETH', 'ZAR');
    // }
    data = await CoinData().getCoinData('ETH', 'ZAR');
    setState(() {
      data = data;
    });
    print(data['asset_id_base']);
    // return CoinCard(
    //     criptoName: data.asset_id_base,
    //     currencyName: data.asset_id_quote,
    //     value: data.rate
    // );
  }

  Widget getOneCard() {
    return CoinCard(
        criptoName: data['asset_id_base'],
        currencyName: data['asset_id_quote'],
        value: data['rate']
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CoinCard(
                  criptoName: 'BTC',
                  currencyName: 'USD',
                  value: 1,
                ),
                CoinCard(
                  criptoName: 'ETH',
                  currencyName: 'USD',
                  value: 1,
                ),
                CoinCard(
                  criptoName: 'LTC',
                  currencyName: 'USD',
                  value: 1,
                ),
                getOneCard()
              ],
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
