import 'package:flutter/material.dart';
import 'screens/market_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Market Dashboard',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: MarketOverviewScreen(),
    );
  }
}
