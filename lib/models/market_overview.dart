class MarketOverview {
  final String asOnDate;
  final String totalCompanies;
  final String totalMarketCap;
  final String top10MarketCap;

  MarketOverview({
    required this.asOnDate,
    required this.totalCompanies,
    required this.totalMarketCap,
    required this.top10MarketCap,
  });

  factory MarketOverview.fromJson(Map<String, dynamic> json) {
    return MarketOverview(
      asOnDate: json['as_on_date'],
      totalCompanies: json['total_companies'],
      totalMarketCap: json['total_market_cap'],
      top10MarketCap: json['top_10_market_cap'],
    );
  }
}
