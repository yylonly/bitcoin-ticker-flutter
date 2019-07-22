import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'USD',
  'MOP',
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
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  Future<double> getCoinData(String currency, String crypto) async {

    var response = await http.get('https://apiv2.bitcoinaverage.com/indices/global/ticker/$crypto$currency');

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      double itemCount = jsonResponse['last'];
      return itemCount;
    } else {
      print("Request failed with status: ${response.statusCode}.");
      return 0;
    }
  }

}
