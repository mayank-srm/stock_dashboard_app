class MarketOverview {
  final String asOnDate;
  final int totalCompanies;
  final double totalMarketCap;
  final double top10MarketCap;
  final List<TopCompany> top10Companies;

  MarketOverview({
    required this.asOnDate,
    required this.totalCompanies,
    required this.totalMarketCap,
    required this.top10MarketCap,
    required this.top10Companies,
  });

  factory MarketOverview.fromJson(Map<String, dynamic> json) {
    return MarketOverview(
      asOnDate: json['as_on_date'] ?? '',
      totalCompanies: json['total_companies'] as int,
      totalMarketCap: (json['total_market_cap'] as num).toDouble(), // Parse as double
      top10MarketCap: (json['top_10_market_cap'] as num).toDouble(), // Parse as double
      top10Companies: (json['top_10_companies'] as List)
          .map((company) => TopCompany.fromJson(company))
          .toList(),
    );
  }
}

class TopCompany {
  final String symbol;
  final String companyName;
  final double marketCap;

  TopCompany({
    required this.symbol,
    required this.companyName,
    required this.marketCap,
  });

  factory TopCompany.fromJson(Map<String, dynamic> json) {
    return TopCompany(
      symbol: json['symbol'] ?? 'Unknown',
      companyName: json['name'] ?? 'Unknown',
      marketCap: (json['market_cap'] as num).toDouble(), // Parse as double
    );
  }
}
