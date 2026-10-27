/// Backend / network constants.
///
/// The backend is not final yet (it must work in China without a VPN),
/// so everything here is a placeholder. Change the values once the
/// backend is chosen. The rest of the app only reads from this file.
class ApiConstants {
  ApiConstants._();

  // ---------------------------------------------------------------------------
  // Base URLs
  // ---------------------------------------------------------------------------
  static const String baseUrl = 'https://api.example.com'; // TODO: set backend
  static const String apiVersion = 'v1';
  static const String apiUrl = '$baseUrl/$apiVersion';

  // ---------------------------------------------------------------------------
  // Endpoints (live features)
  // ---------------------------------------------------------------------------
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  static const String schedule = '/schedule';
  static const String news = '/news';
  static const String cleaningDuty = '/duty/cleaning';
  static const String mastersOnDuty = '/duty/masters';
  static const String notifications = '/notifications';
  static const String registerDevice = '/notifications/device';

  // ---------------------------------------------------------------------------
  // Timeouts
  // ---------------------------------------------------------------------------
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 20);
  static const Duration sendTimeout = Duration(seconds: 20);

  // ---------------------------------------------------------------------------
  // Headers
  // ---------------------------------------------------------------------------
  static const String headerContentType = 'Content-Type';
  static const String headerAuthorization = 'Authorization';
  static const String headerAcceptLanguage = 'Accept-Language';
  static const String contentTypeJson = 'application/json';
  static const String bearerPrefix = 'Bearer ';

  // ---------------------------------------------------------------------------
  // HTTP status codes
  // ---------------------------------------------------------------------------
  static const int statusOk = 200;
  static const int statusCreated = 201;
  static const int statusNoContent = 204;
  static const int statusBadRequest = 400;
  static const int statusUnauthorized = 401;
  static const int statusForbidden = 403;
  static const int statusNotFound = 404;
  static const int statusServerError = 500;

  // ---------------------------------------------------------------------------
  // Caching (last known live data is stored for offline use)
  // ---------------------------------------------------------------------------
  static const Duration scheduleCacheDuration = Duration(hours: 6);
  static const Duration newsCacheDuration = Duration(hours: 1);
  static const Duration dutyCacheDuration = Duration(hours: 12);
}
