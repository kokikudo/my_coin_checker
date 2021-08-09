import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_coin_checker/constraints.dart';
import 'package:provider/provider.dart';
import 'package:my_coin_checker/controller.dart';
import 'package:my_coin_checker/models/repo.dart';

class IosBottomSheet extends StatefulWidget {
  const IosBottomSheet({Key? key}) : super(key: key);

  @override
  State<IosBottomSheet> createState() => _IosBottomSheetState();
}

class _IosBottomSheetState extends State<IosBottomSheet> {
  String cryptoValue = 'BTC';
  String currencyValue = 'JPY';

  CupertinoPicker cryptoDropdown(List<String> cryptoList) {
    return CupertinoPicker(
      itemExtent: 30.0,
      onSelectedItemChanged: (index) {
        setState(() {
          cryptoValue = cryptoList[index];
        });
      },
      children: cryptoList.map((String cryptoName) {
        return Text(
          cryptoName,
          style: kIosDropdownItemText,
        );
      }).toList(),
    );
  }

  CupertinoPicker currencyDropdown(List<String> currencyList) {
    return CupertinoPicker(
      scrollController: FixedExtentScrollController(initialItem: 10),
      itemExtent: 30.0,
      onSelectedItemChanged: (index) {
        setState(() {
          currencyValue = currencyList[index];
        });
      },
      children: currencyList.map((String currencyName) {
        return Text(
          currencyName,
          style: kIosDropdownItemText,
        );
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
            child: CupertinoActivityIndicator(
              animating: true,
              radius: 50,
            ),
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Select Crypto',
                style: TextStyle(fontSize: 25, color: kcLightBlue),
              ),
              Expanded(
                child: cryptoDropdown(Repository.cryptoList),
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Text(
                'Select Currency',
                style: TextStyle(fontSize: 25, color: kcLightBlue),
              ),
              Expanded(
                child: currencyDropdown(Repository.currenciesList),
              ),
              const SizedBox(
                height: 30.0,
              ),
              CupertinoButton(
                  color: kcLightBlue,
                  child: const Text('ADD CRYPTO'),
                  onPressed: () async {
                    print('$cryptoValue, $currencyValue');
                    showLoadingCircle();
                    await controller.createNewModel(cryptoValue, currencyValue);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (_) => false);
                  })
            ],
          ),
        ),
      );
    });
  }
}
