class AppConstants {
  const AppConstants._();

  static const String baseUrl = 'https://api.coinranking.com';
  static const String apiVersion = '/v2';
  static const String apiKey = String.fromEnvironment('COINRANKING_API_KEY');
  static const int pageSize = 20;
  static const Duration requestTimeout = Duration(seconds: 20);
  static const Duration autoRefreshInterval = Duration(seconds: 10);
}
