import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bitcoin_ticker/coins.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  PriceScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? currencies;
  getAndroidButton() {
    List<DropdownMenuItem<String>> items = [];
    for (var i in currenciesList) {
      currencies = i;
      var newItem = DropdownMenuItem(
        child: Text(currencies!),
        value: currencies,
      );
      items.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: items,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value!;
          });
          print(value);
        });
  }

  getWidget() {
    if (Platform.isIOS) {
      return getIosPicker();
    } else if (Platform.isAndroid) {
      return getAndroidButton();
    }
  }

  getIosPicker() {
    List<Text> currencies = [];
    for (var i in currenciesList) {
      currencies.add(Text(i));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        print(index);
      },
      children: currencies,
    );
  }

  String? selectedValue;

  String selectedCurrency = 'USD';
  String? btcvalue;
  String? time;
  String? assetidbase;
  String? rate;

  Future getData() async {
    final response = await http.get(Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=A5F367B6-30C4-4DE4-B596-DCDC488DE7E1'));
    final data = jsonDecode(response.body);
    setState(() {
      time = data["time"];
      assetidbase = data['asset_id_base'];
      rate = data['rate'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Coin Ticker',
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.blue,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Row(
                  children: [
                    Text(
                      // snapshot.data![index].toString(),''
                      //  textAlign: TextAlign.center,
                      rate.toString(),
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      // snapshot.data![index].toString(),''
                      //  textAlign: TextAlign.center,
                      assetidbase.toString(),
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 80.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 50.0),
            color: Colors.lightBlue,
            child: getWidget(),
          ),
        ],
      ),
    );
  }
}

class ExchangeModel {
  String? time;
  String? assetIdBase;
  String? assetIdQuote;
  double? rate;

  ExchangeModel({this.time, this.assetIdBase, this.assetIdQuote, this.rate});

  ExchangeModel.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    assetIdBase = json['asset_id_base'];
    assetIdQuote = json['asset_id_quote'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = time;
    data['asset_id_base'] = assetIdBase;
    data['asset_id_quote'] = assetIdQuote;
    data['rate'] = rate;
    return data;
  }
}
