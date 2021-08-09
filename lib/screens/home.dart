import 'package:flutter/material.dart';
import 'package:my_coin_checker/constraints.dart';
import 'package:provider/provider.dart';
import 'package:my_coin_checker/controller.dart';
import 'package:my_coin_checker/widgets/coin_card.dart';
import 'package:my_coin_checker/widgets/ios_bottom_sheet.dart';
import 'package:my_coin_checker/widgets/android_bottom_sheet.dart';
import 'dart:io' show Platform;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    return Consumer<Controller>(builder: (_, controller, child) {
      return Scaffold(
        backgroundColor: kcLightGray,
        appBar: AppBar(
          backgroundColor: kcLightGray,
          elevation: 0.0,
          centerTitle: false,
          title: Text(
            'Crypto Chart',
            style: _textTheme.headline3!
                .copyWith(color: kcBlack, fontFamily: 'Montserrat'),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.listCount,
                itemBuilder: (context, index) {
                  return CoinCard(
                    textTheme: _textTheme,
                    coin: controller.getCoinList[index],
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kcLightBlue,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (_) => Platform.isIOS
                  ? const IosBottomSheet()
                  : const AndroidBottomSheet(),
            );
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
