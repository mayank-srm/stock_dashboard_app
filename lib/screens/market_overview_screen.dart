import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../services/api_service.dart';
import '../models/market_overview.dart';

class MarketOverviewScreen extends StatefulWidget {
  @override
  _MarketOverviewScreenState createState() => _MarketOverviewScreenState();
}

class _MarketOverviewScreenState extends State<MarketOverviewScreen> {
  late Future<MarketOverview> _marketOverview;

  @override
  void initState() {
    super.initState();
    _marketOverview = ApiService().fetchMarketOverview();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Market Overview'),
        centerTitle: true,
      ),
      body: FutureBuilder<MarketOverview>(
        future: _marketOverview,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final marketData = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'As on: ${marketData.asOnDate}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: [
                        AnimatedDataCard(
                          title: 'Total Companies',
                          value: marketData.totalCompanies,
                          percentage: 1.0, // Static as it's not percentage-based
                          color: Colors.blue,
                        ),
                        AnimatedDataCard(
                          title: 'Total Market Cap',
                          value: '₹${marketData.totalMarketCap} Cr',
                          percentage: 0.75, // Example: 75% filled
                          color: Colors.green,
                        ),
                        AnimatedDataCard(
                          title: 'Top 10 Market Cap',
                          value: '₹${marketData.top10MarketCap} Cr',
                          percentage: 0.55, // Example: 55% filled
                          color: Colors.orange,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

class AnimatedDataCard extends StatelessWidget {
  final String title;
  final String value;
  final double percentage;
  final Color color;

  const AnimatedDataCard({
    required this.title,
    required this.value,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 8.0,
              percent: percentage,
              center: AnimatedContainer(
                duration: Duration(seconds: 1),
                child: Text(
                  '${(percentage * 100).toInt()}%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: color,
                  ),
                ),
              ),
              progressColor: color,
              backgroundColor: color.withOpacity(0.2),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
