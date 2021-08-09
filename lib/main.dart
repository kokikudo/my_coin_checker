import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'package:provider/provider.dart';
import 'controller.dart';
import 'constraints.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Controller(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: _buildAppTheme(),
        home: const HomeScreen(),
        routes: {
          '/home': (BuildContext context) => const HomeScreen(),
        },
      ),
    );
  }
}

ThemeData _buildAppTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: kcLightBlue,
      onPrimary: kcLightGray,
    ),
    cardTheme: _buildCardTheme(base.cardTheme),
    textTheme: _buildTextTheme(base.textTheme),
    //bottomSheetTheme:
  );
}

CardTheme _buildCardTheme(CardTheme base) {
  return base.copyWith(
      elevation: 20.0,
      color: kcLightBlue,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      )));
}

// IconTheme _buildIconTheme(IconTheme base) {
//   return base.copyWith(
//
//   );
// }

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline2: base.headline2!.copyWith(), //
        headline3: base.headline3!
            .copyWith(fontWeight: FontWeight.w300), //nowChartValue, title
        headline4: base.headline4!.copyWith(), //max/minChartValue
        headline5: base.headline5!.copyWith(), //above title
        subtitle1: base.subtitle1!.copyWith(), //% units
      )
      .apply(
          fontFamily: 'Lato',
          displayColor: kcLightGray,
          bodyColor: kcLightGray);
}
