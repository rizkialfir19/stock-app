class EnvConfig {
  static const BASE_PROD_URL = String.fromEnvironment(
    'https://finnhub.io/api/v1/stock/',
    defaultValue: 'https://finnhub.io/api/v1/',
  );

  // Can add Staging or Dev URL here

  static const OPEN_API_KEY = String.fromEnvironment(
    'c6skm0qad3ie4g2fjh40',
    defaultValue: 'c6skm0qad3ie4g2fjh40',
  );
}
