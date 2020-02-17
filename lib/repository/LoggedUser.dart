import 'dart:io';

import 'package:dio/dio.dart';
import 'package:krude_digital/config.dart';
import 'package:krude_digital/models/UserModel.dart';
import 'package:krude_digital/repository/Interface/ILoggedUSer.dart';

class LoggedInUserRepository implements ILoggedUser {
  Dio _dio = new Dio();
  Config _config = new Config();

  LoggedInUserRepository() {
    _dio.onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };
  }

  @override
  UserModel loggedInUser;

  @override
  Future<bool> login(String username, String password) async {
    bool success;
    // await this
    //     ._dio
    //     .post(_config.baseUrl +
    //         '/MobileAppApi/Login?username=${username.toLowerCase().trim()}&password=${password.toLowerCase().trim()}')
    //     .then((result) {
    //   loggedInUser = new UserModel.fromJson(result.data);
    //   return true;
    // }).catchError((error) {
    //   print(error);
    //   return false;
    // }).timeout(Duration(seconds: 30));
    loggedInUser = new UserModel(
        accountID: 10004,
        username: "COMP2",
        accountTypeID: 0,
        countryId: 132,
        email: 'comp2@gmail.com',
        message: 'success',
        userId: '0a0fedf4-e344-4c64-883f-4ea0b285906e');
    return true;
  }

  @override
  signUpCompany(FormData form) async {
    // implement signup
    await this
        ._dio
        .post(_config.baseUrl + '/MobileAppAPi/SignUpIndividual', data: form)
        .then((result) {
      print(result.data);
      return result.data;
    }).catchError((error) {
      print(error);
    }).timeout(Duration(seconds: 30));
  }

  @override
  signUpIndividual(FormData form) async {
    // implemention signup
    await this
        ._dio
        .post(_config.baseUrl + '/MobileAppAPi/SignUpIndividual', data: form)
        .then((result) {
      print(result.data);
      return result.data;
    }).catchError((error) {
      return error;
    }).timeout(Duration(seconds: 30));
  }

  @override
  signUpVendor(FormData form) async {
    // implemention signup
    await _dio
        .post(_config.baseUrl + '/MobileAppAPi/SignUpIndividual', data: form)
        .then((result) {
      print(result.data);
      return result.data;
    }).catchError((error) {
      print(error);
    }).timeout(Duration(seconds: 30));
    return null;
  }
}
