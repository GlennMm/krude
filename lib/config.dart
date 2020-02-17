class Config {
  final String address = '10.0.2.2';
  String baseUrl;

  Config() {
    baseUrl = "https://$address:5001/api";
  }
}
