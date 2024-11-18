import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/market_overview.dart';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8000'; // Update to your backend URL if hosted

  Future<MarketOverview> fetchMarketOverview() async {
    final response = await http.get(Uri.parse('$baseUrl/market-overview'));
    if (response.statusCode == 200) {
      return MarketOverview.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch market overview');
    }
  }
}
