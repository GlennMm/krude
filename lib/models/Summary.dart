class Summary {
  int line;
  String productName;
  String countryName;
  String countryNameAbrev;
  String isoCode;
  double quantity;

  Summary(
      {this.line,
      this.productName,
      this.countryName,
      this.countryNameAbrev,
      this.isoCode,
      this.quantity});

  Summary.fromJson(Map<String, dynamic> json) {
    line = json['line'];
    productName = json['productName'];
    countryName = json['countryName'];
    countryNameAbrev = json['countryNameAbrev'];
    isoCode = json['isoCode'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['line'] = this.line;
    data['productName'] = this.productName;
    data['countryName'] = this.countryName;
    data['countryNameAbrev'] = this.countryNameAbrev;
    data['isoCode'] = this.isoCode;
    data['quantity'] = this.quantity;
    return data;
  }
}