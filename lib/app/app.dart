import 'package:flutter/material.dart';
import 'package:unii_test/features/coins/presentation/pages/coin_detail_page.dart';
import 'package:unii_test/features/coins/presentation/pages/coin_list_page.dart';

class UniiTestApp extends StatelessWidget {
  const UniiTestApp({super.key});

  static const String coinsRoute = '/coins';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unii Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        fontFamily: 'Roboto',
      ),
      initialRoute: coinsRoute,
      routes: <String, WidgetBuilder>{
        coinsRoute: (_) => const CoinListPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == CoinDetailPage.routeName &&
            settings.arguments is String) {
          return MaterialPageRoute<void>(
            builder: (_) => CoinDetailPage(coinId: settings.arguments! as String),
          );
        }
        return null;
      },
    );
  }
}
