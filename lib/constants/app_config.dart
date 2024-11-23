// ignore_for_file: constant_identifier_names

enum FlavorType { DEVELOPMENT, STAGING, PRODUCTION }

class AppConfig {
  final String appName;
  final FlavorType flavorType;
  final String baseUrl;
  final String appIcon;

  const AppConfig({
    required this.appName,
    this.flavorType = FlavorType.DEVELOPMENT,
    required this.baseUrl,
    required this.appIcon,
  });

  static late AppConfig _instance;

  static void initialize({
    required String appName,
    required FlavorType flavorType,
    required String baseUrl,
    required String appIcon,
  }) {
    _instance = AppConfig(
      appName: appName,
      flavorType: flavorType,
      baseUrl: baseUrl,
      appIcon: appIcon,
    );
  }

  static AppConfig get instance => _instance;
}
