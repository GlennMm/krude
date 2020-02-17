import 'dart:io';

import 'package:dio/dio.dart';
import 'package:krude_digital/config.dart';
import 'package:krude_digital/models/ClientProduct.dart';
import 'package:krude_digital/models/Summary.dart';
import 'package:krude_digital/repository/Interface/IClientProduct.dart';

class ClientProductRepository implements IClientProduct {
  Dio _dio = new Dio();
  Config _config = new Config();
  List<ClientProduct> clientProducts = [];
  List<Summary> summaryList = [];

  ClientProductRepository() {
    _dio.onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };
  }

  @override
  getBalance(int accountId, int countryId, int productTypeId) async {
    // todo implemention of getBalance
   await _dio.get(_config.baseUrl + '/ClientProduct/GetBalance?accountId=$accountId&countryId=$countryId&productTypeId=$productTypeId').then((result){
     this.summaryList.clear();
     result.data.forEach((item){
       summaryList.add(new Summary.fromJson(item));
     });
     print(summaryList.length);
   }).catchError((err){
     print(err);
   });
  }

  @override
  getProductSumBalance() {
    // to: implement getProductSumBalance
    return null;
  }

  @override
  getSubAccountBalance() async {
    // TODO: implement getSubAccountBalance
    await _dio.get(_config.baseUrl + '/ClientProduct/GetSubAccountBalance').then((response)=>{
      print(response.data)
    }).catchError((err)=>{
      print(err)
    });
  }

  @override
  getSubaccountProductTotal() {
    // TODO: implement getSubaccountProductTotal
    return null;
  }
}
