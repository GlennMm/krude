import 'dart:io';
import "package:collection/collection.dart";

import 'package:dio/dio.dart';
import 'package:krude_digital/config.dart';

import '../models/ProductPrice.dart';
import 'package:krude_digital/repository/Interface/IProductPrices.dart';

class ProductPricesRepository implements IProductPrices {
  Dio _dio = new Dio();
  Config _config = new Config();

  ProductPricesRepository() {
    _dio.onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };
    getAll();
  }

  List<ProductPrice> productPrices = [];
  Map groupedCountry;

  @override
  getAll() async {
    // implemention getAll
    await _dio.get(_config.baseUrl + '/ProductPrices/GetAll').then((response) {
      response.data.forEach((i) => {productPrices.add(ProductPrice.fromJson(i))});
      groupedCountry = groupBy(productPrices, (ProductPrice i) => i.country.countryNameAbrev);
      return print("fetched all product prices countries");
    }).catchError((error) {
      return print(error);
    });
  }

  @override
  getProductGroupedPrices() async {
    // TODO: implement getProductGroupedPrices
  }

  @override
  updatePrice(ProductPrice productPrice) {
    // TODO: implement updatePrice [post request]
    _dio
        .post(_config.baseUrl + "/ProductPrices/UpdatePrice",
            data: productPrice)
        .then((result) {
      print(result.data);
    }).catchError((error) {
      print(error);
    });
    return null;
  }

  @override
  updateProductPrice(
      int productPriceId, int productId, int countryId, double price) {
    // TODO: implement updateProductPrice [get request]
    _dio.get(_config.baseUrl + "/ProductPrices/UpdateProductPrice", data: {
      productPriceId: productPriceId,
      productId: productId,
      countryId: countryId,
      price: price
    }).then((result) {
      print(result.data);
    }).catchError((error) {
      print(error);
    });
    return null;
  }
}
