import 'dart:convert';
import 'package:http/http.dart' as http;

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

const cryptoCompareURL = 'https://min-api.cryptocompare.com/data';

class CoinData {
  Map<String, String> cryptoRates = {};

  Future getCoinData(String selectedCurrency) async {
    for (String crypto in cryptoList) {
      String requestURL =
          '$cryptoCompareURL/price?fsym=$crypto&tsyms=$selectedCurrency';
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var lastPrice = decodedData['$selectedCurrency'];
        cryptoRates[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoRates;
  }
}
