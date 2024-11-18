import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../services/api_service.dart';
import '../models/market_overview.dart';

class MarketOverviewScreen extends StatefulWidget {
  const MarketOverviewScreen({Key? key}) : super(key: key);

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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Market Overview'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: FutureBuilder<MarketOverview>(
        future: _marketOverview,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final marketData = snapshot.data!;
            final double totalMarketCap = double.tryParse(marketData.totalMarketCap.toString()) ?? 0.0;
            final double top10MarketCap = double.tryParse(marketData.top10MarketCap.toString()) ?? 0.0;
            final double percentageTop10 = totalMarketCap > 0 ? (top10MarketCap / totalMarketCap) : 0.0;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'As on: ${marketData.asOnDate}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Horizontal Circles
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircularDataWidget(
                              title: 'Total Companies',
                              value: marketData.totalCompanies.toString(),
                              percentage: 1.0,
                              color: Colors.blueAccent,
                            ),
                            CircularDataWidget(
                              title: 'Total Market Cap',
                              value: '₹${marketData.totalMarketCap} Cr',
                              percentage: 1.0,
                              color: Colors.green,
                            ),
                            CircularDataWidget(
                              title: 'Top 10 Market Cap',
                              value: '₹${marketData.top10MarketCap} Cr',
                              percentage: percentageTop10,
                              color: Colors.orange,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Top 10 Companies Table
                  Expanded(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Top 10 Companies',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: SingleChildScrollView(
                                child: DataTable(
                                  columns: const [
                                    DataColumn(label: Text('Rank')),
                                    DataColumn(label: Text('Name')),
                                    DataColumn(label: Text('Market Cap')),
                                  ],
                                  rows: List<DataRow>.generate(
                                    marketData.top10Companies.length,
                                        (index) {
                                      final company = marketData.top10Companies[index];
                                      return DataRow(cells: [
                                        DataCell(Text((index + 1).toString())), // Rank starts from 1
                                        DataCell(Text(company.symbol ?? 'Unknown')),
                                        DataCell(Text('₹${company.marketCap}')),
                                      ]);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

class CircularDataWidget extends StatelessWidget {
  final String title;
  final String value;
  final double percentage;
  final Color color;

  const CircularDataWidget({
    required this.title,
    required this.value,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircularPercentIndicator(
            radius: 80.0,
            lineWidth: 8.0,
            percent: percentage.clamp(0.0, 1.0),
            center: Text(
              '${(percentage * 100).toStringAsFixed(1)}%',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.grey[300]!,
            progressColor: color,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
