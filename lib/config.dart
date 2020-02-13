class Config {
  final String address = '192.168.100.156';
  String baseUrl;

  Config() {
    baseUrl = "https://$address:5001/api";
  }
}
