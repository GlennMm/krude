import 'dart:io';
import 'package:dio/dio.dart';
import 'package:krude_digital/config.dart';
import 'package:krude_digital/models/Product.dart';
import 'package:krude_digital/repository/Interface/IProductsRepository.dart';

class ProductsRepository implements IProductsRepository {
  Dio _dio = new Dio();
  Config _config = new Config();

  List<Product> products = new List<Product>();

  ProductsRepository() {
    _dio.onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };
    getActiveProducts();
  }

  @override
  activateProduct() {
    // TODO: implement activateProduct
    return null;
  }

  @override
  getActiveProducts() async {
    // implement getActiveProducts
    await _dio.get(_config.baseUrl + '/products/getactiveproducts').then((response){
      products = [];
      response.data.forEach((item){
        products.add(new Product.fromJson(item));
      });
    }).catchError((err) {
      print(err.toString());
    });
  }

  @override
  getAll() {
    // implement getAll
    _dio.get(_config.baseUrl + '/products/getall').then((response){
      print(response.data);
    }).catchError((err) {
      print(err.toString());
    });
    return null;
  }

  @override
  getProductsInfo() {
    // TODO: implement getProductsInfo
    return null;
  }

  @override
  invertActivate() {
    // TODO: implement invertActivate
    return null;
  }

  @override
  saveProduct() {
    // TODO: implement saveProduct
    return null;
  }

  @override
  updateProduct() {
    // TODO: implement updateProduct
    return null;
  }


}
