import 'package:bitcoin_ticker/coins.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  
  getDropDownButton() {
    String? currencies;
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
      return getDropDownButton();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
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
