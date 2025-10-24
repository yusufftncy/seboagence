/// 🌐 API Service - API servisi
///
/// Bu servis, HTTP isteklerini yönetir.
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';

class ApiService {
  final http.Client _client;
  final String _baseUrl;

  ApiService(this._client, {String? baseUrl})
    : _baseUrl = baseUrl ?? ApiConstants.baseUrl;

  /// GET isteği gönder
  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      final response = await _client
          .get(uri, headers: ApiConstants.defaultHeaders)
          .timeout(ApiConstants.connectTimeout);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// POST isteği gönder
  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      final response = await _client
          .post(
            uri,
            headers: ApiConstants.defaultHeaders,
            body: jsonEncode(data),
          )
          .timeout(ApiConstants.connectTimeout);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Response'u işle
  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {};
      }

      try {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e) {
        throw FormatException('Invalid JSON response');
      }
    } else {
      throw HttpException(
        'HTTP ${response.statusCode}: ${response.reasonPhrase}',
      );
    }
  }

  /// Hatayı işle
  Exception _handleError(dynamic error) {
    if (error is SocketException) {
      return SocketException('No internet connection');
    } else if (error is HttpException) {
      return error;
    } else if (error is FormatException) {
      return error;
    } else {
      return Exception('Unknown error: $error');
    }
  }

  /// Servisi kapat
  void dispose() {
    _client.close();
  }
}
