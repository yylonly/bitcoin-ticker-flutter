import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData cData;
  String selectedCurrency = 'USD';
  double currentMountBTC = 0;
  double currentMountETH = 0;
  double currentMountLTC = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cData = CoinData();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $currentMountBTC $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $currentMountETH $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $currentMountLTC $selectedCurrency',
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
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }



  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) async {
        print(value);
        getData(value);
      },
    );
  }

  CupertinoPicker IOSPicker() {
    List<Text> dropdownItems = [];

    for (String currency in currenciesList) {
      dropdownItems.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (selectedIndex) async {
        getData(selectedIndex);
      },
      children: dropdownItems,
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return IOSPicker();
    } else if (Platform.isAndroid) {
      return androidDropdown();
    }
  }

  void initData() {

    if (Platform.isIOS) {
      return getData(0);
    } else if (Platform.isAndroid) {
      return getData('USD');
    }
  }

  void getData(dynamic para) {
    if (Platform.isIOS) {
      return getDataIOS(para);
    } else if (Platform.isAndroid) {
      return getDataAndroid(para);
    }
  }

  void getDataIOS(int selectedIndex) async {
    double lastBTC = await cData.getCoinData(currenciesList[selectedIndex], 'BTC');
    double lastETH = await cData.getCoinData(currenciesList[selectedIndex], 'ETH');
    double lastLTC = await cData.getCoinData(currenciesList[selectedIndex], 'LTC');

    setState(() {
      currentMountBTC = lastBTC;
      currentMountETH = lastETH;
      currentMountLTC = lastLTC;

      selectedCurrency = currenciesList[selectedIndex];
    });
  }

  void getDataAndroid(String currency) async {

    double lastBTC = await cData.getCoinData(currency, 'BTC');
    double lastETH = await cData.getCoinData(currency, 'ETH');
    double lastLTC = await cData.getCoinData(currency, 'LTC');

    setState(() {
      currentMountBTC = lastBTC;
      currentMountETH = lastETH;
      currentMountLTC = lastLTC;
      selectedCurrency = currency;
    });
  }
}

