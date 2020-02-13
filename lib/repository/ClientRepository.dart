import 'dart:io';

import 'package:dio/dio.dart';
import 'package:krude_digital/config.dart';
import 'package:krude_digital/repository/Interface/IClient.dart';

class ClientRepository implements IClient {

  Dio _dio = new Dio();
  Config _config = new Config();

  ClientRepository() {
     _dio.onHttpClientCreate = (HttpClient client) {
       client.badCertificateCallback =
           (X509Certificate cert, String host, int port) {
         return true;
       };
     };
  }

  @override
  searchClient() {
    // TODO: implement searchClient
    return null;
  }

}