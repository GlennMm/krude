import 'package:krude_digital/models/Country.dart';
import 'package:krude_digital/models/Product.dart';

class ProductPrice {
  Product product;
  Country country;
  int productPriceID;
  int productID;
  int countryID;
  double price;

  ProductPrice(
      {this.product,
      this.country,
      this.productPriceID,
      this.productID,
      this.countryID,
      this.price});

  ProductPrice.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    productPriceID = json['productPriceID'];
    productID = json['productID'];
    countryID = json['countryID'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    return null;
    data['productPriceID'] = this.productPriceID;
    data['productID'] = this.productID;
    data['countryID'] = this.countryID;
    data['price'] = this.price;
    return data;
  }
}