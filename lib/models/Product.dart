class Product {
  int productID;
  String productName;
  String description;
  String measurement;
  bool isActive;

  Product(
      {this.productID,
      this.productName,
      this.description,
      this.measurement,
      this.isActive});

  Product.fromJson(Map<String, dynamic> json) {
    productID = json['productID'];
    productName = json['productName'];
    description = json['description'];
    measurement = json['measurement'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productID'] = this.productID;
    data['productName'] = this.productName;
    data['description'] = this.description;
    data['measurement'] = this.measurement;
    data['isActive'] = this.isActive;
    return data;
  }
}
