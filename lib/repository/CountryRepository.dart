import 'dart:io';

import 'package:dio/dio.dart';
import 'package:krude_digital/config.dart';
import 'package:krude_digital/models/Country.dart';
import 'package:krude_digital/repository/Interface/ICountryRepository.dart';

class CountryRepository implements ICountryRepository {
  Dio _dio = new Dio();
  Config _config = new Config();
  List<Country> _countries = new List<Country>();
  List<Country> get countries => _countries;

  CountryRepository() {
     _dio.onHttpClientCreate = (HttpClient client) {
       client.badCertificateCallback =
           (X509Certificate cert, String host, int port) {
         return true;
       };
     };
     getActiveCountries();
  }

  @override
  getActiveCountries() async {
    this._countries = [];
     await _dio
         .get(_config.baseUrl + '/Countries/GetActiveCountries')
         .then((data) async {
       var mList = await data.data as List;
       mList.forEach((f) {
         Country c = new Country.fromJson(f);
         this._countries.add(c);
       });
     }).catchError((error) {
       print(error.toString());
     });
  }

  @override
  Future getAllCountries() async {
    this._countries = [];
    await _dio
        .get(_config.baseUrl + '/Countries/GetAllCountries')
        .then((data) async {
      var mList = await data.data as List;
      mList.forEach((f) {
        Country c = new Country.fromJson(f);
        this._countries.add(c);
      });
    }).catchError((error) {
      // return error;
    });
  }
}
