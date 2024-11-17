import 'package:flutter/material.dart';
import 'screens/market_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Market Overview',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MarketOverviewScreen(),
    );
  }
}
