import 'dart:convert';
import 'package:http/http.dart' as http;
import '../const/api_const.dart';
import '../models/all_country_list.dart';

class ApiService {
  Future<List<AllCountryList>> fetchAllCountry() async {
    final response = await http.get(Uri.parse("${ApiConst.baseUrl}all"));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => AllCountryList.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load the api');
    }
  }
}
