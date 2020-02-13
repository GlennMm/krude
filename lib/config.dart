class Config {
  final String address = '192.168.100.152';
  String baseUrl;

  Config() {
    baseUrl = "https://$address:5001/api";
  }
}
