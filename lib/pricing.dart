import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bitcoin_ticker/coins.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  PriceScreen({Key? key, this.data}) : super(key: key);
  var data;

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

  CoinData coinData = CoinData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    var url = Uri.parse('$apilink/BTC/USD?apikey=$apikey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body.toString());

      return ApiModel.fromJson(json);
    }
  }

  @override
  Widget build(context) {
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
          FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
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
                            child: Text(
                             snapshot.data![index].toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }),
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
