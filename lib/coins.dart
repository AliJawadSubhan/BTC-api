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

