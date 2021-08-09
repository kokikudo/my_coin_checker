import 'package:flutter/material.dart';

class Coin {
  final String name;
  final String quote;
  final List<double> rateList;
  final DateTime loadedDay;
  final List<String> weekdays;

  Coin(this.name, this.quote, this.rateList, this.loadedDay, this.weekdays);

  Text get floatingValue {
    double value = ((rateList.first * 100) / (rateList[1])) - 100;

    if (value > 0) {
      return Text(
        '+ ${value.toStringAsFixed(1)} %',
        style: const TextStyle(color: Colors.green),
      );
    } else if (value < 0) {
      return Text(
        '- ${value.toStringAsFixed(1)} %',
        style: const TextStyle(color: Colors.red),
      );
    } else {
      return Text('${value.toStringAsFixed(1)} %');
    }
  }
}
