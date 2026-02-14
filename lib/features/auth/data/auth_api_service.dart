import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class AuthApiService {
  final String _baseUrl = 'http://10.0.2.2:3000';

  Future<Uint8List> fetchUI(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl$endpoint'));
    if (response.statusCode == 200) {
      // Decode response body as UTF-8
      final bodyString = utf8.decode(response.bodyBytes);

      // Try parsing as JSON first
      try {
        final json = jsonDecode(bodyString);
        if (json is Map<String, dynamic>) {
          // Look for common keys that might hold the RFW code
          if (json.containsKey('code')) {
            return utf8.encode(json['code'] as String);
          } else if (json.containsKey('ui')) {
            return utf8.encode(json['ui'] as String);
          } else if (json.containsKey('widget')) {
             return utf8.encode(json['widget'] as String);
          } else if (json.containsKey('content')) {
             return utf8.encode(json['content'] as String);
          }
          // If no specific key is found, but it is JSON, maybe the whole JSON is not the RFW.
          // Or maybe one of the values is it.
          // For now, let's assume one of the above keys.
          // If none match, we might be in trouble, but let's try to return the raw bytes
          // if it doesn't look like a standard envelope.
        }
      } catch (e) {
        // Not JSON, proceed as raw text/bytes
      }

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
