import 'dart:convert';

import 'package:http/http.dart' as http;

const List currenciesList = [
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

const apikey = 'A5F367B6-30C4-4DE4-B596-DCDC488DE7E1';
const apilink = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {

  getData() async {
    var url = Uri.parse('$apilink/BTC/USD?apikey=$apikey');
    final response = await http.get(url);

    if (response.statusCode == 200) {

      return ApiModel.fromJson(jsonDecode(response.body));
    }
  }
}
class ApiModel {
  String? time;
  String? assetIdBase;
  String? assetIdQuote;
  double? rate;

  ApiModel({this.time, this.assetIdBase, this.assetIdQuote, this.rate});

  ApiModel.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    assetIdBase = json['asset_id_base'];
    assetIdQuote = json['asset_id_quote'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['time'] = this.time;
    data['asset_id_base'] = this.assetIdBase;
    data['asset_id_quote'] = this.assetIdQuote;
    data['rate'] = this.rate;
    return data;
  }
}
