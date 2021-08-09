import 'dart:convert';

import 'package:flutter/material.dart';
import 'models/coin_model.dart';
import 'models/repo.dart';
import 'package:http/http.dart' as http;

const apiKey = 'C6E29748-6047-42F1-B1B2-0CCA53D42DAA';

class Controller extends ChangeNotifier {
  final List<Coin> _coinList = [];

  List<Coin> get getCoinList => _coinList;

  int get listCount => _coinList.length;

  Future<void> createNewModel(String crypto, String currency) async {
    DateTime today = DateTime.now();
    DateTime todayOfUTC = DateTime.utc(today.year, today.month, today.day);
    var _weekdays = getWeekdayList(todayOfUTC);
    var _rateList = await getRateList(crypto, currency, todayOfUTC);
    _coinList.add(Coin(crypto, currency, _rateList, todayOfUTC, _weekdays));
    notifyListeners();
  }

  Future<List<double>> getRateList(
      String crypto, String currency, DateTime today) async {
    List<double> _rateList = [];
    String todayOfUTC = today.toIso8601String();
    String beforeSevenDaysOfUTC =
        DateTime.utc(today.year, today.month, today.day - 7).toIso8601String();
    var url = Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency/history?unit_count=7&period_id=1DAY&time_start=$beforeSevenDaysOfUTC&time_end=$todayOfUTC&apikey=$apiKey');
    http.Response _response = await http.get(url);
    if (_response.statusCode == 200) {
      var _decodedData = jsonDecode(_response.body);

      for (var data in _decodedData) {
        _rateList.add(data['rate_high']);
      }
    } else {
      print(_response.statusCode);
    }
    return _rateList;
  }

  List<String> getWeekdayList(DateTime todayUTC) {
    List<String> weekdays = [];
    for (int day = 0; day < 7; day++) {
      var date = todayUTC.subtract(Duration(days: day));
      weekdays.add(Repository.weekdayNames[date.weekday - 1]);
    }
    return weekdays;
  }
}
//https://rest.coinapi.io/v1/exchangerate/BTC/USD/history?unit_count=7&period_id=1DAY&time_start=2021-07-31T00:00:00&time_end=2021-08-07T00:00:00&apikey=C6E29748-6047-42F1-B1B2-0CCA53D42DAA
