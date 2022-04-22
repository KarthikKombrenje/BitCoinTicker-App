import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
var money;
String selectedCurrency ='USD';
var currency;
class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Future<double> getApi()
  async {
    var url = Uri.parse('https://rest.coinapi.io/v1/exchangerate/BTC/$selectedCurrency?apikey=4B25A6A8-AA40-488D-A90E-C1D4D3A520F2');
    http.Response response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
       money = jsonDecode(response.body)['rate'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return money;
  }
  Future<double> getApi1()
  async {
    var url = Uri.parse('https://rest.coinapi.io/v1/exchangerate/ETH/$selectedCurrency?apikey=4B25A6A8-AA40-488D-A90E-C1D4D3A520F2');
    http.Response response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      money = jsonDecode(response.body)['rate'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return money;
  }
  Future<double> getApi2()
  async {
    var url = Uri.parse('https://rest.coinapi.io/v1/exchangerate/LTC/$selectedCurrency?apikey=4B25A6A8-AA40-488D-A90E-C1D4D3A520F2');
    http.Response response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      money = jsonDecode(response.body)['rate'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return money;
  }
  DropdownButton<String> androidDropDown()//as we are returning a DropDownButtonn so make it of the same type
  {
  return  DropdownButton<String>(
value:selectedCurrency,
items: currenciesList
    .map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
    value:value, //pass the value of the list selectedCurrency
   child: Text(value),
  );
  }).toList(),
  onChanged:(value){//whatever you select in the dropDown list is the value
  setState((){
  selectedCurrency = value!;
  print(selectedCurrency);
  });
  },
  );
  }
  CupertinoPicker iosPicker()
  {
    List<Text> pickerItems = [];//Make it of textType cuz we are returning a text widget in the children Column
    for(String currency in currenciesList)
    {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(//Ios Style dropDown
  onSelectedItemChanged: (value) {
  setState((){
  selectedCurrency = value as String;
  print(selectedCurrency);
  });
  },
  itemExtent: 32,
  children: pickerItems,
    );
  }

  Widget getPicker()
  {
     if(Platform.isIOS)
       {
         return iosPicker();
       }
     else
     {
       return androidDropDown();
     }
  }

  @override
  Widget build(BuildContext context) {
    getApi();
    getApi1();
    getApi2();
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,//using space between will leave space between card and this container
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                    '1 BTC = $money $selectedCurrency',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(height:20),
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
                  '1 ETH = $money $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height:20),
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
                  '1 LTC = $money $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
    ],),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:Platform.isIOS?iosPicker():androidDropDown(),
          ),
        ],
      ),
    );
  }
}

