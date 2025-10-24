/// 🌐 API Constants - API sabitleri
///
/// Bu dosya, API endpoint'leri ve HTTP sabitlerini içerir.
class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://api.seboagency.com';
  static const String stagingUrl = 'https://staging-api.seboagency.com';
  static const String devUrl = 'https://dev-api.seboagency.com';

  // API Versions
  static const String apiVersion = 'v1';
  static const String apiPrefix = '/api/$apiVersion';

  // Endpoints
  static const String projectsEndpoint = '$apiPrefix/projects';
  static const String aboutEndpoint = '$apiPrefix/about';
  static const String contactEndpoint = '$apiPrefix/contact';
  static const String conferencesEndpoint = '$apiPrefix/conferences';

  // HTTP Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static const Map<String, String> authHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ',
  };

  // HTTP Status Codes
  static const int ok = 200;
  static const int created = 201;
  static const int noContent = 204;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int internalServerError = 500;

  // Timeout Durations
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // Retry Configuration
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // File Upload
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedImageTypes = [
    'image/jpeg',
    'image/png',
    'image/webp',
  ];

  // Private constructor - Bu sınıf instantiate edilemez
  ApiConstants._();
}
