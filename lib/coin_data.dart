
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

Map<String,dynamic> coinDataMap = {};

const apiKey = 'A8FEA357-42CD-4F2D-B7FB-0E1C23F9C444';
const apiKey2 = '4346254A-D233-45A1-87D9-2E8AA0E61214';
const apiBaseUrl = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {

  Future<dynamic> getCoinData(String cryptoCoin, String? currency) async {
    Network network = Network('$apiBaseUrl/$cryptoCoin/$currency?apikey=$apiKey');
    var cryptoData = await network.getData();
    print('Crypto: $cryptoCoin \n-----------\n$cryptoData');
    return cryptoData;
  }

  Future<Map<String,dynamic>> getMapData(String? currency) async{
    for(String crypto in cryptoList){
      await getCoinData(crypto, currency).then(
              (res) {
            updateMap(res);
          }
      );
    }
    return coinDataMap;
  }

  void updateMap(dynamic coinData) {
      coinDataMap[coinData['asset_id_base']] = {
        'cryptoName': coinData['asset_id_base'],
        'currencyName': coinData['asset_id_quote'],
        'value': double.parse(coinData['rate'].toStringAsFixed(2))
      };
  }
}