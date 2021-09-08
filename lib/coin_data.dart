
import 'package:bitcoin_ticker_flutter/network.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = 'A8FEA357-42CD-4F2D-B7FB-0E1C23F9C444';
const apiKey2 = '4346254A-D233-45A1-87D9-2E8AA0E61214';
const apiBaseUrl = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {

  // Future<dynamic> getCoinData(String cryptoCoin, String currency) async {
  //   Network network = Network('$apiBaseUrl/$cryptoCoin/$currency?apikey=$apiKey');
  //   var cryptoData = await network.getData();
  //   print(cryptoData);
  //   return cryptoData;
  // }

  Future<dynamic> getCoinData(String cryptoCoin, String? currency) async {
    Network network = Network('$apiBaseUrl/$cryptoCoin/$currency?apikey=$apiKey2');
    var cryptoData = await network.getData();
    print('Crypto: $cryptoCoin \n-----------\n$cryptoData');
    return cryptoData;
  }
}