import 'package:flutter/material.dart';
import 'package:my_coin_checker/constraints.dart';
import 'package:my_coin_checker/models/coin_model.dart';
import 'package:my_coin_checker/screens/chart.dart';

class CoinCard extends StatelessWidget {
  const CoinCard({
    Key? key,
    required this.textTheme,
    required this.coin,
  }) : super(key: key);

  final TextTheme textTheme;
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    final String _imageURLIconName = coin.name.toLowerCase();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChartScreen(
              coin: coin,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    color: kcIconBackground,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        kcIconGradationLeft,
                        kcIconGradationRight,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ).createShader(bounds),
                    child: Image.network(//$_imageURLIconName
                        'https://cryptoicons.org/api/white/$_imageURLIconName/600'),
                  ),
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          coin.name,
                          style: textTheme.headline5,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        coin.floatingValue,
                      ],
                    ),
                    Text(
                        '${coin.quote} ${coin.rateList.first.toStringAsFixed(1)}'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
