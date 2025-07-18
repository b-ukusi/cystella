import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = 'http://192.168.100.249:8000/api/auth';

  Future<Map<String, dynamic>> register({
  required String email,
  required String first_name,
  required String last_name,
  required String contactno,
  required String date_of_birth,
  required String password,
}) async {
  try {
    final url = Uri.parse('$baseUrl/register/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'first_name': first_name,
        'last_name': last_name,
        'contactno': contactno,
        'date_of_birth': date_of_birth,
        'password': password,
      }),
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      await _saveTokens(data['access'], data['refresh']);
      return {
        'success': true,
        'message': 'Registration successful'
      };
    } else {
      final error = jsonDecode(response.body);
      return {
        'success': false,
        'message': error['message'] ?? error.toString()
      };
    }
  } catch (e) {
    return {
      'success': false,
      'message': 'An unexpected error occurred: $e'
    };
  }
}


  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/login/');
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await _saveTokens(data['access'], data['refresh']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> _saveTokens(String access, String refresh) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', access);
    await prefs.setString('refresh_token', refresh);
  }

  Future<void> testConnection() async {
    final url = Uri.parse('http://192.168.8.164:8000/api/test/');
    try {
      await http.get(url).timeout(const Duration(seconds: 10));
    } catch (_) {
      // Optional: handle error silently
    }
  }

  Future<String?> sendChatMessage(String message) async {
    final url = Uri.parse('$baseUrl/chat/'); // my Django chat endpoint

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['reply'];
      } else {
        return 'Something went wrong. Try again.';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
  Future<List<Map<String, dynamic>>> getDoctorMessages(String email) async {
   
    try {
      final cleanEmail = email.trim();
      final url = Uri.parse('$baseUrl/messages/$cleanEmail/');
      final response = await http.get(url);
      print("🛰️ GET $url");
      print("📥 Response Status: ${response.statusCode}");
      print("📥 Response Body: ${response.body}");


      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        print('❌ Failed to load messages: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('❌ Error loading messages: $e');
      return [];
    }
  }
}
