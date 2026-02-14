import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class AuthApiService {
  final String _baseUrl = 'http://10.0.2.2:3000';

  Future<Uint8List> fetchUI(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl$endpoint'));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load UI: ${response.statusCode}');
    }
  }

  Future<bool> register(Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<bool> login(Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return response.statusCode == 200;
  }
}
