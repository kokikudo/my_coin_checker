import 'package:flutter/material.dart';
import 'package:my_coin_checker/controller.dart';
import 'package:provider/provider.dart';
import 'package:my_coin_checker/constraints.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:my_coin_checker/models/coin_model.dart';
import 'dart:math';

class ChartScreen extends StatelessWidget {
  const ChartScreen({Key? key, required this.coin}) : super(key: key);

  final Coin coin;

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;

    return Consumer<Controller>(builder: (_, controller, child) {
      return Scaffold(
        backgroundColor: kcLightBlue,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                coin.rateList[6].toStringAsFixed(2),
                style: _textTheme.headline3,
              ),
              coin.floatingValue,
              const SizedBox(
                height: 20.0,
              ),
              Text(
                'HIGH',
                style: _textTheme.headline5,
              ),
              Text(
                coin.rateList.reduce(max).toStringAsFixed(2),
                style: _textTheme.headline4,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'LOW',
                style: _textTheme.headline5,
              ),
              Text(
                coin.rateList.reduce(min).toStringAsFixed(2),
                style: _textTheme.headline4,
              ),
              const SizedBox(
                height: 20.0,
              ),
              ChartWidget(coin: coin),
            ],
          ),
        ),
      );
    });
  }
}

class ChartWidget extends StatelessWidget {
  const ChartWidget({
    Key? key,
    required this.coin,
  }) : super(key: key);

  final Coin coin;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kcLightBlue,
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      child: LineChart(
        LineChartData(
          borderData: FlBorderData(
            show: false,
          ),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            show: true,
            leftTitles: SideTitles(
              showTitles: false,
            ),
            bottomTitles: SideTitles(
              showTitles: true,
              reservedSize: 20,
              getTextStyles: (value) => const TextStyle(color: kcLightGray),
              getTitles: (value) {
                switch (value.toInt()) {
                  case 0:
                    return coin.weekdays[6];
                  case 1:
                    return coin.weekdays[5];
                  case 2:
                    return coin.weekdays[4];
                  case 3:
                    return coin.weekdays[3];
                  case 4:
                    return coin.weekdays[2];
                  case 5:
                    return coin.weekdays[1];
                  case 6:
                    return coin.weekdays[0];
                }
                return '';
              },
            ),
          ),
          maxX: 6,
          minX: 0,
          maxY: coin.rateList.reduce(max),
          minY: coin.rateList.reduce(min) * 0.9,
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, coin.rateList[0]),
                FlSpot(1, coin.rateList[1]),
                FlSpot(2, coin.rateList[2]),
                FlSpot(3, coin.rateList[3]),
                FlSpot(4, coin.rateList[4]),
                FlSpot(5, coin.rateList[5]),
                FlSpot(6, coin.rateList[6]),
              ],
              isCurved: true,
              colors: [
                kcGradationStart,
                kcGradationMiddle,
                kcGradationEnd,
              ],
              colorStops: [
                0.1,
                0.6,
                0.9,
              ],
              barWidth: 10.0,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///TODO
///※だいぶ遅れてきたので他の作業はやらない
