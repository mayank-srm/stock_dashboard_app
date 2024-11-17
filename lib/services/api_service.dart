import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/market_overview.dart';

class ApiService {
  static const String _baseUrl = 'http://127.0.0.1:8000';

  Future<MarketOverview> fetchMarketOverview() async {
    final response = await http.get(Uri.parse('$_baseUrl/market-overview'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MarketOverview.fromJson(data);
    } else {
      throw Exception('Failed to fetch market overview data');
    }
  }
}
