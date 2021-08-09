import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_coin_checker/constraints.dart';
import 'package:provider/provider.dart';
import 'package:my_coin_checker/controller.dart';
import 'package:my_coin_checker/models/repo.dart';

class AndroidBottomSheet extends StatefulWidget {
  const AndroidBottomSheet({Key? key}) : super(key: key);

  @override
  State<AndroidBottomSheet> createState() => _AndroidBottomSheetState();
}

class _AndroidBottomSheetState extends State<AndroidBottomSheet> {
  String cryptoDropdownValue = 'BTC';
  String currencyDropdownValue = 'JPY';

  DropdownButton<String> cryptoDropdown() {
    return DropdownButton(
      value: cryptoDropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: kcLightBlue),
      underline: Container(
        height: 2,
        color: kcLightBlue,
      ),
      onChanged: (String? newValue) {
        setState(() {
          cryptoDropdownValue = newValue!;
        });
      },
      items: Repository.cryptoList.map((String name) {
        return DropdownMenuItem(value: name, child: Text(name));
      }).toList(),
    );
  }

  DropdownButton<String> currencyDropdown() {
    return DropdownButton(
      value: currencyDropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: kcLightBlue),
      underline: Container(
        height: 2,
        color: kcLightBlue,
      ),
      onChanged: (String? newValue) {
        setState(() {
          currencyDropdownValue = newValue!;
        });
      },
      items: Repository.currenciesList.map((String name) {
        return DropdownMenuItem(value: name, child: Text(name));
      }).toList(),
    );
  }

  void showLoadingCircle() {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(builder: (_, controller, child) {
      return Container(
        color: const Color(0xff6F6F71),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            color: kcLightGray,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Crypto',
                    style: TextStyle(color: kcBlack, fontSize: 20.0),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  cryptoDropdown(),
                ],
              ),
              const SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Currency',
                    style: TextStyle(color: kcBlack, fontSize: 20.0),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  currencyDropdown(),
                ],
              ),
              const SizedBox(
                height: 40.0,
              ),
              ElevatedButton(
                  onPressed: () async {
                    print(
                        '$cryptoDropdownValue $currencyDropdownValue Start Search!');

                    showLoadingCircle();
                    await controller.createNewModel(
                        cryptoDropdownValue, currencyDropdownValue);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (_) => false);
                  },
                  child: const Text('ADD CRYPTO')),
            ],
          ),
        ),
      );
    });
  }
}
